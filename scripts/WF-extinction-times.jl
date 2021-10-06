using DrWatson

using Distributed
addprocs(Sys.CPU_THREADS)

using DataFrames, CSV


include("../src/utils.jl")

@everywhere begin
    include("../src/wright-fisher.jl")
end

## fixed S, U
p = Dict{Symbol, Any}(
    :S => 1e-2, 
    :U => 1e-2, 
    :x₀ => .5, 
    :N => 100:100:2000, 
    :seed => 1:1000
    )
P = dict_list(map(collect, p))
results = pmap(WF_extinction, P) |> DataFrame

CSV.write(datadir("sims", savename("extinction", p, "csv")), results)


## fixed N = 100, vary S = 2U
p = Dict{Symbol, Any}(
    :U => 0.01:0.01:0.1, 
    :x₀ => .5, 
    :N => 100, 
    :seed => 1:1000
    )
P = dict_list(map(collect, p))
fixed_N = pmap(p -> WF_extinction(p; SoverU = 2.), P) |> DataFrame


CSV.write(datadir("sims", savename("extinction", p, "csv")), fixed_N)
