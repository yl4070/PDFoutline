using PythonCall


pikepdf = pyimport("pikepdf")

Pdf = pyimport("pikepdf" => "Pdf")
OutlineItem = pyimport("pikepdf" => "OutlineItem")

include(srcdir("tocutils.jl"))

#! modify this
function level(strlst)
    
    if strlst[1] == "PART"
        1
    elseif strlst[1] == "Executive"
        2
    elseif !occursin(".", strlst[1]) && strlst[1] != "Exercises"
        2
    elseif occursin(".", strlst[1]) || strlst[1] == "Exercises"
        3
    else
        1
    end
end

#! generate outline with toc.txt
gentoc(datadir("toc.txt"), level) |> t -> addtoc(datadir("pictures.pdf"), t)

