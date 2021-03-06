# vim: set noexpandtab

OTUTABLE?='../data/dipp-otus_filtered.csv'
METADATA?='../data/dipp-sample_data.csv'
TAXONOMIES?='../data/dipp-tax_table-merged_bacteroides.csv'
TREE?='../data/97-otus.tree'
METAGENOME?='../data/dipp-predicted_metagenome.csv'
METAGENOME_TAX?='../data/dipp-kegg_orthologies.csv'
QPCR='../data/dorei-vulgatus-predicted-copies.csv'
PHYLOSEQ='dipp-rf-uniq.RData'
NORMALIZE?='edger'
FDR?='BH'
WIDTH?=201
TOP?=4
BY?=10

TESTMETHOD?='glm'

default: sliding_window picrust
	echo 'done!'

sliding_window: sliding-window-Phylum.pdf sliding-window-Class.pdf sliding-window-Order.pdf sliding-window-Family.pdf sliding-window-Genus.pdf sliding-window-Species.pdf sliding_window_qpcr

sliding-window-diversity.pdf: dipp-for-richness.RData
	bin/sliding-window-diversity \
		--input $< \
		--output $@ \
		--width 200 \
		--method Shannon

boxplots: boxplot-Phylum.pdf boxplot-Class.pdf boxplot-Order.pdf boxplot-Family.pdf boxplot-Genus.pdf boxplot-Species.pdf

mw-all: mw-all-Phylum.pdf mw-all-Genus.pdf mw-all-Species.pdf

mw-all-%.pdf: dipp-rf-uniq.RData
	bin/all-sample-mw-test \
		--input $< \
		--pdf $@ \
		--rank $* \
		--table-out mw-all-$*.csv

glms: glm-Phylum.pdf glm-Genus.pdf glm-Species.pdf

autoimmunity-timing.pdf:
	bin/autoimmunity-timing
	mv Rplots autoimmunity-timing.pdf

glm-%.pdf: dipp-rf-uniq.RData
	bin/full-glm \
		--input $< \
		--output "$@".csv \
		--pdf $@ \
		--rank $* \
		--out-table glm-$*.csv

boxplot-%.pdf: dipp-rf-uniq.RData
	bin/boxplots \
		--start 300 \
		--stop 500 \
		--rank $* \
		--output $@ \
		--input $<

dipp-rf-uniq-site-%.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--normalize $(NORMALIZE) \
		--proportion \
		--otutable $(OTUTABLE) \
		--metadata $(METADATA) \
		--taxonomies $(TAXONOMIES) \
		--subset 'site == "$*"'

dipp-rf-uniq.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--normalize $(NORMALIZE) \
		--proportion \
		--otutable $(OTUTABLE) \
		--metadata $(METADATA) \
		--taxonomies $(TAXONOMIES)

dipp-for-richness.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--normalize rarefaction \
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

dipp-qpcr-%.RData:
	bin/write-rdata \
		--unique \
		--output $@ \
		--otutable ../data/$*.csv \
		--metadata $(METADATA) \
		--taxonomies $(TAXONOMIES) \
		--normalize none

sliding_window_qpcr: sliding-window-qpcr-bacteroides.pdf sliding-window-qpcr-dorei.pdf

sliding-window-qpcr-bacteroides.pdf: dipp-qpcr-bacteroides.RData
	bin/sliding-window-smooth \
		--input $< \
		--output $@ \
		--rank Genus \
		--by $(BY) \
		--absolute \
		--width $(WIDTH)

sliding-window-qpcr-dorei.pdf: dipp-qpcr-dorei.RData
	bin/sliding-window-smooth \
		--input $< \
		--output $@ \
		--rank Species \
		--by $(BY) \
		--absolute \
		--width $(WIDTH)

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth \
		--rank $* \
		--output $@ \
		--input $< \
		--width $(WIDTH) \
		--top $(TOP) \
		--by $(BY)

phyloseq: dipp-rf-uniq.RData

picrust: picrust-X0.pdf picrust-X1.pdf picrust-X2.pdf picrust-X3.pdf

glmulti-%.txt: dipp-rf-uniq.RData
	bin/glmulti-analysis \
		--input $< \
		--rank $% \
		--top $(TOP) \
		> $@

glmulti-picrust-%.txt: dipp-rf-uniq-metagenome.RData
	bin/glmulti-analysis \
		--input $< \
		--rank $% \
		--top $(TOP) \
		> $@

picrust-%.pdf: dipp-rf-uniq-metagenome.RData
	bin/sliding-window-smooth \
		--rank $* \
		--output $@ \
		--input $< \
		--width $(WIDTH)

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
