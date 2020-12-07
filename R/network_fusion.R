#'Similarity network fusion
#'
#' The single-cell similarity network is integrated into the single-cell-cell similarity network based on the nonlinear combination method.
#'
#'
#' @param data1 Cell similarity matrix
#' @param data2 Another cell similarity matrix for network fusion
#' @param K Number of neighbors in K-nearest neighbors part of the algorithm.
#' @param alpha Variance for local model.
#' @param T Number of iterations for the diffusion process
#'
#' @return A consensus similarity matrix
#' @export
#'
#' @examples
network_fusion<-function(data1,data2,K=20,alpha=0.5,T=10){
  w.1  <- SNFtool::affinityMatrix(data1, K, alpha)
  w.2  <- SNFtool::affinityMatrix(data2, K, alpha)
  w.pr <- SNFtool::SNF(list(w.1,w.2), K, T)
  w.pr<-Turn_distance(w.pr)
  return(w.pr)
}


Turn_distance <- function(W){

  normalize <- function(X) X/rowSums(X)
  diag(W) = median(as.vector(W))
  W = normalize(W)
  W = W + t(W)
  return(W)
}
