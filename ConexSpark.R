### Limpiar memoria temporal de Spark
unlink("C:/Users/german.galdamez/AppData/Local/spark/spark-2.4.3-bin-hadoop2.7/tmp/hadoop",  recursive=TRUE)  
unlink("C:/Users/german.galdamez/AppData/Local/spark/spark-2.4.3-bin-hadoop2.7/tmp/hive",  recursive=TRUE) 
unlink("C:/Users/german.galdamez/AppData/Local/spark/spark-2.4.3-bin-hadoop2.7/tmp/local",  recursive=TRUE) 


  ### Limpiar todas las variables ###
  rm(list = ls())
  #spark_disconnect(sc)
  ### Librerías y conexión a SPARK  ###
  # Librerías
  {
    library(sparklyr)
    library(dplyr)
    library(tidyverse)
    library(lubridate)
    library(stringr)
    library(knitr)
    library(openxlsx)
    library(scales) # Para poner comas y porcentajes
    library(DBI)
    library(rJava)
    library(RJDBC)
  }
  
  library(finnts)
  library(qs)
  
  # connect to spark cluster
  options(sparklyr.log.console = TRUE)
  options(sparklyr.spark_apply.serializer = "qs") # uses the qs package to improve data serialization before sending to spark cluster
  
  options(sparklyr.spark_apply.serializer = function(x) qs::qserialize(x, preset = "fast"))
  options(sparklyr.spark_apply.deserializer = function(x) qs::qdeserialize(x))
  
  
  # Conexión a Spark
  # spark_disconnect(sc)
  {
    # options(sparklyr.console.log = TRUE)
    Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_431")
    config <- spark_config()
    config[["sparklyr.jars.default"]] <- "C:/drivers/oracle/ojdbc8.jar"
    config$`sparklyr.shell.driver-memory` <- "12G"
    config$spark.memory.fraction <- 0.8
    sc<-spark_connect(master="local", config=config,version="2.4.3")
    #sc<-spark_connect(master="local", config=config)
    
  }
  
  # Función para leer desde la bd
  fun_inicio <- function(table){
    jdbcConnectionOpts <- list(
      user = "sisra",
      password = "Noteladigo",
      driver = "oracle.jdbc.driver.OracleDriver",
      fetchsize = "100000",
      dbtable = table,
      url = "jdbc:oracle:thin:@//desadges_bd.inegi.gob.mx:1521/desadges.inegi.gob.mx")
    db <- spark_read_jdbc(
      sc = sc,
      name = table,
      options = jdbcConnectionOpts,
      memory = TRUE)
  }
  