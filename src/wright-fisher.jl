using DrWatson
@quickactivate

using Distributions, Random

## selection function 
selection(x::Float64, p::Dict) = x*(1-p[:u])/(1 - p[:s] + p[:s]*x)

## convert mutation rate and selection coeffs in Haigh's model to WF
function Haigh2WF!(p::Dict)
    p[:s] = (1. - exp.(-p[:U]))/(1. - exp.(-p[:U]/p[:S]))
    p[:u] = 1. - exp.(-p[:U])
end


## exctinction time 
function WF_extinction(p::Dict; tmax = 1e7, SoverU = nothing)
    
    rng = MersenneTwister(p[:seed])

    if SoverU !== nothing 
        p[:S] = SoverU * p[:U]
    end

    Haigh2WF!(p)
    x = p[:x₀]
    t = 0
    
    while x > 0 && t < tmax
        x = rand(rng, Binomial(p[:N], selection(x, p)))/p[:N]
        t += 1
    end
    p[:T] = t < tmax ? t : Inf
    return p
end
        

