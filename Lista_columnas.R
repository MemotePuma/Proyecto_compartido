#Este es una prueba con github

BD<-c('ISSSTE_AX4_2015',
      'ISSSTE_AX4_2016',
      'ISSSTE_AX4_2017',
      'ISSSTE_AX4_2018',
      'ISSSTE_AX4_2019',
      'ISSSTE_AX4_2020_T1',
      'ISSSTE_AX4_2020_T2',
      'ISSSTE_AX4_2020_T3',
      'ISSSTE_AX4_2020_T4',
      'ISSSTE_AX4_2021_T1',
      'ISSSTE_AX4_2021_T2',
      'ISSSTE_AX4_2021_T3',
      'ISSSTE_AX4_2021_T4',
      'ISSSTE_AX4_2022_T1',
      'ISSSTE_AX4_2022_T2',
      'ISSSTE_AX4_2022_T3',
      'ISSSTE_AX4_2022_T4',
      'ISSSTE_AX4_2023_T1'
)

df_columna = data.frame()

library(plyr)


for(i in 1:length(BD)){
  
  db <- fun_inicio(BD[i])
  col<- data.frame(colnames(db))
  colnames(col)<-BD[i]
  df_columna<-plyr::rbind.fill(df_columna,col)
}



write.xlsx(data.frame(df_columna), file=paste("D:/DBAProy/ISSSTE","Columnas_AX4.xlsx",sep="/"), sheetName="COLUMNAS",col.names=TRUE, row.names=F




