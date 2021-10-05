#' Counting number of atoms for each element in a substitution
#'
#' @param subst string with the name of a substitution
#'
#' @return counts of atoms of each element in the substitution
count_elements <- function(subst){
  tmp <- sapply(strsplit(subst, split = "\\[")[[1]][-1], 
                function(s) strsplit(s, split ="\\]")[[1]][2])
  tapply(as.numeric(gsub('[^0-9]+', '', tmp)), gsub('[0-9]+', '', tmp), sum)
}

#' Finding points defining a bound broken line
#'
#' @param points matrix with the points for which a bound is sought.
#' @param option string either equal to "lower" or "upper" depending on 
#' whether an upper bound or a lower bound is desired.  
#' @param p0 vector specifying the starting point of the algorithm.
#'
#' @return matrix with the points in `points` which define a bound broken line
bound_points <- function (points, option = "lower", p0 = c(0, 0)){
  bound_pts <- p0
  if(option == "lower") {
    FUN <- which.min
  } else if(option == "upper") {
    FUN <- which.max
  } else {
    stop("error")
  }
  while(nrow(points)){
    slopes = (points[, 2] - p0[2])/(points[, 1] - p0[1])
    p1 <- points[FUN(slopes), ]
    bound_pts <- rbind(bound_pts, p1)
    points <- points[which(points[, 1] > p1[1]), , drop = FALSE]
    p0 <- p1
  }
  rownames(bound_pts) <- NULL
  bound_pts
}

#' Finding better points defining bound broken line (especially needed for
#' the upper bound case) 
#'
#' @param points matrix with the points for which a bound is sought.
#' @param option string either equal to "lower" or "upper" depending on 
#' @param xsubd ordered vector of mass values representing a subdivision of the 
#' mass range that x-values of `points` span. The first point is the minimum of
#' the range, the last one its maximum.
#' @param p0 vector specifying the starting point of the algorithm.
#'
#' @return matrix with the points in `points` which define a bound broken line
bound_points2 <- function (points, option = "lower", xsubd, p0 = c(0, 0)){
  bound_pts <- p0
  k <- 2
  max_x <- max(points[, 1])
  if(option == "lower") {
    FUN <- which.min
  } else if(option == "upper") {
    FUN <- which.max
  } else {
    stop("error")
  }
  while(nrow(points)){
    while(k <= length(xsubd) && !length(idxs <- which(points[, 1] <= xsubd[k]))){
      k <- k + 1
    }
    points_tmp <- as.matrix(points[idxs, , drop = FALSE])
    slopes = (points_tmp[, 2] - p0[2])/(points_tmp[, 1] - p0[1])
    p1 <- points_tmp[FUN(slopes), ]
    bound_pts <- rbind(bound_pts, p1)
    points <- points[which(points[, 1] > p1[1]), , drop = FALSE]
    p0 <- p1
    if(p1[1] > xsubd[k - 1] && k != length(xsubd))
      k <- k + 1
  }
  rownames(bound_pts) <- NULL
  # remove negative slopes
  np <- nrow(bound_pts)
  keep <- rep(TRUE, np)
  if(option == "upper")
    seqi <- 1:(np - 1)
  else
    seqi <- np:2
  s <- seqi[2] - seqi[1]
  for (i in seqi){
    if(keep[i]){
      keep[which(s * bound_pts[, 1] > s * bound_pts[i, 1] & 
                   s * bound_pts[, 2] < s * bound_pts[i, 2])] <- FALSE
    }
  }
  bound_pts <- bound_pts[keep, ]
  # change last point if its x value is not equal to maximum x value of input 
  # points
  np <- nrow(bound_pts)
  if(bound_pts[np, 1] < max_x)
    bound_pts[np, ] <- c(max_x, diff(bound_pts[c(np - 1, np), 2]) /
                           diff(bound_pts[c(np - 1, np), 1]) *
                           (max_x - bound_pts[np, 1]) + bound_pts[np, 2])
  bound_pts
}

#' Get slope and intercept of the segments connecting a set of points 
#' (each one of them to the next one).
#'
#' @param pts matrix of points 
#'
#' @return matrix. The first column contains the intercepts of the lines, the 
#' second one contains their slopes. 
get_lines <- function(pts) {
  slope <- diff(pts[, 2])/diff(pts[, 1])
  intercept <- pts[-1, 2] - slope * pts[-1, 1]
  cbind(intercept, slope)
}

#' Creating a matrix with bounds defined on common intervals.
#'
#' @param pts1 points defining lower bound line
#' @param pts2 points defining upper bound line
#'
#' @return matrix. Each row contains two mass values defining an interval, the 
#' slopes and intercepts of the upper and lower bound line on that interval.
get_bounds <- function(pts1, pts2) {
  n1 <- nrow(pts1)
  n2 <- nrow(pts2)
  if(n1 < 2 || n2 < 2)
    stop("pts1 and pts2 must conatain at least two points each")
  x <- unique(sort(c(pts1[ ,1], pts2[ ,1])))
  n <- length(x)
  x_lo <- head(x, n -1)
  x_up <- tail(x, n -1)
  lines1 <- get_lines(pts1)
  lines2 <- get_lines(pts2)
  linesc <- matrix(NA, nrow = n - 1, ncol = 4)
  for(i in seq_len(n-1)) {
    idx <- which(pts1[1:(n1-1), 1] <= x[i] & pts1[2:n1, 1] > x[i])
    if(length(idx))
      linesc[i, 1:2] <- lines1[idx, ]
    idx <- which(pts2[1:(n2-1), 1] <= x[i] & pts2[2:n2, 1] > x[i])
    if(length(idx))
      linesc[i, 3:4] <- lines2[idx, ]  
  }
  res <- cbind(x_lo, x_up, linesc)
  colnames(res) <- c("leftend", "rightend", "LBint", "LBslope", "UBint", 
                     "UBslope")
  res
}