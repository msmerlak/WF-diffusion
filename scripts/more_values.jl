using Distributed
addprocs(Sys.CPU_THREADS - 1)
@everywhere using DrWatson
@everywhere @quickactivate

using DataFrames, CSV
@everywhere include(srcdir("haigh-WF.jl"))

more_values = DataFrame(
        N = Int[],    
        U = Float64[],
        S = Float64[],
        T_m = Float64[],
        T_se = Float64[]
    )

for (S, U, N) in (
    (0.05,0.1, 100), 
    (0.05,0.1, 1000),
    (0.1,0.5, 5000),
    (0.1,0.5, 10000)
    )

    p = Dict(:S => S, :U => U, :N => N, :K => 20)
    @show p
    T = extinction_time(p)
    push!(more_values, [N, U, S, T.mean, T.se])
end
CSV.write(datadir("haigh-WF", "more_values.csv"), more_values)