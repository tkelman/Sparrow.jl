#VERSION >= v"0.4.0-dev+6521" && __precompile__()

module Sparrow

using DataFrames, Colors, Cairo
# include(Pkg.dir()*"/Processing.jl/src/Processing2D.jl")
include("/Users/rje/Documents/Processing.jl/src/Processing2D.jl")
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
include("aux.jl")
include("lineplot.jl")
include("scatterplot.jl")

function plot{T<:Graph}(p::PlotFrame, gs::Array{T})
	findGraphLimits(p, gs)
	for g in gs
		plotData(p, g, p.showLegend)
	end
	drawAxisLabels(p)
	drawTicks(p)
	p2d.animate(p.wi)
end

function plot(p::PlotFrame, g::Graph)
	findGraphLimits(p, g)
	plotData(p, g, p.showLegend)
	drawAxisLabels(p)
	drawTicks(p)
	p2d.animate(p.wi)
end

function print{T<:Graph}(p::PlotFrame, gs::Array{T}, fn::AbstractString)
	p2d.PDFContext(p.wi, fn)
	findGraphLimits(p, gs)
	for g in gs
		plotData(p, g, p.showLegend)
	end
	drawAxisLabels(p)
	drawTicks(p)
	Cairo.show_page(p2d.contexts[p.wi])
	Cairo.finish(p2d.surfaces[p.wi])
	p2d.popContext(p.wi)
end

function print(p::PlotFrame, g::Graph, fn::AbstractString)
	p2d.PDFContext(p.wi, fn)
	findGraphLimits(p, g)
	plotData(p, g, p.showLegend)
	drawAxisLabels(p)
	drawTicks(p)
	Cairo.show_page(p2d.contexts[p.wi])
	Cairo.finish(p2d.surfaces[p.wi])
	p2d.popContext(p.wi)
end

end
