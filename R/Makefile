OTUTABLE?='../data/dipp.gg135.97.50r10s.csv'
METADATA?='../data/dipp.sample_data.csv'
TAXONOMIES?='../data/dipp.modified_taxonomies.csv'
NORMALIZE?='edger'

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
		--otutable '../data/dipp.predicted_metagenome.for_phyloseq.csv' \
		--metadata $(METADATA) \
		--taxonomies '../data/ko_tax_table.csv'

CUTS?=12

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $< --cuts $(CUTS) --top 12

phyloseq: dipp-rf-uniq.RData

picrust: picrust-X0.pdf picrust-X1.pdf picrust-X2.pdf picrust-X3.pdf

picrust-%.pdf: dipp-rf-uniq-metagenome.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $< --cuts $(CUTS) --top 64

clean:
	rm *.RData
	rm *.pdf
