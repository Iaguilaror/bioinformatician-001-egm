#!/usr/bin/env Rscript

#Provides access to a copy of the command line arguments supplied when this R session was invoked.
args = commandArgs(trailingOnly=TRUE)

#Load ggplot2 library
library("ggplot2")

# Test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
}

#The file with the data is loaded in a table
results <- read.table(args[1], header = TRUE)

#The dot plot is generated
locus<-ggplot(subset(results, results$Locus_name %in% c("Golden Gene", "Unwanted Region")),
       aes(x=results$bcov,
           y=results$mdcov,
           color=results$Locus_name))+ geom_point() +
        ggtitle("Sequencing Coverage for the target panel") +
        labs(x = "Breadth of coverage (%)", y="Mean Depth of coverage (x)",color = "Target type\n") +
        expand_limits(x=c(0,100), y=c(0, 80))

#The dot plot is exported
ggsave("../results-examples/R_plots.pdf")