using PythonCall

# pikepdf = pyimport("pikepdf")

Pdf = pyimport("pikepdf" => "Pdf")
OutlineItem = pyimport("pikepdf" => "OutlineItem")

include(srcdir("tocutils.jl"))

#! modify this
function level(strlst)
    
    if strlst[1] ∈ ["PART", "Index", "Appendix", "Bibliography"]
        1
    elseif occursin(".", strlst[1]) 
        2
    else
        1
    end
end

#! generate outline with toc.txt

toc2pdf(datadir("univ_toc.txt"), datadir("univradon.pdf"), level; off = 12) 

