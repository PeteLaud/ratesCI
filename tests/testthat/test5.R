library(ratesci)
context("Consistency")

#Exploring the extent of a problem with the non-iterative SCAS method when x=1 or 2
#(or n-1 or n-2)
#and level>0.99. Checking against iterative version shows it doesn't match under these
#conditions.
#Seems to be OK for level≤0.99

n <- 9333
xs <- 0:n
for (level in c(0.9, 0.95, 0.99, 0.999)) {

  test_that("noniterative scas matches iterative version", {
    expect_equal(
      round(scoreci(x1=xs, n1=n, contrast="p", level=level, precis=11)$estimates[, c(1:3)], 10),
      round(scaspci(x=xs, n=n, level=level)[, c(1:3)], 10)
    )
    expect_equal(
      round(scoreci(x1=xs, n1=n, contrast="p", cc=T, level=level, precis=11)$estimates[, c(1:3)], 10),
      round(scaspci(x=xs, n=n, cc=T, level=level)[, c(1:3)], 10)
    )
    expect_equal(
      round(scoreci(x1=xs, n1=n, contrast="p", level=level, distrib="poi", precis=11)$estimates[, c(1:3)], 10),
      round(scaspci(x=xs, n=n, level=level, distrib="poi")[, c(1:3)], 10)
    )
    expect_equal(
      round(scoreci(x1=xs, n1=n, contrast="p", cc=T, level=level, distrib="poi", precis=11)$estimates[, c(1:3)], 10),
      round(scaspci(x=xs, n=n, cc=T, level=level, distrib="poi")[, c(1:3)], 10)
    )
  })
}

