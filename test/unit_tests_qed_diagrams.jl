using QEDFeynman
using GraphComputing

using QEDcore

import QEDFeynman.gen_diagrams
import QEDFeynman.types

model = QEDModel()
compton = ("Compton Scattering", parse_process("ke->ke", model), 2)
compton_3 = ("3-Photon Compton Scattering", parse_process("kkke->ke", QEDModel()), 24)
compton_4 = ("4-Photon Compton Scattering", parse_process("kkkke->ke", QEDModel()), 120)

@testset "Known Processes" begin
    @testset "$name" for (name, process, n) in [compton, compton_3, compton_4]
        initial_diagram = FeynmanDiagram(process)
        n_particles =
            number_incoming_particles(process) + number_outgoing_particles(process)

        @test n_particles == length(initial_diagram.particles)
        @test ismissing(initial_diagram.tie[])
        @test isempty(initial_diagram.vertices)

        result_diagrams = gen_diagrams(initial_diagram)
        @test length(result_diagrams) == n

        for d in result_diagrams
            n_vertices = 0
            for vs in d.vertices
                n_vertices += length(vs)
            end
            @test n_vertices == n_particles - 2
            @test !ismissing(d.tie[])
        end
    end
end
