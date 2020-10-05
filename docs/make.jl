using memoJuliaClassJa
using Documenter

## Adopted from docs/make.jl in Documenter.jl
# The DOCSARGS environment variable can be used to pass additional arguments to make.jl.
# This is useful on CI, if you need to change the behavior of the build slightly but you
# can not change the .travis.yml or make.jl scripts any more (e.g. for a tag build).
if haskey(ENV, "DOCSARGS")
    for arg in split(ENV["DOCSARGS"])
        (arg in ARGS) || push!(ARGS, arg)
    end
end

makedocs(;
    modules=[memoJuliaClassJa],
    authors="Hiroharu Sugawara <hsugawa@gmail.com>",
    repo="https://github.com/hsugawa8651/memoJuliaClassJa.jl/blob/{commit}{path}#L{line}",
    clean = false,
    sitename="memoJuliaClassJa.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://hsugawa8651.github.io/memoJuliaClassJa.jl/stable/",
        assets=String[],
    ),
    linkcheck = !("skiplinks" in ARGS),
    linkcheck_ignore = [
        # timelessrepo.com seems to 404 on any CURL request...
        "http://timelessrepo.com/json-isnt-a-javascript-subset",
        # We'll ignore links that point to GitHub's edit pages, as they redirect to the
        # login screen and cause a warning:
        r"https://github.com/([A-Za-z0-9_.-]+)/([A-Za-z0-9_.-]+)/edit(.*)",
    ] ∪ (get(ENV, "GITHUB_ACTIONS", nothing)  == "true" ? [
        # Extra ones we ignore only on CI.
        #
        # It seems that CTAN blocks GitHub Actions?
        "https://ctan.org/pkg/minted",
    ] : []),
    pages= [
	"Home" => "index.md",
		"LICENSE.md",
		"LICENSEja.md",
		"ch00.md",
		"ch01.md",
		"ch02.md",
		"ch03.md",
		"ch04.md",
		"ch05.md",
		"ch06.md",
		"ch07.md",
		"ch08.md",
		"ch09.md",
		"ch10.md",
		"ch11.md",
		"ch12.md",
		"ch13.md",
		"porting.md"
	],
   # strict = !("strict=false" in ARGS),
   doctest = ("doctest=only" in ARGS) ? :only : true,
)

deploydocs(;
    repo="github.com/hsugawa8651/memoJuliaClassJa.jl.git",
    push_preview = true,
)
