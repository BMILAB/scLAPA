#'
#' Use cell similarity matrix clustering to get cluster labels
#'
#' @param data a Matrix
#' @param c The number of evaluation clusters of the data
#' @param iter.max 	method="Kmeans":the maximum number of iterations allowed.
#' @param nstart method="Kmeans":if centers is a number, how many random sets should be chosen?
#' @param method should "louvain","SC","HC","Kmeans",Respectively represent louvian clustering, spectral clustering, hierarchical clustering, Kmeans clustering
#'
#' @return a Vector of cluster label
#' @export
#'
#' @examples Clustering(data,method = "louvain")
#' Clustering(data,c=7,method = "SC")
#' Clustering(data,c=7,method = "HC")
#' Clustering(data,c=7,method = "Kmeans",iter.max = 1e+9, nstart = 1000)
Clustering<-function(data,c=1,method="louvain",iter.max=1e+9,nstart=1000){
  return(if (method == "SC") {
    group.ed <- spectralClustering(data, c)
  } else if (method == "HC") {
    cellTree.ed <- flashClust(as.dist(data),method = "average")
   as.numeric(cutree(cellTree.ed,k=c))
  } else if (method=="Kmeans"){
    stats::kmeans(as.dist(data),c,
                  iter.max = iter.max, nstart = nstart)$cluster
  }else if  (method=="louvain"){
    correlationmatrix<-data
    rownames(correlationmatrix)<-c(1:nrow(correlationmatrix))
    distancematrix <- cor2dist(correlationmatrix)
    distancematrix[is.infinite(distancematrix)] = min(distancematrix, na.rm = T)
    distancematrix[is.na(distancematrix)]=median(distancematrix,na.rm = T)
    DM2<- as.matrix(distancematrix)
    DM2[correlationmatrix < 0.33] = 0
    G2 <- graph.adjacency(DM2, mode = "undirected", weighted = TRUE, diag = TRUE)
    clusterlouvain <- cluster_louvain(G2)
    clusterlouvain$membership
  }else {
    message("error")
  })

}
