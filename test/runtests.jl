using Sparrow, DataFrames

d1 = DataFrame(x = [1, 2, 3], y = [1, 2, 3])
d2 = DataFrame(x = [3, 4, 5], y = [5, 6, 8])
g1 = DataGroup(d1)
g2 = DataGroup(d2)
l = LinePlot(g1)
s = ScatterPlot([g1, g2])
p1 = PlotFrame(l)
p2 = PlotFrame(s)
gr = Grid([p1, p2], 1, 2)
gr.size.xscale = 18
gr.size.yscale = 9
plot(gr)
