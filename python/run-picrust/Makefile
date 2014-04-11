# Makefile for running PICRUST calculations

#
# Instructions:
#
# $ make my-otu-table-metagenome.tab
#
# lots of waiting ...
# You have a predicted metagenome!
#

# 1. Convert to qiime-like format, remove unclassified_reads column
# 2. Convert tab file to biom file.
# 3. Normalize by copy number.
# 4. Predict metagenome.
# 5. Convert metagenome biom file to tab-delimited.
# 6. Calculate metagenome contributions

# preseve intermediate biom and tab files
# as some take forever to calculate

default: ../data/dipp-otus-metagenome.tab

.PRECIOUS: %-qiime.tab
# 1. Convert to qiime-like format.
%-qiime.tab: %.csv
	./csv-to-qiime.py --remove-unclassified < $< > $@

.PRECIOUS: %-qiime.biom
# 2. Convert tab to biom
%-qiime.biom: %-qiime.tab
	biom convert \
		--table-type 'otu table' \
		--input-fp $< \
		--output-fp $@

.PRECIOUS: %-normalized.biom
# 3. Normalize by copy number
%-normalized.biom: %-qiime.biom
	normalize_by_copy_number.py \
		--gg_version '13_5' \
		--input_otu_fp $< \
		--output_otu_fp $@

.PRECIOUS: %-metagenome.biom
%-metagenome.biom: %-normalized.biom
	scripts/predict_metagenomes.py \
		--input_otu_table $< \
		--output_metagenome_table $@

.PRECIOUS: %-metagenome.tab
%-metagenome.tab: %-metagenome.biom
	biom convert \
		--biom-to-classic-table \
		--input-fp $< \
		--output-fp $@

.PRECIOUS: %-metagenome-contributions.tab
%-metagenome-contributions.tab: %-normalized.biom
	scripts/metagenome_contributions.py \
		--input_otu_table $< \
		--output_fp $@
