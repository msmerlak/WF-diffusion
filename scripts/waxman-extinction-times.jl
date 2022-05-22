using Distributed
addprocs(Sys.CPU_THREADS - 1)
@everywhere using DrWatson
@everywhere @quickactivate
@everywhere include(srcdir("waxman.jl"))

using CSV, DataFrames, Statistics

MAX_GEN = Int(1e8)  
U_RANGE = .01:.02:.1
N_RANGE = 100:200:2000

# begin 
#     fixed_N = DataFrame(
#         N = Int[],
#         selection_type = [],    
#         U = Float64[],
#         S = Float64[],
#         T_m = Float64[],
#         T_se = Float64[]
#     )

#     N = 100
#     K = 20
#     for U in U_RANGE, selection_type in (:reproduction, :viability)
#         S = 2U
#         p = Dict(:N => N, :U => U, :S => S, :x₀ => .5, :selection_type => selection_type)
#         T = extinction_time(p; replicates = 100, max_generations = MAX_GEN)
#         @show T
#         push!(
#             fixed_N, [N, selection_type, U, S, T.mean, T.se]
#         )

#         CSV.write(datadir("waxman", "extinction_N=$N.csv"), fixed_N)
#     end
# end

begin 
    fixed_U_S = DataFrame(
        N = Int[],
        selection_type = [],    
        U = Float64[],
        S = Float64[],
        T_m = Float64[],
        T_se = Float64[]
    )

    S = .04
    U = 0.07
    for N in N_RANGE, selection_type in (:reproduction, :viability)
        p = Dict(:N => N, :U => U, :S => S, :x₀ => .5, :selection_type => selection_type)
        T = extinction_time(p; replicates = 100, max_generations = MAX_GEN)
        @show T
        push!(
            fixed_U_S, [N, selection_type, U, S, T.mean, T.se]
        )

        CSV.write(datadir("waxman", "extinction_U=$(U)_S=$S.csv"), fixed_U_S)
    end
end
