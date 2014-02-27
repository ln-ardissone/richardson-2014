library(phyloseq)

OTU.TABLE <- '../data/dipp.gg135.97.50r10s.csv'
SAM.DATA <- '../data/dipp.sample_data.csv'
TAX.TABLE <- '../data/dipp.modified_taxonomies.csv'

'load.dipp' <- function(otu.table=OTU.TABLE, sam.data=SAM.DATA, tax.table=TAX.TABLE) {
  otus <- otuTable(read.csv(otu.table, header=T, row.names=1, check.names=F), taxa_are_rows=F)
  meta <- samData(read.csv(sam.data, header=T, row.names=1))
  taxa <- taxTab(as.matrix(read.csv(tax.table, header=T, row.names=1)))

  phyloseq(otus, meta, taxa)
}
