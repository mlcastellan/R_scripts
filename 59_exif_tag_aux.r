grep("^[aA].*", vector, value=TRUE)

ordered_names=as.vector(sort(names(EXIF_data)))

ordered_names=ordered_names[grep("^[G].*",ordered_names, value=TRUE)]

gps_tags=ordered_names[grep("^G", ordered_names)]


gps_tags_df=read_exif(img_list, tags=gps_tags)


writeLines(gps_tags,con="gps_tags_name.txt")
