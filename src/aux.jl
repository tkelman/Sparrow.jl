function findGraphLimits(p::PlotFrame)
	if length(find(map(isnan, p.xlim))) == length(p.xlim)
		xmin = Inf
		xmax = -Inf
		for dg in p.graphType.dataGroups
			xmin = min(xmin, minimum(dg.data[:x]))
			xmax = max(xmax, maximum(dg.data[:x]))
		end
		xrange = xmax - xmin
		p.xlim = [xmin-0.1*xrange, xmax+0.1*xrange]
	end

	if length(find(map(isnan, p.ylim))) == length(p.ylim)
		ymin = Inf
		ymax = -Inf
		for dg in p.graphType.dataGroups
			ymin = min(ymin, minimum(dg.data[:y]))
			ymax = max(ymax, maximum(dg.data[:y]))
		end
		yrange = ymax - ymin
		p.ylim = [ymin-0.1*yrange, ymax+0.1*yrange]
	end
end
