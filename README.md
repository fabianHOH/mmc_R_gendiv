# mmc_R_gendiv: Genetic diversity from coalescent models

This repository contains simulation and inference scripts for multiple merger and other n-coalescents as well as functions to compute genetic diversity statistics from SNP matrices in zero-one format.

COMMENTS ARE VERY WELCOME! 

# Examples and explanations
Please see [a_short_intro_w_examples.Rmd](a_short_intro_w_examples.Rmd) (or its pdf output, both in this folder) for an overview of the most important functions we supply.

# Installation

 * Clone the repository 
  * All scripts run on an Unix-based system. This only matters if scripts involve       parallelized computations, which will not (directly) work under Windows     
    operating system.  
 * All but two scripts/functions run directly. 
     * For using general_scripts/ext_fun_CREB.R (computes expected branch lengths for Kingman's $n$-coalescent with exponential growth, see below for more information), a C script needs to be compiled, see documentation within the script for details.     
     * When using (sourcing) general_scripts/ext_fun_TajD_FWH.R, a further repository is used, so this needs an active internet connection. 

# Subfolders distpaper_res/, general_scripts/ and seeds/

R scripts to simulate genetic diversity under multiple merger (and other) coalescents and perform ABC inference of the genealogy model based on SNP data 

Code by F. Freund ([U. Hohenheim](http://evoplant.uni-hohenheim.de/people/freund/)) and A. Siri-Jégousse ([IIMAS, UNAM Mexico City](http://sigma.iimas.unam.mx/arno/))

The repository includes sample code we used for our manuscript "The impact of genetic diversity statistics on model selection between coalescents" (2020), Computational Statistics & Data Analysis, in press <https://www.sciencedirect.com/science/article/abs/pii/S0167947320301468>. 
A preprint (differently named, essentially identical paper) is available at <https://www.biorxiv.org/content/10.1101/679498v2>. See folder distpaper_res.

We thank [Bjarki Eldon (Museum für Naturkunde, Berlin)](http://page.math.tu-berlin.de/~eldon/index.html) for allowing us to share his code here for computing the expected branch lengths for Kingman's n-coalescent with exponential growth (see README in folder general_scripts). 

Citation: The mentioned paper

Distinguishing coalescent models - which statistics matter most?

Fabian Freund, Arno Siri-Jégousse

bioRxiv 679498; doi: <https://doi.org/10.1101/679498>

# Subfolder MTB_MMC_repo

Contains R code that applies the simulation and inference tools from above to *Mycobacterium tuberculosis* data sets. Includes simulation tools for serial sampling in different coalescent models.
R code by F. Menardo, S. Gagneux ([Department of Medical Parasitology and Infection Biology, Swiss Tropical and Public Health Institute/University of Basel, Basel, Switzerland](https://www.swisstph.ch/en/about/mpi/tuberculosis-research/)) and F. Freund  ([U. Hohenheim](http://evoplant.uni-hohenheim.de/people/freund/)).

Citation:

Multiple merger genealogies in outbreaks of *Mycobacterium tuberculosis*

Fabrizio Menardo, Sébastien Gagneux, Fabian Freund

Molecular Biology and Evolution, msaa179 (2020) 
https://doi.org/10.1093/molbev/msaa179

# Subfolder eturc_mmc/

Contains the R code for the ABC analysis from the preprint "Population history of the Northern corn leaf blight fungal pathogen *Setosphaeria turcica* in Europe" from M. Vidal-Villarejo et al (soon on biorxiv). Essentially just an application of the methodology used for *Mycobacterium tuberculosis*, but without polarized SNP data. 