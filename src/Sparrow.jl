VERSION >= v"0.4.0-dev+6521" && __precompile__()

module Sparrow

using Compat, DataFrames, Colors

export DataGroup, PlotFrame, Legend, PageSize
export LinePlot, ScatterPlot, XYZMap, Contour, XYParametric
export plot, lineplot, scatterplot, xyzmap, contour, xyparametric

scriptF = []; dataFs = String[]; sparrowD = []

try
	sparrowD = string("/tmp/sparrow-",ENV["USER"],"-",randstring(5),"/")
	mkdir(sparrowD)
catch
	sparrowD = string(replace(ENV["TMP"],"\\","/"),"/sparrow-",ENV["USERNAME"],"-",randstring(5),"/")
	mkdir(sparrowD)
end

scriptF = sparrowD*"sparrow.ct2"
global dgCount = 0

abstract Graph

include("colors.jl")
include("symbols.jl")
include("plotFrame.jl")
include("datagroup.jl")
include("aux.jl")
include("lineplot.jl")
include("scatterplot.jl")
include("xyzmap.jl")
include("contour.jl")
include("xyparametric.jl")

type Grid
	plotFrames::Vector{PlotFrame}
	rows::Int
	cols::Int
	name::String
	viewer::String
	size::PageSize
end

Grid(ps::Vector{PlotFrame}, rows, cols) = Grid(ps, rows, cols, "sparrow", "open", PageSize(9, 9, "cm"))

function plot(g::Grid)
	global dgCount

	fid = open(scriptF, "w+")

	println(fid, "name "*g.name)
	println(fid, "viewer "*g.viewer)
	println(fid, "page-size $(g.size.xscale)$(g.size.units)x$(g.size.yscale)$(g.size.units)")
	println(fid, "setup-grid $(g.cols)x$(g.rows)")

	rowc = 0
	colc = 0
	for pc = 1:length(g.plotFrames)
		p = g.plotFrames[pc]
		if pc == 1
			println(fid, "inset grid:0,0")
		else
			colc += 1
			if mod(colc, g.cols) == 0
				colc = 0
				rowc += 1
			end
			println(fid, "next-inset grid:$(colc),$(rowc)")
		end

		println(fid, "title "*p.title)
		println(fid, "xlabel "*p.xlabel)
		println(fid, "ylabel "*p.ylabel)

		if p.legendInside
			println(fid, "legend-inside "*p.legendPos)
		end

		findGraphLimits(p)

		println(fid, "xrange $(p.xlim[1]):$(p.xlim[2])")
		println(fid, "yrange $(p.ylim[1]):$(p.ylim[2])")

		if p.topAxis
			println(fid, "top major-num")
		else
			println(fid, "top off")
		end

		if p.leftAxis
			println(fid, "left major-num")
		else
			println(fid, "left off")
		end

		if p.bottomAxis
			println(fid, "bottom major-num")
		else
			println(fid, "bottom off")
		end

		if p.rightAxis
			println(fid, "right major-num")
		else
			println(fid, "right off")
		end

		if p.xlog
			println(fid, "xlog true")
		end

		if p.ylog
			println(fid, "ylog true")
		end

		for gr in p.graphTypes
			plotData(gr, p.showLegend, fid)
		end
	end

	close(fid)
	run(`ctioga2 -f $(scriptF)`)

	if isfile(scriptF)
		rm(scriptF)
	end
	for dataF in dataFs
		if isfile(dataF)
			rm(dataF)
		end
	end

	dgCount = 0
end

function plot(p::PlotFrame)
	global dgCount

	fid = open(scriptF, "w+")

	println(fid, "name "*p.name)
	println(fid, "viewer "*p.viewer)
	println(fid, "page-size $(p.size.xscale)$(p.size.units)x$(p.size.yscale)$(p.size.units)")
	println(fid, "title "*p.title)
	println(fid, "xlabel "*p.xlabel)
	println(fid, "ylabel "*p.ylabel)

	if p.legendInside
		println(fid, "legend-inside "*p.legendPos)
	end

	findGraphLimits(p)

	println(fid, "xrange $(p.xlim[1]):$(p.xlim[2])")
	println(fid, "yrange $(p.ylim[1]):$(p.ylim[2])")

	if p.topAxis
		println(fid, "top major-num")
	else
		println(fid, "top off")
	end

	if p.leftAxis
		println(fid, "left major-num")
	else
		println(fid, "left off")
	end

	if p.bottomAxis
		println(fid, "bottom major-num")
	else
		println(fid, "bottom off")
	end

	if p.rightAxis
		println(fid, "right major-num")
	else
		println(fid, "right off")
	end

	if p.xlog
		println(fid, "xlog true")
	end

	if p.ylog
		println(fid, "ylog true")
	end

	for gr in p.graphTypes
		plotData(gr, p.showLegend, fid)
	end

	close(fid)
	run(`ctioga2 -f $(scriptF)`)

	if isfile(scriptF)
		rm(scriptF)
	end
	for dataF in dataFs
		if isfile(dataF)
			rm(dataF)
		end
	end

	dgCount = 0
end

end
