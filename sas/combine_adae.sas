/*____________________________________________________________________________
* Sponsor              : Domino
* Compound             : DomMedimol
* Study                : Pilot01
* Analysis             : -
* Program              : combine.sas
* ____________________________________________________________________________
* DESCRIPTION 
*
* The purpose of this program is to pool ADAE datasets from the CDISC01 and CDISC02 
* studies into a single pooled ADAE dataset
*                                                                   
* Input files:
* - /mnt/imported/data/ADAM/adae_shiny.sas7bdat
* - /mnt/imported/data/ADAM_1/adae_shiny.sas7bdat
*
* Output files:                                                   
* - /mnt/data/POOLEDADAM/adae.sas7bdat
* ____________________________________________________________________________
* PROGRAM HISTORY                                                         
* ----------------------------------------------------------------------------
*  20231017  |  petter        | Program creation         
\*****************************************************************************/

/* Specify the paths to your input datasets */
libname in1 '/mnt/imported/data/ADAM';
libname in2 '/mnt/imported/data/ADAM_1';
libname out '/mnt/data/POOLEDADAM';

/* Use DATA step to combine datasets */
data out.adae;
   set in1.adae_shiny in2.adae_shiny;
run;

/* Close the libraries */
libname in1 clear;
libname in2 clear;
libname out clear;

/* Re-open the output library */
libname out '/mnt/data/POOLEDADAM';

/* Sort the data by AEDECOD for the PROC FREQ */
proc sort data=out.adae; 
    by AEDECOD; 
run; 

/* Get frequency count of AEDECOD */
proc freq data=out.adae noprint; 
    tables AEDECOD / out=ae_freq; 
run;

/* Create the bar chart */
title "Frequency of Adverse Events";
proc sgplot data=ae_freq;
    vbar AEDECOD / response=COUNT;
    xaxis display=none;  /* This line removes all labels from the x-axis */
run;

/* Write the chart to a PDF */
ods pdf file="/mnt/artifacts/results/AE_Frequency.pdf";
title "Frequency of Adverse Events";
proc sgplot data=ae_freq;
    vbar AEDECOD / response=COUNT;
    xaxis display=none;  /* This line removes all labels from the x-axis */
run;
ods pdf close;

/* Close the output library */
libname out clear;

