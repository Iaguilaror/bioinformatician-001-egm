# NGS-Seq Coverage Calculation

# Test for bioinformatics skills

This test evaluates the following required skills:

 - use of bash
 - use of awk
 - use of R

## = Evaluation context =

* The number of required skills used will be taken into account.

* It is great to use other bioinformatic solutions (languages, commands, databases, etc.) 
  to solve the problem given; evaluation will take into account the cleverness of proposed solutions, except if it
  sacrifices readability and economy of the code. In other words: less is more; try to solve the problem with the least amount
  of code lines, but don't abuse one liners or obscure uncommented pieces of code. Remember: we bioinformaticians must code for humans.

* Documentation of the process followed to solve the test is HIGHLY encouraged; use comments inside the scripts,
  README.md files, as well as .txt files explaining the process and results of the requested bioinformatic analysis.

## IMPORTANT

* If you have trouble finishing this test, don't worry; you can deliver your progress and code so far.
  Consider writing a brief report of why you had troubles, and possible solutions. This also helps you showcase
  other important skills!

## = Bioinformatics solution evaluation checklist =

### Essentials:

- [ ] Script(s) solves the problem
- [ ] Script(s) uses bash
- [ ] Script(s) uses R

### Extras (half a point):

- [ ] Script uses awk.
- [ ] Script(s) uses another language, tool, command, etc to solve the problem.
- [ ] Delivered test directory is properly versionated in a public git repository provided by the Winter Genomics team.
- [ ] Delivered test directory includes process/README.md, which describes the contents of the delivered directory and the process followed by the proposed solution.
- [ ] Delivered test directory includes analysis_report.pdf, which gives a concrete, well written answer to the problem given.
- [ ] Delivered test directory follows the file structure proposed in this document.

# #########
# = TEST START - Now let's get hands-on! =
# #########

## PROBLEM DESCRIPTION

You are collaborating in a brief R&D project in a company called HSapiens.inc. 
A DNA sample was extracted by a new method that promises to isolate only 
focused regions of the human genome, in great quantities. DNA was sequenced 
by Illumina technology.

The promised isolated regions contain a panel of 3 "Golden Genes" surrounded 
by unwanted regions. The research team wants to measure the specificity of 
DNA extraction for the Golden Genes. In other words, they want to see how 
much of the isolated DNA belongs to that given set of regions of the genome. 
DNA from the unwanted regions is, well... unwanted, and should not have been extracted.

Previously, other members of the bioinformatics team have mapped the 
sequencing reads to the human genome reference, using the bwa algorithm. 
They also used the `bedtools coverage` tool to do some raw calculations on 
sequencing coverage.

Then they contacted you to do the final coverage calculations, generate 
descriptive plots, and give your opinion on the specificity of the new DNA 
isolation technique.

## SOME IMPORTANT TECHNICAL CONCEPTS

For this test, we consider the following definitions:

### Depth by base
For a given position in the genome, the number of mapped sequencing reads that include that base.

### Breadth of coverage 

For a genomic region of interest, the percentage of total bases mapped (or covered) by at least one sequencing read. 
Calculated as:

```

		bcov = covb/regl * 100
	
where:

bcov = Breadth of coverage, as percentage
covb = Number of bases in the genomic region covered by at least one sequencing read
regl = Length of the genomic region, in bases

```

### Mean depth of coverage (adjusted) 

The average number of reads covering a base *in the sequenced part* of the genomic region of interest. Calculated as:

```

    	mdcov = seqb / covb

where:

mdcov = Mean depth of coverage, as times X (i.e. 30X, 200X, 500X)
seqb = Sum of depths by base from every covered base
covb = Number of bases in the genomic region covered by at least one sequencing read

```

A common report of coverage values would be:

> For the targeted genomic regions, 90% of the bases where covered with a mean depth of coverage of 200X.

## Input data Format

* The starting point for this test is a randomly generated raw coverage by base file, with the following tab-separated values format:

````
Chromosome	Start	End	Locus_name position_in_locus	Depth_by_base
22	147620	147719	GOLDEN_GENE1	1	5
22	147620	147719	GOLDEN_GENE1	2	5
22	147620	147719	GOLDEN_GENE1	3	7
````

As you can see, if a locus has a length of 100 bases, the input file will 
have 100 lines, one for every position of the locus.

## = RESULTS EXPECTATIONS =

Your bioinformatic challenge is to calculate:

 1. The mean depth of coverage (mdcov) for every requested locus, from the raw coverage by base provided.

 2. The breadth of coverage (bcov) for every requested locus, from the same raw file.

 3. The panel's mean depth of coverage, when taking into account all the loci of interest (Golden Genes).

 4. The panel's breadth of coverage, when taking into account all the loci of interest (Golden Genes).


Your collaborators also requested a brief report that includes:

1. A table with the coverage values for the loci

2. A plot comparing mdcov vs bcov at every loci, highlighting the Golden Genes

3. Your opinion on the specificity of the DNA isolation technique, from what you observed

*IMPORTANT* There is an example of the requested results report at the results-examples directory.

# #########
## = TEST DIRECTORY DESCRIPTION =
# #########

By delivery, your test directory should look like this, and have at least the following files
(you can have extra files and directories, but remember, less is more):

````
Bioinformatician-001/		## The original cloned repository directory
├── process				    ## This is the directory where your code will be
│   ├── README.md			## A readme file explaining your process (a template is provided)
│   ├── plotter.R			## For example, your Rscript to plot the requested figures (no template is provided)
│   └── coverage_calculator.sh		## For example, your main bash script for calculating the requested coverage values (no template is provided)
├── README.md				## This README file, explaining the test
├── results-examples	    		## We provide examples of the requested outputs, your results should be as close to this as possible
│   ├── coverage_calculations.tsv	## An example of the requested results, generated by Winter Genomics team
│   └── final_report.md		## An example of the report that answers the original questions posed by the PROBLEM DESCRIPTION
└── test-materials			## In this directory we provide the necessary data to generate the requested results
    └── test-data
        └── raw_coverages_by_base.tsv    ## A raw coverage file. Was generated with bedtools v2.25.0 using the -d option, using a public BAM file and a focused BED file for the loci of interest

````

### Now you're ready to take the test. Do your best!
