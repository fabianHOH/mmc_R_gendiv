* CREBiepg.c and its R wrapper within ext_funs.R: Copyright (2014):  Bjarki Eldon, distributed under GNU GPL v3 or later
* lambdacoal_sim.R, betaxicoal_sim.R: Coalescent simulators for Lambda- and Xi-n-coalescents. So far, only Beta, Dirac and 
  BetaXi n-coalescents are explicitly supported. However, if you provide the function of transition rates in the form 
  as for the supported ones, other n-coalescents can be easily added 
*  elength_lambdaxi.R: Allows to recursively compute the expected total length of supported n-coalescents 
   (see Eq. 2.3 in Möhle, On the number of segregating sites for populations with large family sizes, 
   Adv. in Appl. Probab. 38, 2006)
* misc_funs: Includes a minor modification of the `abcrf` command from R package `abcrf` to use the adjusted 
  variable importances from Sandri & Zuccolotto, A Bias Correction Algorithm for the Gini Variable Importance 
  Measure in Classification Trees, J. Comp. Graphic. Stat. 17, 2008 and a binomial perturbation around a real number 
  on log equidistant steps (whic we use for prior construction for the scaled mutation rate theta around Watterson's estimator)
 *  divstats.R: Includes various diversity statistics computed from zero-one SNP matrices
 * ext_funs.R: Includes code not programmed by us, **see the script for details** (one function is sourced from another repository 
   https://github.com/sdwfrost/popseq, the other needs a compiled version of CREBiepg.c)