setwd("../")



set.seed(14884) #Seed 2


#' Source scripts
source("../general_scripts/lambdacoal_sim.R")
source("../general_scripts/elength_lambdaxi.R")
source("../general_scripts/ext_fun_CREB.R")
source("../general_scripts/ext_fun_TajD_FWH.R")
source("../general_scripts/divstats.R")
source("construct_prior.R")
source("divfunwrappers.R")

#' Wrapper for the different simulation scripts
#' We use ms to simulate Kingman and related coalescents

library(phyclust) #R implementation of Hudson's ms
library(gap) #Read in output of ms
library(parallel)

sim_seq <- function(nsamp1,theta1,coal_param=0,model=1){
  KM <- (model==1 & coal_param==0) | (model==2 & length(coal_param)==1 & coal_param==2) | (model==6)
  if (KM){raw_seq <- ms(nsam=nsamp1,opts=paste("-t",theta1))
  seq1 <- t(read.ms.output(raw_seq,is.file = FALSE)$gametes[[1]])}
  if (model==1 & !KM){
    raw_seq <- ms(nsam=nsamp1,opts=paste("-t",theta1,"-G",coal_param))
    seq1 <- t(read.ms.output(raw_seq,is.file = FALSE)$gametes[[1]])
  }
  if (model==2 & !KM){
    if (length(coal_param)==1){coal_param <- c(2-coal_param[1],coal_param[1])}
    if (all(coal_param == c(1,1))){seq1 <- bsz_seq_sim(nsamp1,theta1)} else {
      seq1 <- beta_seq_sim(nsamp1,coal_param[1],coal_param[2],theta1)}
  }
  if (model==3){
    seq1 <-  dirac_seq_sim(nsamp1,coal_param,theta1)
  }
  if (sum(seq1)==0){return(NA)}
  return(seq1)
}


#' Number of clusters

mc1 <- 16

#' We produce an additional replication of simulations 
#' Number of simulations per model class
nsim <- 175000

#' Sample size n
nsamp <- 100

for (i in 1:2){

#' Switch folders since Watterson estimator for exponential growth is computed via C script that needs
#' to be called in the right directory
setwd("../general_scripts/")
prior1 <- prior_obs_s_cont(nsamp,models=c(1,2),nsimul=c(nsim,nsim,0,0,0,0),
                            ranges = list(c(log(0.5),log(1000)),
                                          c(1,2),NULL,NULL,NULL,0),
                            s_obs = c(15,20,30,40,60,75),log_growth = TRUE,
                             include_g0 = nsim*0.02)  
setwd("../distpaper_res/")

clu1 <- makeForkCluster(nnodes = mc1)

sims1 <- parApply(clu1,prior1,1,function(x){
  divfun_no_s(sim_seq(nsamp1 = x[1],theta1 = x[5],coal_param = x[3],model = x[2]))})

stopCluster(clu1)

save(prior1,sims1,file=paste0("sims_rep",i,"/sim_m12_nos_n",
                              nsamp,".RData"))
}
