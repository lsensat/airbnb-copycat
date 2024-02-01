require "down"
require "fileutils"

tempfile = Down.download("https://thispersondoesnotexist.com/")
FileUtils.mv(tempfile.path, "./#{tempfile.original_filename}")
