get_IUCN_synonyms <- function(species_list) {
  ############## 下载物种的IUCN异名 ###########
  ### species_list是物种名单向量 ###
  # 返回找到的物种IUCN异名 #
  
  library(rredlist)
  token <-
    "9914e1bd369f7a4dcd3a067cc9c086d3617c1feb0683adc83d182b3a47703dfc"
  rl_dl <- data.frame() # 定义空表储存API下载的数据
  notFound <- c() # 定义空向量储存notfound的物种名单
  species_list <- unique(species_list)
  print(length(species_list))
  while (!is.null(species_list)) {
    #循环，每一次都把timeout的种赋给species_list，直到species_list里面没有物种
    TimeOut <- c()
    for (i in species_list) {
      # 循环下载每个物种
      tryCatch({
        # 从redlist API下数据
        result <- rl_synonyms(name = i,key = token)
        if (length(result$result) == 0) {
          # 没找到的
          notFound <- append(notFound, i)
          print(paste(i, "NotFound"))
        } else{
          #找到的
          df <- data.frame(result)
          rl_dl <- rbind(rl_dl, df)
        }
      },
      error = function(e) {
        # 跳过Timeout的错误
        print(paste(i, "TimeOut"))
        TimeOut <<- append(TimeOut, i)
      })
#      Sys.sleep(2)
    }
    species_list <- TimeOut
    print(paste("完成一次while循环后剩余：", length(species_list)))
  }
  return(rl_dl)
}
