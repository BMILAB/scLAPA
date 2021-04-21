#'Obtain clustering performance indicators
#'
#' @param group.ed Clustered labels
#' @param label True label
#'
#' @return a vector
#' @export
#'
#' @examples
index_index <- function(group.ed,label){

  purity.ed <- ClusterPurity(as.numeric(group.ed),lab2num(label))
  ARI.ed <- adjustedRand(as.numeric(group.ed), lab2num(label))
  NMI.ed <- as.numeric(compare(lab2num(label), as.numeric(group.ed), method="nmi"))
  result.ed <-c(purity.ed ,ARI.ed,NMI.ed)
  names(result.ed) <- c("purity",names(ARI.ed),"nmi")
  return(result.ed)
}

lab2num <- function(TureLabel) {

  labnum <- TureLabel
  for (i in 1:length(unique(as.character(TureLabel)))){
    labnum[which(labnum==unique(as.character(TureLabel))[i])] <- i

  }
  labnum <- as.numeric(labnum)
  return(labnum)
}
ClusterPurity <- function(clusters, classes) {

  sum(apply(table(classes, clusters), 2, max)) / length(clusters)
}





