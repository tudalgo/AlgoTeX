#!/usr/bin/env texlua

-- Identify the bundle and module
module = "algotex"

-- TDS-based installation
maindir = "."
installfiles = {}
sourcefiles = {}
unpackfiles = {}
tdsdirs = {tex = "tex/latex/algotex"}

-- documentation
-- docfiledir = "doc" -- this would result in only the doc directory and not the example directory to be built
docfiles = {maindir .. "/doc/*.tex", maindir .. "/doc/fib_rec.py", maindir .. "/examples/*.tex"}
typesetfiles = {"*.tex"}
typesetexe = "lualatex"
typesetopts = "-interaction=nonstopmode --shell-escape -halt-on-error"
packtdszip = true -- recommended for "tree" layouts

-- Tagging
tagfiles = {"tex/*.sty", "tex/*.cls"}
function tag_hook(tagname)
    -- os.execute('git commit -a -m "Step release tag"')
    -- os.execute('git tag -a -m "" ' .. tagname)
end

-- Detail how to set the version automatically
function update_tag(file, content, tagname, tagdate)
    tagname = string.gsub(tagname, "^v", "")
    if string.match(file, ".*%.sty") or string.match(file, ".*%.cls") then
        -- \ProvidesExplPackage{<name>}{<date>}{<version>}{<description>}
        temp = string.gsub(content,
            "\\ProvidesExplPackage%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}",
            "\\ProvidesExplPackage{%1}{" .. tagdate .. "}{" .. tagname .. "}{%4}"
        )
        -- \ProvidesPackage{<name>}[<date> <description>]
        temp = string.gsub(temp,
            "\\ProvidesPackage%{([^}]*)%}%{%d%d%d%d.%d%d.%d%d ([^}]*)%}",
            "\\ProvidesPackage{%1}{" .. tagdate .. " %2}"
        )
        -- \ProvidesExplClass{<name>}{<date>}{<version>}{<description>}
        return temp.gsub(temp,
            "\\ProvidesExplClass%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}%{([^}]*)%}",
            "\\ProvidesExplClass{%1}{" .. tagdate .. "}{" .. tagname .. "}{%4}"
        )
    end
    return content
end
