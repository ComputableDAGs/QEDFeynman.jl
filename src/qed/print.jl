"""
    show(io::IO, particle::FeynmanParticle)

Pretty print a [`FeynmanParticle`](@ref) (no newlines).
"""
show(io::IO, p::FeynmanParticle) =
    print(io, "$(String(p.particle))_$(String(particle_direction(p.particle)))_$(p.id)")

"""
    show(io::IO, particle::FeynmanVertex)

Pretty print a [`FeynmanVertex`](@ref) (no newlines).
"""
show(io::IO, v::FeynmanVertex) = print(io, "$(v.in1) + $(v.in2) -> $(v.out)")

"""
    show(io::IO, particle::FeynmanTie)

Pretty print a [`FeynmanTie`](@ref) (no newlines).
"""
show(io::IO, t::FeynmanTie) = print(io, "$(t.in1) -- $(t.in2)")

"""
    show(io::IO, particle::FeynmanDiagram)

Pretty print a [`FeynmanDiagram`](@ref) (with newlines).
"""
function show(io::IO, d::FeynmanDiagram)
    print(io, "Initial Particles: [")
    first = true
    for p in d.particles
        if first
            first = false
            print(io, "$p")
        else
            print(io, ", $p")
        end
    end
    print(io, "]\n")
    for l in eachindex(d.vertices)
        print(io, "  Virtuality Level $l Vertices: [")
        first = true
        for v in d.vertices[l]
            if first
                first = false
                print(io, "$v")
            else
                print(io, ", $v")
            end
        end
        print(io, "]\n")
    end
    return print(io, "  Tie: $(d.tie[])\n")
end
