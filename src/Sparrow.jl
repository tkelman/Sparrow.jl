#VERSION >= v"0.4.0-dev+6521" && __precompile__()

module Sparrow

using DataFrames, Colors, Cairo
include(Pkg.dir()*"/Processing/src/Processing2D.jl")
const p2d = Processing2D

export DataGroup, PlotFrame, Legend, PageSize
export LinePlot, ScatterPlot, XYZMap, HistPlot
export plot, lineplot, scatterplot, xyzmap, histplot

global dgCount = 0

abstract Graph

include("colors.jl")
include("symbols.jl")
include("plotFrame.jl")
include("datagroup.jl")
include("auxiliary.jl")
include("lineplot.jl")
include("scatterplot.jl")

function plot{T<:Graph}(p::PlotFrame, gs::Array{T})
	findGraphLimits(p, gs)
	drawAxisLabels(p)
	drawTicks(p)
	for g in gs
		plotData(p, g, p.showLegend)
	end

	if p.showLegend
		drawLegend(p, gs)
	end

	p2d.animate(p.wi)
end

function plot(p::PlotFrame, g::Graph)
	findGraphLimits(p, g)
	drawAxisLabels(p)
	drawTicks(p)
	plotData(p, g, p.showLegend)

	if p.showLegend
		drawLegend(p, g)
	end

	p2d.animate(p.wi)
end

function print{T<:Graph}(p::PlotFrame, gs::Array{T}, fn::AbstractString)
	p2d.PDFContext(p.wi, fn)
	p2d.createFont(p.wi, "Arial", 13*(p.wpx/500))
	findGraphLimits(p, gs)
	drawAxisLabels(p)
	drawTicks(p)
	for g in gs
		plotData(p, g, p.showLegend)
	end

	if p.showLegend
		drawLegend(p, gs)
	end

	Cairo.show_page(p2d.contexts[p.wi])
	Cairo.finish(p2d.surfaces[p.wi])
	p2d.popContext(p.wi)
end

function print(p::PlotFrame, g::Graph, fn::AbstractString)
	p2d.PDFContext(p.wi, fn)
	p2d.createFont(p.wi, "Arial", 13*(p.wpx/500))
	findGraphLimits(p, g)
	drawAxisLabels(p)
	drawTicks(p)
	plotData(p, g, p.showLegend)

	if p.showLegend
		drawLegend(p, g)
	end

	Cairo.show_page(p2d.contexts[p.wi])
	Cairo.finish(p2d.surfaces[p.wi])
	p2d.popContext(p.wi)
end

function close(p::PlotFrame)
	p2d.endDrawing(p.wi)
end

end
