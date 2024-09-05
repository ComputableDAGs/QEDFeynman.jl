using QEDFeynman
using ComputableDAGs
using QEDcore

import QEDFeynman.interaction_result

def_momentum = SFourMomentum(1.0, 0.0, 0.0, 0.0)

testparticles = [
    ParticleStateful(Incoming(), ParticleA(), def_momentum),
    ParticleStateful(Incoming(), ParticleB(), def_momentum),
    ParticleStateful(Incoming(), ParticleC(), def_momentum),
]

@testset "Interaction Result" begin
    for p1 in testparticles, p2 in testparticles
        if (p1 == p2)
            @test_throws AssertionError interaction_result(p1, p2)
        else
            @test particle_species(interaction_result(p1, p2)(def_momentum)) ==
                particle_species(setdiff(testparticles, [p1, p2])[1])
        end
    end
end

@testset "Vertex" begin
    @test isapprox(QEDFeynman.ABC_vertex(), 1 / 137.0)
end
