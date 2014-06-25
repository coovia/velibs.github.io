# Exporte un heatmap en .png pour chaque station

library(ggplot2)
velibs = read.csv("data.csv")
stations = read.csv("stations.csv")
velibs$jour = factor(velibs$jour, ordered=TRUE, levels=c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))
for(i in 1:nrow(stations)) {
  s_numero <- stations[i,1]
  s_name <- stations[i,2]
  s_data <- subset(velibs, station_id == s_numero)
  print(paste('id', s_numero, 'nrow', nrow(s_data), '%', i/nrow(stations)))
  if (nrow(s_data)>0) {
  	image = ggplot(s_data, aes(x = jour, y = heure)) + geom_tile(aes(fill = velos)) + scale_fill_gradient(name="Nombre de vélibs", low="white", high="green") + ggtitle(paste("Occupation station",s_name))
  	ggsave(file=paste0(s_numero, ".png"), plot=image, width=15, height=8, dpi=75, path="png")
  }
}
