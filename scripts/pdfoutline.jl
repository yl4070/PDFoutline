using PythonCall

# pikepdf = pyimport("pikepdf")

Pdf = pyimport("pikepdf" => "Pdf")
OutlineItem = pyimport("pikepdf" => "OutlineItem")

include(srcdir("tocutils.jl"))

#! modify this
function level(strlst)
    
    if strlst[1] ∈ ["Bibliography", "Contents", "Acknowledgement", "References", "Index", "Appendix", "Notation", "Author", "List"]
        1
    elseif strlst[1] ∈ ["Summary", "Problems", "Historical", "Overall"]
    else 
        count(".", strlst[1]) + 1
        # occursin(r"[0-9]", strlst[1]) ? 2 : 1
    end
end


function pagemod(pg)
    if pg >= 12
        pg += 1
        if pg > 14
            pg += 1
        end
    end
    pg
end


#! generate outline with toc.txt

toc2pdf(datadir("info2.txt"), datadir("info2.pdf"), level; off = 25, mod = nothing) 
# toc2pdf(strip.(tocarr) , datadir("functionprob.pdf"), level; off = 13, mod = nothing) 



ls = readlines(datadir("funtoc.txt"))

tocarr = []

for l1 in ls

    for m in eachmatch(r"[0-9]{0,1}\.?[0-9]?\s+[^0-9]+\s[0-9]+", l1)
        println(m.match)
        push!(tocarr, m.match)
    end
end


strip.(tocarr)

tocarr