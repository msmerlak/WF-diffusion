using Distributed
addprocs(Sys.CPU_THREADS - 1)
@everywhere using DrWatson
@everywhere @quickactivate
@everywhere include(srcdir("haigh-agents.jl"))

using CSV, DataFrames, Statistics

MAX_GEN = Int(1e8)
U_RANGE = .01:.02:.1
N_RANGE = 100:200:2000

# begin 
#     fixed_N = DataFrame(
#         N = Int[],    
#         U = Float64[],
#         S = Float64[],
#         T_m = Float64[],
#         T_se = Float64[]
#     )

#     N = 100
#     for U in U_RANGE
#         S = 2U
#         p = Dict(:N => N, :U => U, :S => S)
#         T = extinction_time(p; replicates = 100, max_generations = MAX_GEN)
#         @show T
#         push!(
#             fixed_N, [N, U, S, T.mean, T.se]
#         )

#         CSV.write(datadir("haigh-agents", "extinction_N=$N.csv"), fixed_N)
#     end
# end


begin 
    fixed_U_S = DataFrame(
        N = Int[],    
        U = Float64[],
        S = Float64[],
        T_m = Float64[],
        T_se = Float64[]
    )

    S = .04
    U = 0.07
    for N in N_RANGE
        p = Dict(:N => N, :U => U, :S => S)
        T = extinction_time(p; replicates = 100, max_generations = MAX_GEN)
        @show T
        push!(
            fixed_U_S, [N, U, S, T.mean, T.se]
        )

        CSV.write(datadir("haigh-agents", "extinction_U=$(U)_S=$S.csv"), fixed_U_S)
    end
end
