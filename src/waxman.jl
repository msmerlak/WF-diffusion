using Distributions, Random

## selection function 
reproduction_selection(x::Float64, p::Dict) = x*(1-p[:u])/(1 - p[:s] + p[:s]*x)
viability_selection(x::Float64, p::Dict) = x*(1-p[:u])/(1 - p[:s] + p[:s]*(1-p[:u])*x)
## convert mutation rate and selection coeffs in Haigh's model to WF
function Haigh2WF!(p::Dict)
<<<<<<< Updated upstream
    p[:s] = (1. - exp.(-p[:U]))/(1. - exp.(-p[:U]/p[:S]))
=======
    p[:s] = p[:α]*(1. - exp.(-p[:U]))/(1. - exp.(-p[:U]/p[:S]))
>>>>>>> Stashed changes
    p[:u] = 1. - exp.(-p[:U])
end

## extinction time 
function run_waxman(p::Dict; seed = 1, max_generations = 1e7, SoverU = nothing)
    
    rng = MersenneTwister(seed)

    selection = p[:selection_type] == :reproduction ? reproduction_selection : viability_selection

    if SoverU !== nothing 
        p[:S] = SoverU * p[:U]
    end

    Haigh2WF!(p)
    x = p[:x₀]
    t = 0

    while x > 0 && t < max_generations
        x = rand(rng, Binomial(p[:N], selection(x, p)))/p[:N]
        t += 1
    end
    return t < max_generations ? t : Inf
end


function extinction_time(p::Dict; replicates = 10, kwargs...)
    times = pmap(seed -> run_waxman(p; seed = seed, kwargs...), 1:replicates)
    return (mean = mean(times), se = std(times)/sqrt(length(times)))
end
