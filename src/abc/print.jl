function Base.show(io::IO, proc::GenericABCProcess)
    print(io, "generic ABC process \"")
    for p in incoming_particles(proc)
        print(io, _particle_to_letter(p))
    end
    print(io, " -> ")
    for p in outgoing_particles(proc)
        print(io, _particle_to_letter(p))
    end
    print(io, "\"")
    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", proc::GenericABCProcess)
    print(io, "generic ABC process")
    for dir in (Incoming(), Outgoing())
        first = true
        println(io)
        for p in particles(proc, dir)
            if !first
                print(io, ", ")
            else
                print(io, "    $(dir): ")
                first = false
            end
            print(io, "$(p)")
        end
    end
    return nothing
end

"""
    show(io::IO, particle::ABCParticle)

Pretty print an [`ABCParticle`](@ref) (no newlines).
"""
function show(io::IO, particle::ABCParticle)
    print(io, "$(String(typeof(particle)))")
    return nothing
end
