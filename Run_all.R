## =============================================================================
## run_all.R -- run the entire analysis pipeline in order.
##
##   Rscript run_all.R
##
## from the repository root (with the conda environment active).
##
## Each .Rmd is knitted to HTML in reports/. Order matters:
##   Setup.Rmd            defines paths, theme, palettes and all functions,
##                        and downloads the FigShare data
##   Data_processing.Rmd  builds LM_dtbl, the table every figure depends on
##   Fig1-5.Rmd           the figures
##
## IMPORTANT: all files are rendered into the GLOBAL environment
## (envir = globalenv()). rmarkdown::render() otherwise uses a fresh
## environment per call, so objects defined in Setup.Rmd (p, the palettes,
## scaling_fc, fit_cv_glm, ...) and LM_dtbl from Data_processing.Rmd would not
## be visible to the figure files, and every Fig*.Rmd would fail with
## "object not found".
## =============================================================================

rmd_files <- c(
  "01_Setup.Rmd",
  "02_Data_processing.Rmd",
  "03_Fig1.Rmd",
  "04_Fig2.Rmd",
  "05_Fig3.Rmd",
  "06_Fig4.Rmd",
  "07_Fig5.Rmd"
)

report_dir <- file.path("reports")
dir.create(report_dir, showWarnings = FALSE, recursive = TRUE)

## Fail early with a clear message rather than midway through a render.
missing <- rmd_files[!file.exists(rmd_files)]
if (length(missing)) {
  stop("Not found in ", getwd(), ": ", paste(missing, collapse = ", "),
       "\nRun this script from the repository root.", call. = FALSE)
}

timings <- data.frame(file = rmd_files, seconds = NA_real_)

for (i in seq_along(rmd_files)) {
  
  f <- rmd_files[i]
  message("\n", strrep("=", 70),
          "\n  [", i, "/", length(rmd_files), "] ", f,
          "\n", strrep("=", 70))
  
  t0 <- Sys.time()
  
  rmarkdown::render(
    input       = f,
    output_dir  = report_dir,
    envir       = globalenv(),   # see note above -- objects must persist
    quiet       = FALSE
  )
  
  timings$seconds[i] <- as.numeric(difftime(Sys.time(), t0, units = "secs"))
  message("--- done in ", round(timings$seconds[i]), "s")
}

message("\n", strrep("=", 70), "\n  Pipeline complete\n", strrep("=", 70))
print(timings)

## Record the environment that produced this run.
writeLines(capture.output(sessionInfo()),
           file.path(report_dir, "sessionInfo.txt"))

message("\nReports and sessionInfo.txt written to ", normalizePath(report_dir))
