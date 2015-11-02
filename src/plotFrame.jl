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
	wpx::Float64
	hpx::Float64
	abxb::Float64
	abxe::Float64
	aby::Float64
	oryb::Float64
	orye::Float64
	orx::Float64
	plen::Float64
	phei::Float64
end

function PlotFrame(name::AbstractString, title, xlabel, ylabel, width, height)
	w = p2d.screen(width, height)
	p2d.createFont(w, "Arial", 13*(width/500))
	p2d.background(w, 1.0, 1.0, 1.0, 1.0)

	abxb = 0.18*width; abxe = 0.96*width
	orx = 0.16*width; aby = 0.84*height
	orye = 0.055*height

	plen = abxe - abxb
	phei = aby - orye

	drawAxisLabels(w, title, xlabel, ylabel, width, height, abxb, abxe, aby, orx, orye, plen, phei)

	return PlotFrame(w, name, PageSize(9, 9, "cm"), title, xlabel, ylabel, [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, width, height, abxb, abxe, aby, aby, orye, orx, plen, phei)
end

PlotFrame(width, height) = PlotFrame("sparrow", "", "x", "y", width, height)
PlotFrame(s) = PlotFrame("sparrow", "", "x", "y", s, s)
PlotFrame() = PlotFrame("sparrow", "", "x", "y", 400, 400)
