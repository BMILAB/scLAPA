#'
#' Convert PA expression matrix to gene expression matrix
#'
#' @param data a PACdataset
#'
#' @return Gene expression matrix
#' @export
#'
#' @examples PAtoRUD(data)
PAtoGE<-function(data){
  unique_gene <- as.matrix(unique(data@anno[["gene"]]))
  PA.matrix <- as.data.frame(matrix(0,length(unique_gene),dim(data@counts)[[2]]))
  colnames(PA.matrix) <- data@colData[["barcode"]]
  rownames(PA.matrix) <- unique_gene

  PA.matrix <- as.data.frame(t(apply(unique_gene,1,function(gene,all_PA){
    #browser()
    PA.matrix[gene,] <- colSums(data@counts[which(gene == all_PA),])},
    all_PA = data@anno[["gene"]])))
  #PA.matrix <- as.data.frame(t(PA.matrix))
  rownames(PA.matrix) <- unique_gene
  return(PA.matrix)
}


