using DrWatson

using Distributed
addprocs(Sys.CPU_THREADS)

using DataFrames, CSV
using Plots; GR
plot_font = "Computer Modern"
default(fontfamily=plot_font,
        linewidth=2, framestyle=:box, label=nothing, grid=false)
using LaTeXStrings
using StatsBase
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

plot(
    [mean(df.N) for df in groupby(results, :N)],
    [mean(df.T) for df in groupby(results, :N)], 
    yerr = [sem(df.T) for df in groupby(results, :N)],
    yaxis = :log,
    xlabel = L"$N$", ylabel = "Extinction time"
    )

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

plot(
    [mean(df.S) for df in groupby(fixed_N, :S)],
    [mean(df.T) for df in groupby(fixed_N, :S)], 
    yerr = [sem(df.T) for df in groupby(fixed_N, :S)],
    yaxis = :log,
    xlabel = L"$S = 2U$", ylabel = "Extinction time"
    )