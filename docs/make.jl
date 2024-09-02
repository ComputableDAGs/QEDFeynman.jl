using Documenter
using QEDFeynman
using GraphComputing

makedocs(;
    #format = Documenter.LaTeX(platform=""),

    root="docs",
    source="src",
    build="build",
    warnonly=true,
    clean=true,
    doctest=true,
    modules=Module[QEDFeynman],
    remotes=nothing,
    sitename="QEDFeynman.jl",
    pages=[
        "index.md",
        "Manual" => "manual.md",
        "Library" => [
            "Public" => "lib/public.md",
            "Graph" => "lib/internals/graph.md",
            "Node" => "lib/internals/node.md",
            "Task" => "lib/internals/task.md",
            "Operation" => "lib/internals/operation.md",
            "Models" => "lib/internals/models.md",
            "Diff" => "lib/internals/diff.md",
            "Utility" => "lib/internals/utility.md",
            "Code Generation" => "lib/internals/code_gen.md",
            "Devices" => "lib/internals/devices.md",
        ],
        "Contribution" => "contribution.md",
    ],
)
