# lifted from: http://joey711.github.io/waste-not-supplemental/simulation-cluster-accuracy/simulation-cluster-accuracy-server.html
edgeRnorm = function(physeq, ...) {
    require("edgeR")
    require("phyloseq")

    physeq <- t(physeq)

    x = as(otu_table(physeq), "matrix")

    # See if adding a single observation, 1, everywhere (so not zeros) prevents
    # errors without needing to borrow and modify calcNormFactors (and its
    # dependent functions) It did. This fixed all problems.  Can the 1 be
    # reduced to something smaller and still work?

    x = x + 1

    # Now turn into a DGEList
    y = edgeR::DGEList(counts = x, remove.zeros = TRUE)

    # Perform edgeR-encoded normalization, using the specified method (...)
    z = edgeR::calcNormFactors(y, ...)

    # A check that we didn't divide by zero inside `calcNormFactors`
    if (!all(is.finite(z$samples$norm.factors))) {
        stop("Something wrong with edgeR::calcNormFactors on this data, non-finite $norm.factors")
    }

    # Don't need the following additional steps, which are also built-in to some
    # of the downstream distance methods. z1 = estimateCommonDisp(z) z2 =
    # estimateTagwiseDisp(z1)

    return(t(z))
}

deseq_varstab = function(physeq, sampleConditions = rep("A", nsamples(physeq)), 
    ...) {
    require("DESeq")
    # Enforce orientation.
    if (!taxa_are_rows(physeq)) {
        physeq <- t(physeq)
    }
    x = as(otu_table(physeq), "matrix")
    # The same tweak as for edgeR to avoid NaN problems that cause the workflow
    # to stall/crash.
    x = x + 1
    # Create annotated data.frame with the taxonomy table, in case it is useful
    # later
    taxADF = as(data.frame(as(tax_table(physeq), "matrix"), stringsAsFactors = FALSE), 
        "AnnotatedDataFrame")
    cds = newCountDataSet(x, sampleConditions, featureData = taxADF)
    # First estimate library size factors
    cds = estimateSizeFactors(cds)
    # Variance estimation, passing along additional options
    cds = estimateDispersions(cds, ...)
    # Determine which column(s) have the dispersion estimates
    dispcol = grep("disp\\_", colnames(fData(cds)))
    # Enforce that there are no infinite values in the dispersion estimates
    if (any(!is.finite(fData(cds)[, dispcol]))) {
        fData(cds)[which(!is.finite(fData(cds)[, dispcol])), dispcol] <- 0
    }
    vsmat = exprs(varianceStabilizingTransformation(cds))
    otu_table(physeq) <- otu_table(vsmat, taxa_are_rows = TRUE)
    return(physeq)
}
