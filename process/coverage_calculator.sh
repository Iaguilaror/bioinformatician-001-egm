#!/bin/bash

#Function to calculate breadth of coverage
function bcov()
{
	#File name as first parameter
	file=$1

	#Locus name as second parameter
	locus_name=$2

	#Calculate number of bases in the genomic region covered by at least one sequencing read
	covb=$(grep $locus_name $file | awk '$6 > 0 { sum +=1 } END { print sum }')
	
	#Calculate length of the genomic region, in bases
	reg_length=$(grep $locus_name $file|head -n1|awk '{ subs= ($3-$2)+1 } END { print subs }')
	
	#Calculate breadth of coverage, as percentage
	bcov_value=$(echo "scale=3; ($covb/$reg_length)*100" | bc)
	
	#Return two values, breadth of coverage and number of bases in the genomic region covered by at least one sequencing read
	echo $bcov_value $covb	
}

#Function to calculate mean depth of coverage
function mdcov
{
	#Number of bases in the genomic region covered by at least one sequencing readm as second parameter as first paramneter
	covb=$1
	
	#File name as second parameter
	file=$2
	
	#Locus name as third parameter
	locus_name=$3

	#Calculate sum of depths by base from every covered base
	seqb=$(grep $locus_name $file|awk '$6 > 0 { sum +=$6 } END { print sum }')
	
	#Calculate mean depth of coverage, as times X 
	mdcov=$(echo "scale=4; ($seqb/$covb)" |bc)
	
	#Return mean depth of coverage value
	echo $mdcov
}

#Path of the file as a parameter for the script
file=$1

#If the file exists, the analysis process is performed
if [ -f $file ];
then
	#The headers are written to the output file
	echo "Chromosome	Start	End	Locus_name	bcov	mdcov" >../results-examples/coverage_calculations.tsv
	
	#The headers are written to the output file, this file is for graphing in R
        echo "Chromosome        Start   End     Locus_name      bcov    mdcov" >../results-examples/coverage_calculations_R_graph.tsv	
	
	#Iteration with the locus name unique
	for locus in $(cut -f4 ../test-materials/test-data/raw_coverages_by_base.tsv|sort|uniq)
	do
		#String with the first 4 columns, the first line is extracted
		line=$(grep $locus $file|cut -f1-4|head -n1)

		#Line to graph in R
		line_R_plot=$(echo $line|sed -e 's/.$//')
		
		#The two values ​​returned by the bcov function are obtained: breadth of coverage and number of bases in the genomic region covered by at least one sequencing read
		read bcov_value covb < <(bcov $file $locus)
        	
		#The value returned by the mdcov function is obtained: mean depth of coverage value
		mdcov_value=$(mdcov $covb $file $locus)
		
		#The first 4 columns and the calculated values ​​are written to the output file
		echo $line"	"$bcov_value"	"$mdcov_value >>../results-examples/coverage_calculations.tsv
		
		#The first 4 columns and the calculated values ​​are written to the output file, this file is for graphing in R
		echo $line_R_plot"     "$bcov_value"   "$mdcov_value >>../results-examples/coverage_calculations_R_graph.tsv
	done
	
	#Command to generate the point graph in R
	Rscript plotter.R ../results-examples/coverage_calculations_R_graph.tsv

	#
	rm ../results-examples/coverage_calculations_R_graph.tsv	

#If the file does not exist, an error message is sent 
else
	echo "The file does not exist, please check the input file."
fi
