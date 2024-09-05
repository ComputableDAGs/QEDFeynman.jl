using QEDFeynman
using ComputableDAGs

function test_op_specific(estimator, graph, nr::NodeReduction)
    estimate = operation_effect(estimator, graph, nr)

    data_reduce = data(nr.input[1].task) * (length(nr.input) - 1)
    compute_effort_reduce = compute_effort(nr.input[1].task) * (length(nr.input) - 1)

    @test isapprox(estimate.data, -data_reduce; atol=eps(Float64))
    @test isapprox(estimate.computeEffort, -compute_effort_reduce)
    @test isapprox(estimate.computeIntensity, compute_effort_reduce / data_reduce)

    return nothing
end

function test_op_specific(estimator, graph, ns::NodeSplit)
    estimate = operation_effect(estimator, graph, ns)

    copies = length(ns.input.parents) - 1

    data_increase = data(ns.input.task) * copies
    compute_effort_increase = compute_effort(ns.input.task) * copies

    @test isapprox(estimate.data, data_increase; atol=eps(Float64))
    @test isapprox(estimate.computeEffort, compute_effort_increase)
    @test isapprox(estimate.computeIntensity, compute_effort_increase / data_increase)

    return nothing
end

function test_op(estimator, graph, op)
    estimate_before = graph_cost(estimator, graph)

    estimate = operation_effect(estimator, graph, op)

    push_operation!(graph, op)
    estimate_after_apply = graph_cost(estimator, graph)
    reset_graph!(graph)

    @test isapprox((estimate_before + estimate).data, estimate_after_apply.data)
    @test isapprox(
        (estimate_before + estimate).computeEffort, estimate_after_apply.computeEffort
    )
    @test isapprox(
        (estimate_before + estimate).computeIntensity, estimate_after_apply.computeIntensity
    )

    test_op_specific(estimator, graph, op)
    return nothing
end

@testset "Global Metric Estimator" for (graph_string, exp_data, exp_computeEffort) in
                                       zip(["AB->AB", "AB->ABBB"], [976, 10944], [53, 1075])
    estimator = GlobalMetricEstimator()

    @test cost_type(estimator) == CDCost

    proc = parse_process(graph_string, ABCModel())
    graph = parse_dag(joinpath(@__DIR__, "..", "input", "$(graph_string).txt"), proc)

    @testset "Graph Cost" begin
        estimate = graph_cost(estimator, graph)

        @test estimate.data == exp_data
        @test estimate.computeEffort == exp_computeEffort
        @test isapprox(estimate.computeIntensity, exp_computeEffort / exp_data)
    end

    @testset "Operation Cost" begin
        ops = get_operations(graph)
        nrs = copy(ops.nodeReductions)
        nss = copy(ops.nodeSplits)

        for nr in nrs
            test_op(estimator, graph, nr)
        end
        for ns in nss
            test_op(estimator, graph, ns)
        end
    end
end
