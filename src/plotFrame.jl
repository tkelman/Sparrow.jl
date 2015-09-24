type PageSize
	xscale::Float64
	yscale::Float64
	units::String
end

type PlotFrame
	graphType::Graph
	name::String
	viewer::String
	size::PageSize
	title::String
	xlabel::String
	ylabel::String
	xlim::Vector{Float64}
	ylim::Vector{Float64}
	legendInside::Bool
	showLegend::Bool
	topAxis::Bool
	leftAxis::Bool
	bottomAxis::Bool
	rightAxis::Bool
end

PlotFrame() = PlotFrame(LinePlot(), "sparrow", "open", PageSize(12, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], false, false, true, true, true, true)
PlotFrame(name::String) = PlotFrame(LinePlot(), name, "open", PageSize(12, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], false, false, true, true, true, true)
PlotFrame(graphType::Graph) = PlotFrame(graphType, "sparrow", "open", PageSize(12, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], false, false, true, true, true, true)
PlotFrame(name::String, graphType::Graph) = PlotFrame(graphType, name, "open", PageSize(12, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], false, false, true, true, true, true)

# function PlotFrame()
#	viewer = []
#	@osx? viewer = "open" : nothing

#	return PlotFrame("sparrow", viewer, [0.7, 0.7], PageSize(12, 9, "cm"), "\'\'", "\'\$x\$\'", "\'\$y\$\'", [NaN, NaN], [NaN, NaN])
# end
