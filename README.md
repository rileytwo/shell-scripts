# shell scripts

If you have [Homebrew](https://brew.sh) installed, check out [homebrew-shell-scripts](https://github.com/rileytwo/homebrew-shell-scripts) for an easy way to install and use these scripts. Otherwise, clone the repo and place these somewhere in your path.

# Usage

## `uti.sh`
A simple wrapper for running `mdls -name kMDItemContentType -name kMDItemContetTypeTree -name kMDItemKind <file>`. Particularly (and only) useful for finding the Uniform Type Identifier, commonly referred to as [UTI](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_intro/understand_utis_intro.html) of a file. 


```zsh
uti.sh README.md

kMDItemContentType     = "net.daringfireball.markdown"
kMDItemContentTypeTree = (
    "net.daringfireball.markdown",
    "public.plain-text",
    "public.text",
    "public.data",
    "public.item",
    "public.content"
)
kMDItemKind            = "Markdown Document"
```



