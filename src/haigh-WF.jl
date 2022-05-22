using Distributions, Random

function selection(x, p)

    P = [sum(
        [x[1 + k-j]*(1-p[:S])^(k-j)*exp(-p[:U])*p[:U]^j/factorial(j) for j in 0:k]
    )
        for k in 0:p[:K]]
    return P/sum(P) 
end

## extinction time 
function run_haigh_WF(p::Dict; seed = 1, max_generations = 1e7, SoverU = nothing)
    
    rng = MersenneTwister(seed)

    if SoverU !== nothing
        p[:S] = SoverU * p[:U]
    end

    x = zeros(p[:K] + 1)
    x[1] = 1.
    t = 0

    while x[1] > 0. && t < max_generations
        x = rand(rng, Multinomial(p[:N], selection(x, p)))/p[:N]
        t += 1
    end
    
    return t < max_generations ? t : Inf
end


function extinction_time(p::Dict; replicates = 100, kwargs...)
    times = pmap(seed -> run_haigh_WF(p; seed = seed, kwargs...), 1:replicates)
    return (mean = mean(times), se = std(times)/sqrt(length(times)))
end
