
using Agents
using Random
using Distributions:Poisson

mutable struct Haploid <: AbstractAgent
    id::Int
    mutations::Int64
    fitness::Float64
end

function initialize(; popsize, S, U, seed=1)
    model = ABM(Haploid;
        properties=Dict(
            :popsize => popsize,
            :S => S,
            :U => U,
            :rng => MersenneTwister(seed)
        ),
        scheduler=Schedulers.fastest)
    for n in 1:popsize
        agent = Haploid(n, 0, 1.0)
        add_agent!(agent, model)
    end
    return model
end

function mutate!(agent, model)
    n = rand(model.rng, Poisson(model.U))
    agent.mutations += n
    agent.fitness *= (1 - model.S)^n
end

function select!(model)
    Agents.sample!(model, model.popsize, :fitness)
end

X₀(model) = sum([agent.mutations == 0 for agent in allagents(model)]) / model.popsize


function run_haigh_agents(p::Dict; replicates, generations)
    
    models = [initialize(; popsize=p[:N], U=p[:U], S=p[:S], seed=i) for i in 1:replicates]
    _, mdf = ensemblerun!(models, mutate!, select!, generations; parallel=true, mdata=[X₀], stop_when=model -> X₀(model) == 0.0)
    return mdf
end


function extinction_time(p::Dict; replicates = 100, max_generations = 1e7)

    sims = run_haigh_agents(p; replicates = replicates, generations = max_generations)
    extinction_times = [findfirst(==(0.), df.X₀) for df in groupby(sims, :ensemble)]
    
    too_short = (extinction_times .== nothing)
    any(too_short) && @warn "No extinction in $(sum(too_short)) replicates out of $(length(too_short)). Extend simulation time or change parameters."

    extinction_times[too_short] .= max_generations

    return (mean = mean(extinction_times), se = std(extinction_times)/ sqrt(length(extinction_times)))
end