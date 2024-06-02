
Pdf = pyimport("pikepdf" => "Pdf")
OutlineItem = pyimport("pikepdf" => "OutlineItem")

function outlineitem(l1::String, off; pagemod = nothing)

    lst = split(l1 |> strip, " ")
    pg = parse(Int, lst[end])

    if !(pagemod isa Nothing)
        pg = pagemod(pg)
    end
    OutlineItem(join(lst[1:end-1], " "),  pg+off)
end

function gentoc(toctxt, level::Function; off = 0, mod = nothing)

    lines = readlines(toctxt)

    gentoc(lines, level; off = off, mod = mod)
end

function gentoc(lines::AbstractArray, level::Function; off = 0, mod = nothing)

    outlst = []

    for l1 in lines
        strlst = split(l1, " ")

        if level(strlst) == 1

            l1item = outlineitem(l1, off; pagemod = mod)
            push!(outlst, l1item)
        elseif level(strlst) == 2

            l2item = outlineitem(l1, off; pagemod = mod)
            outlst[end].children.append(l2item)

        elseif level(strlst) == 3

            l3item = outlineitem(l1, off; pagemod = mod)
            outlst[end].children[-1].children.append(l3item)
        end
    end

    outlst
end


function addtoc(pdfpath, outlst)
    
    pdf = Pdf.open(pdfpath)

    pywith(pdf.open_outline()) do out
        out.root.clear()
        out.root.extend( pylist(outlst) )
    end


    pdf.save("$(replace(pdfpath, ".pdf" => ""))toc.pdf")
end


function toc2pdf(toc, pdf, level; off = 0, mod = nothing)

    gentoc(toc, level; off = off, mod = mod) |> t -> addtoc(pdf, t)
end


