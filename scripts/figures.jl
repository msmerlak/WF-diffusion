using DrWatson
@quickactivate

using CSV, DataFrames, StatsPlots
plot_font = "Computer Modern"
default(fontfamily=plot_font,
        linewidth=2, framestyle=:box, label=nothing, grid=false, dpi = 500)
using LaTeXStrings
using StatsBase

file = "extinction_N=100"
waxman_fixed_N = CSV.read(datadir("waxman", file *".csv"), DataFrame)
haigh_WF_fixed_N = CSV.read(datadir("haigh-WF", file *".csv"), DataFrame)

haigh_agents_fixed_N = CSV.read(datadir("haigh-agents", file *".csv"), DataFrame)


@df waxman_fixed_N scatter(
    :S, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Waxman",
    legend = :topleft,
    xlabel = L"S = 2U"
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
savefig(plotsdir(file *".png"))



file = "extinction_U=0.01_S=0.01"
waxman_fixed_S_U = CSV.read(datadir("waxman", file  *".csv"), DataFrame)
haigh_WF_fixed_S_U = CSV.read(datadir("haigh-WF", file *".csv"), DataFrame)
haigh_agents_fixed_S_U = CSV.read(datadir("haigh-agents", file *".csv"), DataFrame)


@df waxman_fixed_S_U scatter(
    :N, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Waxman",
    legend = :topleft,
    xlabel = L"N"
    )
@df haigh_agents_fixed_S_U scatter!(
:N, :T_m,
yerror = :T_se,
yaxis = :log,
groupby = :selection_type,
label = "Haigh-agents",
legend = :topleft
)

@df haigh_WF_fixed_S_U scatter!(
:N, :T_m,
    yerror = :T_se,
    yaxis = :log,
    groupby = :selection_type,
    label = "Haigh-WF",
    legend = :topleft
    )
savefig(plotsdir(file*".png"))
