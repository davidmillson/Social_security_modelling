library(MASS)

create_system_matrix = function(rates1,rates2){
  n1 = length(rates1)
  n2 = length(rates2)
  N = n1*n2
  y1 = c(rep(1,n1),rep(0,N))
  y2a = c(rep(1,n2), rep(0,(N-n2)))
  ind2 = rep(1:(n1-1)/10,n2) + rep(1:n2, each = n1-1)
  y2b = y2a[order(c(1:n2,ind2))]
  y3 = c(rates1,rep(0,N))
  y4a = c(rates2, rep(0,(N-n2)))
  ind4 = rep(1:(n1-1)/10,n2) + rep(1:n2, each = n1-1)
  y4b = y4a[order(c(1:(n2),ind4))]
  z1 = rep(y1,n2)[1:(n2*N)]
  z2 = rep(c(y2b,0),n1)[1:(n1*N)]
  z3 = rep(y3,n2)[1:(n2*N)]
  z4 = rep(c(y4b,0),n1)[1:(n1*N)]
  A = matrix(c(z1,z2,z3,z4), ncol = N, byrow = TRUE)[,1:(N-1)]
  
  return(A)
}

solve_equation = function(A,b){
  Ag = ginv(A)
  xb = Ag%*%b
  Aw = diag(nrow = nrow(Ag)) - Ag%*%A
  
  return(list(xb,Aw))
}