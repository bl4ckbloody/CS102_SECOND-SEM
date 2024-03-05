#A
warpbreaks

#1
num_int <- sapply(warpbreaks, function(x) is.numeric(x) | is.integer(x))
num_int

#2.
non_numcol <- sapply(warpbreaks, function(x) !is.numeric(x))
warpbreaks[non_numcol] <- lapply(warpbreaks[non_numcol], as.numeric)
str(warpbreaks)

#3.

#B
#1
example_file <- readLines("exampleFile.txt")
example_file
#2.
is_comment <- grepl("^//", data_lines)
comments <- data_lines[is_comment]
data <- data_lines[!is_comment]

cat("Comments:\n", comments, "\n\n")
cat("Data:\n", data, "\n")

#3.
date_line <- data_lines[grepl("^//", data_lines)][1]
date_pattern <- "Created : (\\d+ [a-zA-Z]+ \\d+)"
date_match <- regmatches(date_line, regexec(date_pattern, date_line))

if (length(date_match[[1]]) > 1) {
  extracted_date <- date_match[[1]][2]
  cat("Extracted Date:", extracted_date, "\n")
} else {
  cat("Date not found in the first comment line.\n")
}


#4a.
splitData <- strsplit(data, ";")

