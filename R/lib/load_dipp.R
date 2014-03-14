library(phyloseq)

'load.dipp' <- function(otu.table=NONE, sam.data=NONE, tax.table=NONE, tree=NONE) {
  otus <- otuTable(read.csv(otu.table, header=T, row.names=1, check.names=F), taxa_are_rows=F)
  meta <- samData(read.csv(sam.data, header=T, row.names=1))
  taxa <- taxTab(as.matrix(read.csv(tax.table, header=T, row.names=1)))

  phyloseq(otus, meta, taxa)
}
