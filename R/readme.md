# R Code


## Instructions

1. Create a phyloseq object

This will load the OTU table, metadata and taxonomy table, import into 
Phyloseq and save the Phyloseq object as an `RData` file:

```
bin/write-rdata --unique --rarefy --output dipp-uniq-rarefy.RData
```


2. Run a script

```
bin/sliding-window-smooth
```
