type PageSize
	xscale::Float64
	yscale::Float64
	units::String
end

type PlotFrame
	wi::Int
	name::String
	size::PageSize
	title::String
	xlabel::String
	ylabel::String
	xlim::Vector{Float64}
	ylim::Vector{Float64}
	legendInside::Bool
	showLegend::Bool
	legendPos::String
	topAxis::Bool
	leftAxis::Bool
	bottomAxis::Bool
	rightAxis::Bool
end

function PlotFrame(name::AbstractString, width, height)
	w = p2d.screen(width, height)
	p2d.createFont(w, "Courier", 20*(width/500))
	p2d.background(w, 1.0, 1.0, 1.0, 1.0)

	return PlotFrame(w, name, PageSize(9, 9, "cm"), "", "x", "y", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false)
end

PlotFrame(width, height) = PlotFrame("sparrow", width, height)
PlotFrame(s) = PlotFrame("sparrow", s, s)
PlotFrame() = PlotFrame("sparrow", 400, 400)
