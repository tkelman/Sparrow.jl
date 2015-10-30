type LinePlot <: Graph
	dataGroups::Vector{DataGroup}
end

LinePlot(dg::DataGroup) = LinePlot([dg])

function plotData(p::PlotFrame, g::LinePlot, showLegend::Bool)
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

		if showLegend
			dgCount += 1
			if dg.legend.label == "Data Group "
				dg.legend.label = dg.legend.label*string(dgCount)
			end
		end

		plotCurve(p, dg)
		if dg.plotPoints
			plotPoints(p, dg)
		end
	end
end

function lineplot(dgs::Vector{DataGroup})
	plot(PlotFrame(LinePlot(dgs)))
end

function lineplot(dg::DataGroup)
	plot(PlotFrame(LinePlot(dg)))
end

function lineplot(dfs::Vector{DataFrame})
	dgs = DataGroup[]
	for df in dfs
		push!(dgs, DataGroup(df))
	end
	lineplot(dgs)
end

function lineplot(df::DataFrame)
	lineplot(DataGroup(df))
end

function lineplot(ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = collect(1:length(y)), y = y[r,:]))
	end
	lineplot(dfs)
end

function lineplot(xs::Array{Float64, 2}, ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = x[r,:], y = y[r,:]))
	end
	lineplot(dfs)
end

function lineplot(xs::Array{Float64, 2}, ys::Array{Float64, 2}, yerrs::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(ys, 1)
		push!(dfs, DataFrame(x = vec(xs[r,:]), y = vec(ys[r,:]), yerr = vec(yerrs[r,:])))
	end
	lineplot(dfs)
end
