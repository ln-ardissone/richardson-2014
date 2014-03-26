OTUTABLE?='../data/dipp.gg135.97.50r10s.csv'
METADATA?='../data/dipp.sample_data.csv'
TAXONOMIES?='../data/dipp.modified_taxonomies.csv'

default: sliding_window
	echo 'done!'

sliding_window: sliding-window-Phylum.pdf sliding-window-Class.pdf sliding-window-Order.pdf sliding-window-Family.pdf sliding-window-Genus.pdf sliding-window-Species.pdf

dipp-rf-uniq.RData:
	bin/write-rdata \
		--unique \
		--rarefy \
		--output $@ \
		--otutable $(OTUTABLE) \
		--metadata $(METADATA) \
		--taxonomies $(TAXONOMIES)

CUTS?=12

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $< --cuts $(CUTS)

phyloseq: dipp-rf-uniq.RData
