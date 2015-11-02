type ScatterPlot <: Graph
	dataGroups::Vector{DataGroup}
end

ScatterPlot(dg::DataGroup) = ScatterPlot([dg])

function plotData(p::PlotFrame, g::ScatterPlot, showLegend::Bool)
	global dgCount

	for x in 1:length(g.dataGroups)
		dg = g.dataGroups[x]
		if dg.lineColor == "blank"
			dg.lineColor = goodColors[mod(x, length(goodColors))]
		end

		if dg.markerColor == "blank"
			dg.markerColor = goodColors[mod(x, length(goodColors))]
		end

		if dg.markerType == "blank"
			dg.markerType = goodSymbols[mod(x, length(goodSymbols))]
		end

		plotPoints(p, dg)

		if showLegend
			dgCount += 1
			if dg.legend.label == "Data Group "
				dg.legend.label = dg.legend.label*string(dgCount)
			end
		end
	end
end

function scatterplot(dgs::Vector{DataGroup})
	plot(PlotFrame(ScatterPlot(dgs)))
end

function scatterplot(dg::DataGroup)
	plot(PlotFrame(ScatterPlot(dg)))
end

function scatterplot(dfs::Vector{DataFrame})
	dgs = DataGroup[]
	for df in dfs
		push!(dgs, DataGroup(df))
	end
	scatterplot(dgs)
end

function scatterplot(df::DataFrame)
	scatterplot(DataGroup(df))
end

function scatterplot(ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = collect(1:length(y)), y = y[r,:]))
	end
	scatterplot(dfs)
end

function scatterplot(xs::Array{Float64, 2}, ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = x[r,:], y = y[r,:]))
	end
	scatterplot(dfs)
end

function scatterplot(xs::Array{Float64, 2}, ys::Array{Float64, 2}, yerrs::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(ys, 1)
		push!(dfs, DataFrame(x = vec(xs[r,:]), y = vec(ys[r,:]), yerr = vec(yerrs[r,:])))
	end
	scatterplot(dfs)
end
