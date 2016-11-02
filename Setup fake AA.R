library(tidyverse)

inflow = rnorm(100,500,40)
outflow = rnorm(100,400,30)
onflow = rnorm(100,0.05,0.001)
init = c(23370, 26852,34988,33975,30165,27804)
inflow = matrix(inflow[1:96],ncol=6)
outflow = matrix(outflow[1:96],ncol=6)
onflow = matrix(onflow[1:80],ncol=5)
onflow = cbind(rep(0),onflow,rep(0))

caseloads = data.frame(x65 = 1:17, x70 = 1:17, x75 = 1:17, x80 = 1:17, x85 = 1:17, x90 = 1:17)
caseloads[1,] = init
caseloads = data.frame(x0 = rep(0,17)) %>% bind_cols(caseloads) %>% bind_cols(data.frame(x1000 = rep(0,17)))

for(j in 1:6){
  for(i in 1:16){
    caseloads[i+1,j+1]=as.integer(caseloads[i,j+1]*(1-onflow[i,j+1])+inflow[i,j]-outflow[i,j]+caseloads[i,j]*onflow[i,j])
  }
}

df = caseloads %>%
  mutate(date=1:17) %>%
  gather(age_range, caseloads, -date) %>%
  filter(!(age_range %in% c("x0","x1000"))) %>%
  mutate(inflow = c(rbind(rep(0),inflow)), outflow = c(rbind(rep(0),outflow)), onflow_rate = c(rbind(rep(0),onflow[,2:7])))

