__precompile__(true)
module UnitfulIntegration

import Unitful: AbstractQuantity
import QuadGK: cachedrule, rulecache

# fix `cachedrule` until it is possible to extend Unitful with package extension https://github.com/JuliaLang/julia/pull/47695 (julia >= 1.10)

@generated function cachedrule(::Type{T}, n::Integer) where {T<:AbstractQuantity}
    TF = typeof(float(real(one(T))))
    cache = haskey(rulecache, TF) ? rulecache[TF] : (rulecache[TF] = Dict{Int,NTuple{3,Vector{TF}}}())
    :(haskey($cache, n) ? $cache[n] : ($cache[n] = kronrod($T, n)))
end


end # module
