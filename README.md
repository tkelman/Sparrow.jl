# Sparrow.jl

The idea of this package is to separate plotting into stages. At the first stage, you setup groups of data that will be added to the plot. Then, you make a frame into which these groups will be laid. Next, you determine in what manner the groups should be plotted (line plot, histogram, etc.). Last, you plot everything!

This package also depends on one package that is not registered in the package system yet, so run the following before using:

```julia
Pkg.clone("Processing")
```
