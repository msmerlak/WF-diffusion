import Base:map

function map(f::Any, d::Dict)
    fd = deepcopy(d)
    for (key, value) in d
        if typeof(value) <: AbstractRange
            fd[key] = f(d[key])
        end
    end
    return fd
end