using DifferentialEquations
using Plots

drift(x, p, t) = p[:s]*x*(1-x) + p[:u]*(1-x) - p[:v]*x
diffusion(x, p, t) = sqrt(max(x*(1-x), 0)/p[:N]) 

WFdiffusion(p; tmax = 10000.) = SDEProblem(drift, diffusion, p[:x₀], (0., tmax), p)

p = Dict{Symbol, Any}(:s => 1e-1, :u => 1e-2, :v => 1e-2, :x₀ => .5, :N => 50)
wf = WFdiffusion(p)

solve(wf) |> plot

#, isoutofdomain=(u,p,t) -> any(x -> x < 0 || x > 1, u)