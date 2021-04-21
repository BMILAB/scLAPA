#'Construct cell similarity matrix through expression matrix
#'
#' @param data A matrix, rows are genes and columns are cells
#' @param c Default 1,The number of clusters in the data can only be used for SIMLR
#' @param nrep integer for RAFSIL1 the number of times similarities are learned
#' @param method Construct cell similarity matrix through "pearson","euclidean","simlr","rafsil1","rafsil2","phi_s","rho_p"
#'
#' @return Cell similarity matrix
#' @export
#'
#' @examples calculate_distance(data,"pearson")
#' calculate_distance(data,"euclidean")
#' calculate_distance(data,"simlr",c=7)
#' calculate_distance(data,"rafsil1",nrep=50)
#' calculate_distance(data,"rafsil2")
#' calculate_distance(data,"phi_s")
#' calculate_distance(data,"phi_s")
calculate_distance<- function(data, method="pearson",c=1,nrep=50) {
  data[which(data<0)] <- 0
  return(if (method == "pearson") {
    as.matrix(1-cor(data, method = "pearson"))
  } else if (method == "euclidean") {
    as.matrix(dist(t(data)))
  } else if (method=="simlr"){
    simi <- SIMLR::SIMLR(X = data, c = c, cores.ratio = 0)
    si <- as.matrix(simi$S)
    as.matrix(1/(1+si))
  }else if  (method=="rafsil1"){
    res.r1 <-  RAFSIL(t(data),nrep = 50, method="RAFSIL1",gene_filter = FALSE)
    as.matrix(res.r1$D)
  }else if (method =="rafsil2"){
    res.r2 <-  RAFSIL(t(data),           method="RAFSIL2",gene_filter = FALSE)
    as.matrix(res.r2$D)
  }else if (method == "phi_s") {
    coexpr= 1.0 * propr::phis(data, select = colnames(data))@matrix
    coexpr[is.na(coexpr)] = median(coexpr, na.rm = T)
    # replace infinite values with the minimum (binomial)
    coexpr[is.infinite(coexpr)] = min(coexpr, na.rm = T)
    coexpr
  } else if (method == "rho_p") {
    coexpr = propr::perb(data, select = colnames(data))@matrix

    coexpr[is.na(coexpr)] = median(coexpr, na.rm = T)
    # replace infinite values with the minimum (binomial)
    coexpr[is.infinite(coexpr)] = min(coexpr, na.rm = T)

    # scale metrics to [-1, 1] range

    coexpr =- scales::rescale(coexpr, to = c(-1, 1))
    coexpr
  }else{
    message("error distance")
  })
}
