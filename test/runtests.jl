using Sparrow, DataFrames

d = DataFrame(x = [0:0.1:30], y = sin([0:0.1:30]), rc = sin([0:0.1:30])./2 .+ 0.5, gc = zeros(length([0:0.1:30])), bc = zeros(length([0:0.1:30])))
g = Sparrow.DataGroup(d)
l = Sparrow.LinePlot(g)
p = Sparrow.PlotFrame()
Sparrow.plot(p, l)
Sparrow.print(p, l, "line.pdf")

d2 = DataFrame(x = randn(100), y = randn(100), rc = rand(100), gc = rand(100), bc = rand(100))
g2 = Sparrow.DataGroup(d2)
l2 = Sparrow.ScatterPlot(g2)
p2 = Sparrow.PlotFrame()
Sparrow.plot(p2, l2)
Sparrow.print(p2, l2, "scatter.pdf")

p3 = Sparrow.PlotFrame()
Sparrow.plot(p3, [l, l2])
Sparrow.print(p3, [l, l2], "both.pdf")

readline()
