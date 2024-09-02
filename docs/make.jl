using Pkg

project_path = Base.Filesystem.joinpath(Base.Filesystem.dirname(Base.source_path()), "..")
Pkg.develop(; path=project_path)

using Documenter
using QEDFeynman

makedocs(;
    modules=[QEDFeynman],
    checkdocs=:exports,
    authors="Anton Reinhard",
    repo=Documenter.Remotes.GitHub("GraphComputing-jl", "QEDFeynman.jl"),
    sitename="QEDFeynman.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://graphcomputing.gitlab.io/QEDFeynman.jl",
        assets=String[],
        size_threshold_ignore=["index.md"],
    ),
    pages=["index.md"],
)
deploydocs(;
    repo="github.com/GraphComputing-jl/QEDFeynman.jl.git",
    push_preview=false,
    devbranch="main",
)
