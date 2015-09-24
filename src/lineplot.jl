type LinePlot <: Graph
	dataGroups::Vector{DataGroup}
end

LinePlot(dg::DataGroup) = LinePlot([dg])

function plotData(g::LinePlot, showLegend::Bool, fid)
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

		println(fid, "color "*dg.lineColor)
		println(fid, "line-style "*dg.lineStyle)
		println(fid, "marker-color "*dg.markerColor)
		println(fid, "marker "*dg.markerType)
		println(fid, "marker-line-width $(dg.markerLineWidth)")
		println(fid, "marker-min-scale $(dg.markerScale[1])")
		println(fid, "marker-scale $(dg.markerScale[2])")
		println(fid, "error-bar-line-width $(dg.errorLineWidth)")
		if showLegend
			println(fid, "legend "*dg.legend.label)
		end

		push!(dataFs, sparrowD*"data.sparrow"*randstring(5))
		if isempty(find(DataFrames.names(dg) .== :yerr))
			writedlm(dataFs[end], [dg.data[:x] dg.data[:y]])
			println(fid, "plot $(dataFs[end])@\$1:\$2")
		else
			writedlm(dataFs[end], [dg.data[:x] dg.data[:y] dg.data[:yerr]])
			println(fid, "plot $(dataFs[end])@\$1:\$2:yerr=\$3")
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
