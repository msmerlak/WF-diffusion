using DrWatson
@quickactivate

using CSV, DataFrames, StatsPlots
plot_font = "Computer Modern"
default(fontfamily=plot_font,
        linewidth=2, framestyle=:box, label=nothing, grid=false)
using LaTeXStrings
using StatsBase

file = "extinction_N=100.csv"
waxman_fixed_N = CSV.read(datadir("waxman", file), DataFrame)
haigh_WF_fixed_N = CSV.read(datadir("haigh-WF", file), DataFrame)
haigh_agents_fixed_N = CSV.read(datadir("haigh-agents", file), DataFrame)


@df waxman_fixed_N scatter(
    :S, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Waxman",
    legend = :topleft
    )
@df haigh_agents_fixed_N scatter!(
:S, :T_m,
yerror = :T_se,
yaxis = :log,
groupby = :selection_type,
label = "Haigh-agents",
legend = :topleft
)

@df haigh_WF_fixed_N scatter!(
:S, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Haigh-WF",
    legend = :topleft
    )


file = "extinction_U=0.01_S=0.01.csv"
waxman_fixed_S_U = CSV.read(datadir("waxman", file), DataFrame)
haigh_WF_fixed_N = CSV.read(datadir("haigh-WF", file), DataFrame)
haigh_agents_fixed_N = CSV.read(datadir("haigh-agents", file), DataFrame)


@df waxman_fixed_N scatter(
    :S, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Waxman",
    legend = :topleft
    )
@df haigh_agents_fixed_N scatter!(
:S, :T_m,
yerror = :T_se,
yaxis = :log,
groupby = :selection_type,
label = "Haigh-agents",
legend = :topleft
)

@df haigh_WF_fixed_N scatter!(
:S, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Haigh-WF",
    legend = :topleft
    )