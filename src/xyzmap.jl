type XYZMap <: Graph
	dataGroups::Vector{DataGroup}
end

XYZMap(dg::DataGroup) = XYZMap([dg])

function plotData(g::XYZMap, showLegend::Bool, fid)
	global dgCount

	for x in 1:length(g.dataGroups)
		if x == 1
			println(fid, "xyz-map")
		end

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
			dgCount += 1
			if dg.legend.label == "\'Data Group \'"
				println(fid, "legend "*dg.legend.label*string(dgCount))
			else
				println(fid, "legend "*dg.legend.label)
			end
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

function xyzmap(dgs::Vector{DataGroup})
	plot(PlotFrame(XYZMap(dgs)))
end

function xyzmap(dg::DataGroup)
	plot(PlotFrame(XYZMap(dg)))
end

function xyzmap(dfs::Vector{DataFrame})
	dgs = DataGroup[]
	for df in dfs
		push!(dgs, DataGroup(df))
	end
	xyzmap(dgs)
end

function xyzmap(df::DataFrame)
	xyzmap(DataGroup(df))
end

function xyzmap(ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = collect(1:length(y)), y = y[r,:]))
	end
	xyzmap(dfs)
end

function xyzmap(xs::Array{Float64, 2}, ys::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(y, 1)
		push!(dfs, DataFrame(x = x[r,:], y = y[r,:]))
	end
	xyzmap(dfs)
end

function xyzmap(xs::Array{Float64, 2}, ys::Array{Float64, 2}, yerrs::Array{Float64, 2})
	dfs = DataFrame[]
	for r = 1:size(ys, 1)
		push!(dfs, DataFrame(x = vec(xs[r,:]), y = vec(ys[r,:]), yerr = vec(yerrs[r,:])))
	end
	xyzmap(dfs)
end
