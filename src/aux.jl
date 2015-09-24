function findGraphLimits(p::PlotFrame)
	if length(find(map(isnan, p.xlim))) == length(p.xlim)
		xmin = Inf
		xmax = -Inf
		for dg in p.graphType.dataGroups
			xmin = min(xmin, minimum(dg.data[:x]))
			xmax = max(xmax, maximum(dg.data[:x]))
		end
		p.xlim = [xmin-0.1, xmax+0.1]
	end

	if length(find(map(isnan, p.ylim))) == length(p.ylim)
		ymin = Inf
		ymax = -Inf
		for dg in p.graphType.dataGroups
			ymin = min(ymin, minimum(dg.data[:y]))
			ymax = max(ymax, maximum(dg.data[:y]))
		end
		p.ylim = [ymin-0.1, ymax+0.1]
	end
end
