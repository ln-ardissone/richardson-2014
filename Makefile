THREADS?=1

default:
	cd R && make -j $(THREADS)
	cd picrust && make


# need to convert CSV files to "QIIME" CSV files
richardson-2014.biom:
	gzcat data/dipp-otus.csv.gz > temp.csv
	biom convert \
		--input-fp temp.csv \
		--sample-metadata-fp=data/dipp-sample_data.csv \
		--observation-metadata-fp=data/dipp-tax_table.csv \
		--matrix-type=sparse \
		--table-type 'otu-table' \
		--output-fp $@
