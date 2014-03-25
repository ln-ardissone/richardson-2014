default: sliding_window
	echo 'done!'

sliding_window: sliding-window-Phylum.pdf sliding-window-Class.pdf sliding-window-Order.pdf sliding-window-Family.pdf sliding-window-Genus.pdf sliding-window-Species.pdf

dipp-rf-uniq.RData:
	bin/write-rdata \
		--unique \
		--rarefy \
		--output $@ \
		--otutable ../data/dipp.gg135.97.50r10s.csv \
		--metadata ../data/dipp.sample_data.csv \
		--taxonomies ../data/dipp.modified_taxonomies.csv

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $<

phyloseq: dipp-rf-uniq.RData
