library(sf)
library(dplyr)
library(tmap)

api_key <- read.csv("data/api_key.csv")
public_bike_pumps_url <- paste("https://openstreetgs.stockholm.se/geoservice/api/",
api_key$key, "/wfs/?version=1.0.0&request=GetFeature&typeName=od_gis:Cykelpump_Punkt&outputFormat=SHAPE-ZIP", sep="")

download.file(public_bike_pumps_url,
              paste(getwd(), "/data/Cykelpump_Punkt.zip", sep = ""),
              quiet = TRUE, mode = "wb")
unzip(f, exdir = paste(getwd(), "/data", sep = ""))

cykelp <- st_read("data/Cykelpump_Punkt.shp", options = "ENCODING=WINDOWS-1252")

tmap_mode("view")
tm_shape(cykelp) + tm_symbols(col = "Ventiler", scale = 0.5, palette = "Spectral") + tm_text("Namn")

# st_write(cykelp, "cykelpump.shp", layer_options = "ENCODING=UTF-8", delete_layer = TRUE)
# write.table(cykelp %>% st_drop_geometry(), "cykelpump.csv", quote = F, row.names = F, dec = ",", na = "", sep = ";")