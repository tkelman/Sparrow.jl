type Legend
	label::String
end

type DataGroup
	data::DataFrame
	markerScale::Vector{Float64}
	markerLineWidth::Float64
	errorLineWidth::Float64
	lineColor::String
	lineStyle::String
	markerColor::String
	markerType::String
	legend::Legend
end

DataGroup(xvals, yvals) = DataGroup(DataFrame(x = vec(xvals), y = vec(yvals)), [0.7, 0.7], 1.2, 1.2, "blank", "solid", "blank", "blank", Legend("\'\'"))
DataGroup(xvals, yvals, yerr) = DataGroup(DataFrame(x = vec(xvals), y = vec(yvals), yerr = vec(yerr)), [0.7, 0.7], 1.2, 1.2, "blank", "solid", "blank", "blank", Legend("\'\'"))
DataGroup(df::DataFrame) = DataGroup(df, [0.7, 0.7], 1.2, 1.2, "blank", "solid", "blank", "blank", Legend("\'\'"))
