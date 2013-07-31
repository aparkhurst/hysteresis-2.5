print.ellipsemake <-
function(g,...) {
print(g$values[c("area","lag","retention","coercion")])
invisible(g)}
