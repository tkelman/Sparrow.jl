using Sparrow, DataFrames

d = DataFrame(x = [1, 2, 3], y = [1, 2, 3])
g = DataGroup(d)
l = LinePlot(g)
p = PlotFrame(l)
plot(p)
