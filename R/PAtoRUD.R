#'
#' Get RUD of PA
#'
#' @param data a PACdataset
#'
#' @return a matrix of RUD
#' @export
#'
#' @examples PAtoRUD(data)
PAtoRUD<-function(data){
  APAratio = movPAindex(APA, method='ratio')
  APARUD <- APAratio[rownames(filterPD(APA,type = -1)),]
  rownames(APARUD) <- gsub(":.*","",rownames(APARUD))
}


filterPD <- function(dt,type){

  #type: 1 - proximal
  #type: -1 - distal
  anplus <- dt@anno[dt@anno$strand == "+",]
  anplus$paid <- rownames(anplus)
  anplus <-  as.data.frame(anplus %>% group_by(gene) %>% top_n(-type,wt=coord))

  anminus <- dt@anno[dt@anno$strand == "-",]
  anminus$paid <- rownames(anminus)
  anminus <- as.data.frame(anminus %>% group_by(gene) %>% top_n(type,wt=coord))

  anno <- rbind(anplus,anminus)
  anno <- arrange(anno, chr,gene)
  rownames(anno) <- anno$paid
  return(anno)

}
