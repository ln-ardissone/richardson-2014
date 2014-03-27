# R Code

## Requirements

- [R](http://www.r-project.org) 3.0.0
- [Phyloseq](https://github.com/joey711/phyloseq)
- [Optparse](https://github.com/trevorld/optparse)

## Instructions

`make`

### Individual scripts

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
