#' ABC output is e.g. named modsel_rep2_m12_fold_n100.RData - only take the middle part. This needs to be adjusted 
args <- c("m12_all_n100ohamsfs",1,2)


load(paste0("abc_res/modsel_rep1_",args[1],".RData"))


res_conf1 <- res_conf
res_imp1 <- res_imp


load(paste0("abc_res/modsel_rep2_",args[1],".RData"))

#If necessary, rename filename
print(args[1])
namebool <- as.logical(readline("If keep name enter T, else F "))
if (!namebool){  
  args[1] <- readline("Enter new name: ")}  


models1 <- NULL
args_num <- as.numeric(args[-1])
for (i in args_num){models1 <- c(models1,switch(i,"K+exp","B","D","Xi-B","D + exp.","K",
                                                NULL,"2p-K-exp"))}

names0 <- names(res_conf)

# Check which variables were used, adjust l. 96++ below accordingly
print(sapply(res_imp,length))
print(sapply(res_imp1,length))
print(names(res_imp[[1]]))
print(names(res_imp1[[1]]))


let1 <- 3 #cex argument



names1 <- names0
for (k in seq(along=names0)){
print(names0[k])
namebool <- as.logical(readline("If keep name enter T, else F "))
if (!namebool){  
names1[k] <- readline("Enter new name: ")}  
}

#if (length(models1)<3 & length(names1)<7){width1 <- 12} else {width1 <- 20}
width1 <- 20
#pdf(paste0("pdfs/miscl_",args[1],".pdf"))
pdf(paste0("pdfs/miscl_",args[1],".pdf"),height=switch(as.character(length(models1)),"2"=12,"3"=20,
                                                       "4"=20),
                                          width=width1)
par(oma=c(1,0,0,0),mfrow=switch(length(models1),c(1,1),c(1,2),c(2,2),c(2,2),c(3,2),c(3,2)),cex=let1)
ylab1 <- paste("% Misclassification for",models1)
for (i in 1:length(args_num)){
error1 <- vector("list",2*length(names1))
for (j in 1:length(names1)){
error1[[2*j-1]] <- sapply(res_conf1[[j]],function(m){m[i,length(args)]})
error1[[2*j]] <- sapply(res_conf[[j]],function(m){m[i,length(args)]})
}
yvals <-100*range(unlist(error1))
if (yvals[1] >= 1){
yvals[1] <- floor(yvals[1])} else {yvals[1] <- round(yvals[1],3)}
yvals[2] <- ceiling(yvals[2])
plot(NULL,xlim = c(0,length(names1)+1),ylim=yvals,xaxt = "n",yaxt="n",xlab="",
     ylab=ylab1[i],log = "y")
axis(1,at= as.vector(sapply(1:length(names1),function(x){c(x,x+0.2)})),
     labels =  as.vector(sapply(names1,function(a){c(a,"")})),
     las=2)
axis(2,at=c(yvals[1],seq(ceiling(yvals[1]),yvals[2],1)),labels = c(yvals[1],seq(ceiling(yvals[1]),yvals[2],1)))
for (j in 1:length(names1)){
lines(c(j,j),100*range(error1[[2*j-1]]),type="l",lwd=2.5)
lines(c(j,j)+0.2,100*range(error1[[2*j]]),type="l",col="gray",lwd=2.5)
points(j,100*mean(error1[[2*j-1]]),pch=8)
points(j+0.2,100*mean(error1[[2*j]]),pch=8,col="gray")
  }


}
par(oma=c(0,0,0,0),mfrow=c(1,1),cex=let1)

dev.off()

varnames <- names(res_imp[[1]])
quantnames <- paste0("qu .",c(1,3,5,7,9))
quantnames_fine <- paste0("qu .",seq(1,9,1))

var_imps <- vector("list",length(varnames))
names(var_imps) <- varnames
var_imps2 <- var_imps
for (i in varnames){
var_imps[[i]] <- sapply(res_imp,function(v){v[i]})  
var_imps2[[i]] <- sapply(res_imp1,function(v){v[i]})  
}

#' Only when pooling var importance, e.g. for folded scenario
#tempvarimp <- NULL
#tempvarimp2 <- NULL
#for (var1 in paste0("fS",17:50)){tempvarimp <- unname(c(tempvarimp,var_imps[[var1]]))
#                                 tempvarimp2 <- unname(c(tempvarimp2,var_imps2[[var1]]))}
#var_imps <- c(var_imps[1:30],"fS17-50"=list(tempvarimp))
#var_imps2 <- c(var_imps2[1:30],"fS17-50"=list(tempvarimp2))
#varnames <- names(var_imps)

#Adjust variable importance scored variables here
varnames2 <- list(#c("O: hm",paste("O:",quantnames),"O: mean","O: sd"),
                  #c("O: hm",paste("O:",quantnames_fine),"O: mean","O: sd"),
                  paste("O:",quantnames),
                  #paste("nO:",quantnames),
                  #paste("nHam:",quantnames),
                  paste("Ham:",quantnames),#[-1],
                  #paste("Ham:",quantnames_fine),
                  #paste0("S",1:14,"/S"),"S15+/S"
                  #paste("PHY:",quantnames),
                  #paste("Phy:",quantnames)[5],#[-(1:3)],
                  #paste("Phy:",quantnames_fine)[6:9],
                  #paste("r2:",quantnames),
                  #paste("r2:",quantnames_fine),
                  #c("nucl. div","S"),
                  #"Tajima's D","Fay & Wu's H",
                  paste0("S",1:14),"S15+"
                  #paste0("S",1:24)
                  #paste0("S",1:99)
                  #paste0("fS",1:50)
                  #c(paste0("fS",1:16),"fS17-50")
                  #paste("AF:",quantnames)#,
                  #"LD1"
                  #paste("AF:",quantnames_fine)
                  )

#pdf(paste0("pdfs/varimp_corr_",args[1],".pdf"))
pdf(paste0("pdfs/varimp_corr_",args[1],".pdf"),width=10,height=10)
par(oma=c(0,2.2,0,0))


tickpos <- NULL
tickcount <- 0
for (i in 1:length(varnames2)){
  tickpos <- c(tickpos,tickcount+1:length(varnames2[[i]]))
  tickcount <- max(tickpos+1)
}
yticks  <- tickpos
#yticks <- sort(36 - c(1:5,7:8,10:14,16:20,22:26,28:35))
names(yticks) <- varnames

plot(NULL,xlim = range(c(unlist(var_imps),unlist(var_imps2)),na.rm = TRUE),
     ylim=c(1,max(tickpos)),yaxt = "n",xlab="Variable importance (debiased)",
     ylab="",cex=let1)

axis(2,at= yticks,
     labels = unlist(varnames2),las=2)
for (i in varnames){
  lines(range(var_imps[[i]],na.rm = TRUE),rep(yticks[i],2),type="l")
  lines(range(var_imps2[[i]],na.rm = TRUE),rep(yticks[i],2)+0.1,type="l",col="gray")
  points(mean(var_imps[[i]],na.rm = TRUE),yticks[i],pch=8)
  points(mean(var_imps2[[i]],na.rm = TRUE),yticks[i]+0.1,pch=8,col="gray")
  
}
par(oma=c(0,0,0,0))
dev.off()

