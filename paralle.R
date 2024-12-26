library(doParallel)
library(doSNOW)

core <- 3
cl <- makeCluster(core, outfile = "parllele.txt")
registerDoSNOW(cl)

numbers <- 1:10
pb <- txtProgressBar(min = 0, max = length(numbers), style = 3)
progress <- function(n){
  setTxtProgressBar(pb, n)
}
opts <- list(
  progress = progress
)

system.time(
  rlt <- foreach(i = 1:length(numbers), .combine = "+", .options.snow = opts) %dopar% {
    Sys.sleep(1)
    return(i/100)
  }
)

print(rlt)

close(pb)
stopCluster(cl)
getwd()
