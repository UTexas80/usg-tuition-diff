# Preprocessing script.

# Remove worksheets programmatically.  Delete objects with "SQL" and "Sheet" in name
rm(list = ls()[grepl("(SQL|Sheet)", ls())])