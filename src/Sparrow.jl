VERSION >= v"0.4.0-dev+6521" && __precompile__()

module Sparrow

using Compat, DataFrames, Color

export DataGroup, PlotFrame, Legend, PageSize
export LinePlot
export plot, lineplot

scriptF = []; dataFs = String[]; sparrowD = []

try
	sparrowD = string("/tmp/sparrow-",ENV["USER"],"-",randstring(5),"/")
	mkdir(sparrowD)
catch
	sparrowD = string(replace(ENV["TMP"],"\\","/"),"/sparrow-",ENV["USERNAME"],"-",randstring(5),"/")
	mkdir(sparrowD)
end

scriptF = sparrowD*"sparrow.ct2"

abstract Graph

include("colors.jl")
include("symbols.jl")
include("plotFrame.jl")
include("datagroup.jl")
include("aux.jl")
include("lineplot.jl")

function plot(p::PlotFrame)
	fid = open(scriptF, "w+")

	println(fid, "name "*p.name)
	println(fid, "viewer "*p.viewer)
	println(fid, "page-size $(p.size.xscale)$(p.size.units)x$(p.size.yscale)$(p.size.units)")
	println(fid, "title "*p.title)
	println(fid, "xlabel "*p.xlabel)
	println(fid, "ylabel "*p.ylabel)

	if p.legendInside
		println(fid, "legend-inside tr")
	end

	findGraphLimits(p)

	println(fid, "xrange $(p.xlim[1]):$(p.xlim[2])")
	println(fid, "yrange $(p.ylim[1]):$(p.ylim[2])")

	if !p.topAxis
		println(fid, "top off")
	else
	end

	if !p.leftAxis
		println(fid, "left off")
	else
		# println(fid, "left major-num")
	end

	if !p.bottomAxis
		println(fid, "bottom off")
	else
		# println(fid, "bottom major-num")
	end

	if !p.rightAxis
		println(fid, "right off")
	else
	end

	plotData(p.graphType, p.showLegend, fid)

	close(fid)
	run(`ctioga2 -f $(scriptF)`)

	rm(scriptF)
	for dataF in dataFs
		rm(dataF)
	end
end

plot(p::PlotFrame, dg::DataGroup) = plot(p, [dg])

end
