# vim: set noexpandtab

OTUTABLE?='../data/dipp-otus_filtered.csv'
METADATA?='../data/dipp-sample_data.csv'
TAXONOMIES?='../data/dipp-tax_table.csv'
METAGENOME?='../data/dipp-predicted_metagenome.csv'
METAGENOME_TAX?='../data/dipp-kegg_orthologies.csv'
NORMALIZE?='edger'

TESTMETHOD?='wilcox'

default: sliding_window picrust
	echo 'done!'

sliding_window: sliding-window-Phylum.pdf sliding-window-Class.pdf sliding-window-Order.pdf sliding-window-Family.pdf sliding-window-Genus.pdf sliding-window-Species.pdf

dipp-rf-uniq.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--normalize $(NORMALIZE) \
		--proportion \
		--otutable $(OTUTABLE) \
		--metadata $(METADATA) \
		--taxonomies $(TAXONOMIES)

dipp-rf-uniq-metagenome.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--normalize $(NORMALIZE) \
		--proportion \
		--otutable $(METAGENOME) \
		--metadata $(METADATA) \
		--taxonomies $(METAGENOME_TAX)

CUTS?=12

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $< --cuts $(CUTS) --top 12 --testmethod $(TESTMETHOD) --fdr BY

phyloseq: dipp-rf-uniq.RData

picrust: picrust-X0.pdf picrust-X1.pdf picrust-X2.pdf picrust-X3.pdf

picrust-%.pdf: dipp-rf-uniq-metagenome.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $< --cuts $(CUTS) --top 64 --testmethod $(TESTMETHOD)

ordination.pdf: dipp-rf-uniq.RData
	bin/ordination --input $< --output ordination.pdf

rank_tables:
	mkdir -p rank_tables

rank_tables/%.csv: rank_tables dipp-rf-uniq.RData
	bin/make-rank-table --rank $* --output $@ --input dipp-rf-uniq.RData

tables: rank_tables/Phylum.csv rank_tables/Class.csv rank_tables/Order.csv rank_tables/Family.csv rank_tables/Genus.csv rank_tables/Species.csv

clean:
	rm *.RData
	rm *.pdf
