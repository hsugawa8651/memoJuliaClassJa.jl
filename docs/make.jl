using memoJuliaClassJa
using Documenter

makedocs(;
    modules=[memoJuliaClassJa],
    authors="Hiroharu Sugawara <hsugawa@gmail.com> and contributors",
    repo="https://github.com/hsugawa8651/memoJuliaClassJa.jl/blob/{commit}{path}#L{line}",
    sitename="memoJuliaClassJa.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hsugawa8651.github.io/memoJuliaClassJa.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/hsugawa8651/memoJuliaClassJa.jl",
)
