#'@title add_qwi_labels
#'@description This function add labels to a `qwi` object
#'@param df an object with a class of `qwi`
#'
#'
#' @examples \donttest{
#'library(tidyqwi)
#'
#' # Add labels
#'labelled_nc <- add_qwi_labels(nc_qwi)
#'
#' # Check the label for the data
#'attr(labelled_nc[["Emp"]], "label")
#'
#'
#'}
#'
#'@export
#'

add_qwi_labels <- function(df){
  if(!"qwi" %in% class(df)){
    stop("A valid qwi object has not been passed to this function")
  }

  colnames(qwi_var_names)[7] <- "predicate_type"

  desired_labels <- qwi_var_names[match(names(df), qwi_var_names$name),]

  desired_labels<- desired_labels[!is.na(desired_labels[["label"]]),]

  desired_labels <- dplyr::select(desired_labels,
                                  "name", "label", "predicate_type")

  labeled_list <- stats::setNames(as.list(desired_labels$label),
                                  desired_labels$name)

  numeric_variables <-desired_labels[desired_labels[["predicate_type"]] == "int" &
                                       !is.na(desired_labels[["predicate_type"]]),]

  labelled::var_label(df) <- labeled_list

  out_data<- dplyr::mutate_at(df,
                              dplyr::vars(numeric_variables$name),
                              .funs = as.numeric)

  for(i in 1:nrow(numeric_variables)){

    position <- which(colnames(out_data)==numeric_variables$name[[i]])

    attr(out_data[[position]], "label") <- numeric_variables$label[[i]]
  }

  return(out_data)
}




