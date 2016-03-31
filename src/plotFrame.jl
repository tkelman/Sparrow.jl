type PageSize
	xscale::Float64
	yscale::Float64
	units::String
end

type PlotFrame
	graphTypes::Vector{Graph}
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
	legendPos::String
	topAxis::Bool
	leftAxis::Bool
	bottomAxis::Bool
	rightAxis::Bool
	xlog::Bool
	ylog::Bool
end

PlotFrame() = PlotFrame([LinePlot()], "sparrow", "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
PlotFrame(name::String) = PlotFrame([LinePlot()], name, "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
PlotFrame(graphType::Graph) = PlotFrame([graphType], "sparrow", "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
PlotFrame(name::String, graphType::Graph) = PlotFrame([graphType], name, "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
PlotFrame(graphTypes::Vector{Graph}) = PlotFrame(graphTypes, "sparrow", "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
PlotFrame(name::String, graphTypes::Vector{Graph}) = PlotFrame(graphTypes, name, "open", PageSize(9, 9, "cm"), "\'\'", "\'x\'", "\'y\'", [NaN, NaN], [NaN, NaN], true, true, "tl", false, true, true, false, false, false)
