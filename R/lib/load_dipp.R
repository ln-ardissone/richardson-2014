#!/usr/bin/env rscript

library(phyloseq)

'load.dipp' <- function(otu.table=NULL, sam.data=NULL, tax.table=NULL, tree=NULL) {
  otus <- otu_table(read.csv(otu.table, header=T, row.names=1, check.names=F), taxa_are_rows=F)
  meta <- sample_data(read.csv(sam.data, header=T, row.names=1))
  taxa <- read.csv(tax.table, header=T, row.names=1)

  # combine genus and species names
  taxa[taxa$Species == '',]$Species <- 'sp.'
  taxa$Species <- paste(taxa$Genus, taxa$Species)

  taxa <- tax_table(as.matrix(taxa))

  if (!is.null(tree)) tree <- read_tree_greengenes(tree)

  phyloseq(otus, meta, taxa, tree)
}
