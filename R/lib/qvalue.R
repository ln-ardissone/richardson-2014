#!/usr/bin/env rscript

# code from: http://www.bioconductor.org/packages/release/bioc/html/qvalue.html

#                   GNU LESSER GENERAL PUBLIC LICENSE
#                       Version 3, 29 June 2007
#
# Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#
#
#  This version of the GNU Lesser General Public License incorporates
#the terms and conditions of version 3 of the GNU General Public
#License, supplemented by the additional permissions listed below.
#
#  0. Additional Definitions.
#
#  As used herein, "this License" refers to version 3 of the GNU Lesser
#General Public License, and the "GNU GPL" refers to version 3 of the GNU
#General Public License.
#
#  "The Library" refers to a covered work governed by this License,
#other than an Application or a Combined Work as defined below.
#
#  An "Application" is any work that makes use of an interface provided
#by the Library, but which is not otherwise based on the Library.
#Defining a subclass of a class defined by the Library is deemed a mode
#of using an interface provided by the Library.
#
#  A "Combined Work" is a work produced by combining or linking an
#Application with the Library.  The particular version of the Library
#with which the Combined Work was made is also called the "Linked
#Version".
#
#  The "Minimal Corresponding Source" for a Combined Work means the
#Corresponding Source for the Combined Work, excluding any source code
#for portions of the Combined Work that, considered in isolation, are
#based on the Application, and not on the Linked Version.
#
#  The "Corresponding Application Code" for a Combined Work means the
#object code and/or source code for the Application, including any data
#and utility programs needed for reproducing the Combined Work from the
#Application, but excluding the System Libraries of the Combined Work.
#
#  1. Exception to Section 3 of the GNU GPL.
#
#  You may convey a covered work under sections 3 and 4 of this License
#without being bound by section 3 of the GNU GPL.
#
#  2. Conveying Modified Versions.
#
#  If you modify a copy of the Library, and, in your modifications, a
#facility refers to a function or data to be supplied by an Application
#that uses the facility (other than as an argument passed when the
#facility is invoked), then you may convey a copy of the modified
#version:
#
#   a) under this License, provided that you make a good faith effort to
#   ensure that, in the event an Application does not supply the
#   function or data, the facility still operates, and performs
#   whatever part of its purpose remains meaningful, or
#
#   b) under the GNU GPL, with none of the additional permissions of
#   this License applicable to that copy.
#
#  3. Object Code Incorporating Material from Library Header Files.
#
#  The object code form of an Application may incorporate material from
#a header file that is part of the Library.  You may convey such object
#code under terms of your choice, provided that, if the incorporated
#material is not limited to numerical parameters, data structure
#layouts and accessors, or small macros, inline functions and templates
#(ten or fewer lines in length), you do both of the following:
#
#   a) Give prominent notice with each copy of the object code that the
#   Library is used in it and that the Library and its use are
#   covered by this License.
#
#   b) Accompany the object code with a copy of the GNU GPL and this license
#   document.
#
#  4. Combined Works.
#
#  You may convey a Combined Work under terms of your choice that,
#taken together, effectively do not restrict modification of the
#portions of the Library contained in the Combined Work and reverse
#engineering for debugging such modifications, if you also do each of
#the following:
#
#   a) Give prominent notice with each copy of the Combined Work that
#   the Library is used in it and that the Library and its use are
#   covered by this License.
#
#   b) Accompany the Combined Work with a copy of the GNU GPL and this license
#   document.
#
#   c) For a Combined Work that displays copyright notices during
#   execution, include the copyright notice for the Library among
#   these notices, as well as a reference directing the user to the
#   copies of the GNU GPL and this license document.
#
#   d) Do one of the following:
#
#       0) Convey the Minimal Corresponding Source under the terms of this
#       License, and the Corresponding Application Code in a form
#       suitable for, and under terms that permit, the user to
#       recombine or relink the Application with a modified version of
#       the Linked Version to produce a modified Combined Work, in the
#       manner specified by section 6 of the GNU GPL for conveying
#       Corresponding Source.
#
#       1) Use a suitable shared library mechanism for linking with the
#       Library.  A suitable mechanism is one that (a) uses at run time
#       a copy of the Library already present on the user's computer
#       system, and (b) will operate properly with a modified version
#       of the Library that is interface-compatible with the Linked
#       Version.
#
#   e) Provide Installation Information, but only if you would otherwise
#   be required to provide such information under section 6 of the
#   GNU GPL, and only to the extent that such information is
#   necessary to install and execute a modified version of the
#   Combined Work produced by recombining or relinking the
#   Application with a modified version of the Linked Version. (If
#   you use option 4d0, the Installation Information must accompany
#   the Minimal Corresponding Source and Corresponding Application
#   Code. If you use option 4d1, you must provide the Installation
#   Information in the manner specified by section 6 of the GNU GPL
#   for conveying Corresponding Source.)
#
#  5. Combined Libraries.
#
#  You may place library facilities that are a work based on the
#Library side by side in a single library together with other library
#facilities that are not Applications and are not covered by this
#License, and convey such a combined library under terms of your
#choice, if you do both of the following:
#
#   a) Accompany the combined library with a copy of the same work based
#   on the Library, uncombined with any other library facilities,
#   conveyed under the terms of this License.
#
#   b) Give prominent notice with the combined library that part of it
#   is a work based on the Library, and explaining where to find the
#   accompanying uncombined form of the same work.
#
#  6. Revised Versions of the GNU Lesser General Public License.
#
#  The Free Software Foundation may publish revised and/or new versions
#of the GNU Lesser General Public License from time to time. Such new
#versions will be similar in spirit to the present version, but may
#differ in detail to address new problems or concerns.
#
#  Each version is given a distinguishing version number. If the
#Library as you received it specifies that a certain numbered version
#of the GNU Lesser General Public License "or any later version"
#applies to it, you have the option of following the terms and
#conditions either of that published version or of any later version
#published by the Free Software Foundation. If the Library as you
#received it does not specify a version number of the GNU Lesser
#General Public License, you may choose any version of the GNU Lesser
#General Public License ever published by the Free Software Foundation.
#
#  If the Library as you received it specifies that a proxy can decide
#whether future versions of the GNU Lesser General Public License shall
#apply, that proxy's public statement of acceptance of any version is
#permanent authorization for you to choose that version for the
#Library.

'qvalue' <- function (p = NULL, lambda = seq(0, 0.9, 0.05), pi0.method = "smoother",
    fdr.level = NULL, robust = FALSE, gui = FALSE, smooth.df = 3,
    smooth.log.pi0 = FALSE, n = NULL)
{
    if (is.null(p)) {
        qvalue.gui()
        return("Launching point-and-click...")
    }
    if (gui & !interactive())
        gui = FALSE
    if (min(p) < 0 || max(p) > 1) {
        if (gui)
            eval(expression(postMsg(paste("ERROR: p-values not in valid range.",
                "\n"))), parent.frame())
        else print("ERROR: p-values not in valid range.")
        return(0)
    }
    if (length(lambda) > 1 && length(lambda) < 4) {
        if (gui)
            eval(expression(postMsg(paste("ERROR: If length of lambda greater than 1, you need at least 4 values.",
                "\n"))), parent.frame())
        else print("ERROR: If length of lambda greater than 1, you need at least 4 values.")
        return(0)
    }
    if (length(lambda) > 1 && (min(lambda) < 0 || max(lambda) >=
        1)) {
        if (gui)
            eval(expression(postMsg(paste("ERROR: Lambda must be within [0, 1).",
                "\n"))), parent.frame())
        else print("ERROR: Lambda must be within [0, 1).")
        return(0)
    }
    m <- length(p)
    if (length(lambda) == 1) {
        if (lambda < 0 || lambda >= 1) {
            if (gui)
                eval(expression(postMsg(paste("ERROR: Lambda must be within [0, 1).",
                  "\n"))), parent.frame())
            else print("ERROR: Lambda must be within [0, 1).")
            return(0)
        }
        pi0 <- mean(p >= lambda)/(1 - lambda)
        pi0 <- min(pi0, 1)
    }
    else {
        pi0 <- rep(0, length(lambda))
        for (i in 1:length(lambda)) {
            pi0[i] <- mean(p >= lambda[i])/(1 - lambda[i])
        }
        if (pi0.method == "smoother") {
            if (smooth.log.pi0)
                pi0 <- log(pi0)
            spi0 <- smooth.spline(lambda, pi0, df = smooth.df)
            pi0 <- predict(spi0, x = max(lambda))$y
            if (smooth.log.pi0)
                pi0 <- exp(pi0)
            pi0 <- min(pi0, 1)
        }
        else if (pi0.method == "bootstrap") {
            minpi0 <- min(pi0)
            mse <- rep(0, length(lambda))
            pi0.boot <- rep(0, length(lambda))
            for (i in 1:100) {
                p.boot <- sample(p, size = m, replace = TRUE)
                for (i in 1:length(lambda)) {
                  pi0.boot[i] <- mean(p.boot > lambda[i])/(1 -
                    lambda[i])
                }
                mse <- mse + (pi0.boot - minpi0)^2
            }
            pi0 <- min(pi0[mse == min(mse)])
            pi0 <- min(pi0, 1)
        }
        else {
            print("ERROR: 'pi0.method' must be one of 'smoother' or 'bootstrap'.")
            return(0)
        }
    }
    if (pi0 <= 0) {
        if (gui)
            eval(expression(postMsg(paste("ERROR: The estimated pi0 <= 0. Check that you have valid p-values or use another lambda method.",
                "\n"))), parent.frame())
        else print("ERROR: The estimated pi0 <= 0. Check that you have valid p-values or use another lambda method.")
        return(0)
    }
    if (!is.null(fdr.level) && (fdr.level <= 0 || fdr.level >
        1)) {
        if (gui)
            eval(expression(postMsg(paste("ERROR: 'fdr.level' must be within (0, 1].",
                "\n"))), parent.frame())
        else print("ERROR: 'fdr.level' must be within (0, 1].")
        return(0)
    }
    u <- order(p)
    qvalue.rank <- function(x) {
        idx <- sort.list(x)
        fc <- factor(x)
        nl <- n
        bin <- as.integer(fc)
        tbl <- tabulate(bin)
        cs <- cumsum(tbl)
        tbl <- rep(cs, tbl)
        tbl[idx] <- tbl
        return(tbl)
    }
    v <- qvalue.rank(p)
    qvalue <- pi0 * m * p/v
    if (robust) {
        qvalue <- pi0 * m * p/(v * (1 - (1 - p)^m))
    }
    qvalue[u[m]] <- min(qvalue[u[m]], 1)
    for (i in (m - 1):1) {
        qvalue[u[i]] <- min(qvalue[u[i]], qvalue[u[i + 1]], 1)
    }
    if (!is.null(fdr.level)) {
        retval <- list(call = match.call(), pi0 = pi0, qvalues = qvalue,
            pvalues = p, fdr.level = fdr.level, significant = (qvalue <=
                fdr.level), lambda = lambda)
    }
    else {
        retval <- list(call = match.call(), pi0 = pi0, qvalues = qvalue,
            pvalues = p, lambda = lambda)
    }
    class(retval) <- "qvalue"
    return(retval)
}
