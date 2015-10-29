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

		if showLegend
			dgCount += 1
			if dg.legend.label == "Data Group "
				dg.legend.label = dg.legend.label*string(dgCount)
			end
		end

		w = p2d.Width(p.wi); h = p2d.Height(p.wi)
		xxb = 0.18*w; xxe = 0.96*w
		yxb = 0.16*w; yyb = 0.84*h
		yye = 0.055*h

		plotlength = xxe - xxb
		plotheight = yyb - yye

		# title
		p2d.text(p.wi, p.title, w/2, 0.0727*h)

		# x label
		p2d.text(p.wi, p.xlabel, w/2, 0.97*h)

		# y label
		p2d.text(p.wi, p.ylabel, 0.04*w, h/2; angle=90)

		# x axis
		p2d.line(p.wi, xxb, yyb, xxe, yyb)

		# y axis
		p2d.line(p.wi, yxb, yyb, yxb, yye)

		xmin = minimum(dg.data[:x])
		xmax = maximum(dg.data[:x])

		ymin = minimum(dg.data[:y])
		ymax = maximum(dg.data[:y])

		p2d.stroke(p.wi, 1.0, 1.0, 1.0, 1.0)

		# data points
		for c = 1:length(dg.data[:x])
			ex = (dg.data[:x][c] - xmin)/(xmax - xmin)*plotlength + xxb
			ey = -((dg.data[:y][c] - ymin)/(ymax - ymin)*plotheight - yyb)
			p2d.fill(p.wi, dg.data[:rc][c], dg.data[:gc][c], dg.data[:bc][c], 1.0)
			p2d.ellipse(p.wi, ex, ey, 3.5, 3.5)
		end

		p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)

		# x ticks
		for x in xmin:(xmax-xmin)/5:xmax
			tx = (x - xmin)/(xmax - xmin)*plotlength + xxb
			p2d.line(p.wi, tx, yyb, tx, 0.87*h)
		end

		# x tick labels
		for x in xmin:(xmax-xmin)/5:xmax
			tx = (x - xmin)/(xmax - xmin)*plotlength + xxb
			xl = string(round(x, 2))
			extents = p2d.textExtents(p.wi, xl)
			txc = tx-(extents[3]/2 + extents[1])
			p2d.text(p.wi, xl, txc, 0.92*h)
		end

		# y ticks
		for y in ymin:(ymax-ymin)/5:ymax
			ty = -((y - ymin)/(ymax - ymin)*plotheight - yyb)
			p2d.line(p.wi, yxb, ty, 0.13*w, ty)
		end

		# y tick labels
		for y in ymin:(ymax-ymin)/5:ymax
			ty = -((y - ymin)/(ymax - ymin)*plotheight - yyb)
			yl = string(round(y, 2))
			extents = p2d.textExtents(p.wi, yl)
			tyc = ty-(extents[4]/2 + extents[2])
			p2d.text(p.wi, string(round(y, 2)), 0.06*w, tyc)
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
