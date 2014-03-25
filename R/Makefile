default: sliding_window
	echo 'done!'

sliding_window: sliding-window-Phylum.pdf sliding-window-Class.pdf sliding-window-Order.pdf sliding-window-Family.pdf sliding-window-Genus.pdf sliding-window-Species.pdf

dipp-rf-uniq.RData:
	bin/write-rdata --unique --rarefy --output $@

sliding-window-%.pdf: dipp-rf-uniq.RData
	bin/sliding-window-smooth --rank $* --output $@ --input $<

phyloseq: dipp-rf-uniq.RData
