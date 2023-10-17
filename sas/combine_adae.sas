/*____________________________________________________________________________
* Sponsor              : Domino
* Compound             : DomMedimol
* Study                : Pilot01
* Analysis             : -
* Program              : combine.sas
* ____________________________________________________________________________
* DESCRIPTION 
*
* The purpose of this program is to convert the raw XPT data to SDTM.
*                                                                   
* Input files:
* - /mnt/imported/data/ADAM/adae.sas7bdat
* - /mnt/imported/data/ADAM_1/adae.sas7bdat
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
   set in1.adae in2.adae;
run;

/* Close the libraries */
libname in1 clear;
libname in2 clear;
libname out clear;
