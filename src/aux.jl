function findGraphLimits(p::PlotFrame, g::Graph)
	if length(find(map(isnan, p.xlim))) == length(p.xlim)
		xmin = Inf
		xmax = -Inf
		for dg in g.dataGroups
			xmin = min(xmin, minimum(dg.data[:x]))
			xmax = max(xmax, maximum(dg.data[:x]))
		end
		p.xlim = [xmin, xmax]
	end

	if length(find(map(isnan, p.ylim))) == length(p.ylim)
		ymin = Inf
		ymax = -Inf
		for dg in g.dataGroups
			ymin = min(ymin, minimum(dg.data[:y]))
			ymax = max(ymax, maximum(dg.data[:y]))
		end
		p.ylim = [ymin, ymax]
	end
end

function findGraphLimits{T<:Graph}(p::PlotFrame, gs::Array{T})
	if length(find(map(isnan, p.xlim))) == length(p.xlim)
		xmin = Inf
		xmax = -Inf
		for g in gs
			for dg in g.dataGroups
				xmin = min(xmin, minimum(dg.data[:x]))
				xmax = max(xmax, maximum(dg.data[:x]))
			end
		end
		p.xlim = [xmin, xmax]
	end

	if length(find(map(isnan, p.ylim))) == length(p.ylim)
		ymin = Inf
		ymax = -Inf
		for g in gs
			for dg in g.dataGroups
				ymin = min(ymin, minimum(dg.data[:y]))
				ymax = max(ymax, maximum(dg.data[:y]))
			end
		end
		p.ylim = [ymin, ymax]
	end
end

function plotPoints(p, dg)
	xmin = p.xlim[1]; xmax = p.xlim[2]
	ymin = p.ylim[1]; ymax = p.ylim[2]

	p2d.stroke(p.wi, 1.0, 1.0, 1.0, 0.0)

	# data points w/ colors
	if in(:rc, names(dg.data))
		for c = 1:length(dg.data[:x])
			ex = (dg.data[:x][c] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ey = -((dg.data[:y][c] - ymin)/(ymax - ymin)*p.phei - p.aby)
			p2d.fill(p.wi, dg.data[:rc][c], dg.data[:gc][c], dg.data[:bc][c], 1.0)
			p2d.ellipse(p.wi, ex, ey, 3.5, 3.5)
		end
		p2d.fill(p.wi, 0, 0, 0, 1.0)
	# data points w/o colors
	else
		p2d.fill(p.wi, 0, 0, 0, 1.0)
		for c = 1:length(dg.data[:x])
			ex = (dg.data[:x][c] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ey = -((dg.data[:y][c] - ymin)/(ymax - ymin)*p.phei - p.aby)
			p2d.ellipse(p.wi, ex, ey, 3.5, 3.5)
		end
	end
end

function plotCurve(p, dg)
	xmin = p.xlim[1]; xmax = p.xlim[2]
	ymin = p.ylim[1]; ymax = p.ylim[2]

	# curve connecting points w/ colors
	if in(:rc, names(dg.data))
		for c = 1:length(dg.data[:x])-1
			lx1 = (dg.data[:x][c] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ly1 = -((dg.data[:y][c] - ymin)/(ymax - ymin)*p.phei - p.aby)
			lx2 = (dg.data[:x][c+1] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ly2 = -((dg.data[:y][c+1] - ymin)/(ymax - ymin)*p.phei - p.aby)
			p2d.stroke(p.wi, dg.data[:rc][c], dg.data[:gc][c], dg.data[:bc][c], 1.0)
			p2d.line(p.wi, lx1, ly1, lx2, ly2)
		end
		p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)
	# curve connecting points w/o colors
	else
		p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)
		for c = 1:length(dg.data[:x])-1
			lx1 = (dg.data[:x][c] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ly1 = -((dg.data[:y][c] - ymin)/(ymax - ymin)*p.phei - p.aby)
			lx2 = (dg.data[:x][c+1] - xmin)/(xmax - xmin)*p.plen + p.abxb
			ly2 = -((dg.data[:y][c+1] - ymin)/(ymax - ymin)*p.phei - p.aby)
			p2d.line(p.wi, lx1, ly1, lx2, ly2)
		end
	end
end

function drawAxisLabels(w, title, xlabel, ylabel, width, height, abxb, abxe, aby, orx, orye, plen, phei)
	p2d.stroke(w, 0.0, 0.0, 0.0, 1.0)

	# title
	p2d.text(w, title, abxb + plen/2, 0.0727*height)

	# x label
	p2d.text(w, xlabel, abxb + plen/2, 0.97*height)

	# y label
	p2d.text(w, ylabel, 0.04*width, orye + phei/2; angle=90)

	# x axis
	p2d.line(w, abxb, aby, abxe, aby)

	# y axis
	p2d.line(w, orx, aby, orx, orye)
end

function drawAxisLabels(p::PlotFrame)
	p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)

	# title
	p2d.text(p.wi, p.title, p.abxb + p.plen/2, 0.0727*p.hpx)

	# x label
	p2d.text(p.wi, p.xlabel, p.abxb + p.plen/2, 0.97*p.hpx)

	# y label
	p2d.text(p.wi, p.ylabel, 0.04*p.wpx, p.orye + p.phei/2; angle=90)

	# x axis
	p2d.line(p.wi, p.abxb, p.aby, p.abxe, p.aby)

	# y axis
	p2d.line(p.wi, p.orx, p.aby, p.orx, p.orye)
end

function drawTicks(p)
	p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)

	xmin = p.xlim[1]; xmax = p.xlim[2]
	ymin = p.ylim[1]; ymax = p.ylim[2]

	# x ticks
	for x in xmin:(xmax-xmin)/5:xmax
		tx = (x - xmin)/(xmax - xmin)*p.plen + p.abxb
		p2d.line(p.wi, tx, p.aby, tx, 0.87*p.hpx)
	end

	# x tick labels
	for x in xmin:(xmax-xmin)/5:xmax
		tx = (x - xmin)/(xmax - xmin)*p.plen + p.abxb
		xl = string(round(x, 2))
		extents = p2d.textExtents(p.wi, xl)
		txc = tx-(extents[3]/2 + extents[1])
		p2d.text(p.wi, xl, txc, 0.92*p.hpx)
	end

	# y ticks
	for y in ymin:(ymax-ymin)/5:ymax
		ty = -((y - ymin)/(ymax - ymin)*p.phei - p.aby)
		p2d.line(p.wi, p.orx, ty, 0.13*p.wpx, ty)
	end

	# y tick labels
	for y in ymin:(ymax-ymin)/5:ymax
		ty = -((y - ymin)/(ymax - ymin)*p.phei - p.aby)
		yl = string(round(y, 2))
		extents = p2d.textExtents(p.wi, yl)
		tyc = ty-(extents[4]/2 + extents[2])
		p2d.text(p.wi, string(round(y, 2)), 0.06*p.wpx, tyc)
	end
end

function drawLegend{T<:Graph}(p, gs::Array{T})
	p2d.fill(p.wi, 1.0, 1.0, 1.0, 1.0)

	lx = 0.18*p.wpx
	c = 0
	for g in gs
		for dg in g.dataGroups
			extents = p2d.textExtents(p.wi, dg.legend.label)
			ly = 0.1*p.hpx + c*(extents[4]-extents[2]) + 0.02*p.hpx
			p2d.stroke(p.wi, 1.0, 1.0, 1.0, 1.0)
			p2d.rect(p.wi, lx, ly-extents[4]+extents[2], extents[3]-extents[1], extents[4]-extents[2])
			p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)
			p2d.text(p.wi, dg.legend.label, lx, ly)
			c += 1
		end
	end
end

function drawLegend(p, g)
	p2d.fill(p.wi, 1.0, 1.0, 1.0, 1.0)

	lx = 0.18*p.wpx
	c = 0
	for dg in g.dataGroups
		extents = p2d.textExtents(p.wi, dg.legend.label)
		ly = 0.1*p.hpx + c*(extents[4]-extents[2]) + 0.02*p.hpx
		p2d.stroke(p.wi, 1.0, 1.0, 1.0, 1.0)
		p2d.rect(p.wi, lx, ly-extents[4]+extents[2], extents[3]-extents[1], extents[4]-extents[2])
		p2d.stroke(p.wi, 0.0, 0.0, 0.0, 1.0)
		p2d.text(p.wi, dg.legend.label, lx, ly)
		c += 1
	end
end
