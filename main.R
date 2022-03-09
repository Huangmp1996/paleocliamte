# -*- coding: utf-8 -*-
# ---
# jupyter:
#   jupytext:
#     formats: ipynb,R:light
#     text_representation:
#       extension: .R
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.13.0
#   kernelspec:
#     display_name: R
#     language: R
#     name: ir
# ---

library(dplyr)
library(corrplot)
library(ggplot2)
library(DHARMa)


# # Functional diversity

# +
amphibian_FD <- read.csv("./amphibian/amphibian_result.csv")
amphibian_body_size_FD <- read.csv("amphibian/amphibian_body_size_result.csv")

reptile_FD <- read.csv("./reptile/result_reptile.csv")
names(reptile_FD)[names(reptile_FD) == 'i'] <- 'grid_id'
lizards_clutch_size_FD <- read.csv('./reptile/result_clutch_size_lizards.csv')
names(lizards_clutch_size_FD)[names(lizards_clutch_size_FD) == 'id'] <- 'grid_id'
lizards_mass_FD <- read.csv('./reptile/result_body_size_lizards.csv')

ave_FD <- read.csv("./Ave/FD_bird_total.csv")
bird_clutch_size_FD <- read.csv("./Ave/FD_bird_clutch_size.csv")
bird_diet_FD <- read.csv("./Ave/FD_bird_diet.csv")
bird_ForStrat_FD <- read.csv("./Ave/FD_bird_ForStrat.csv")
bird_mass_FD <- read.csv("./Ave/FD_bird_body_size.csv")

mammal_FD <- read.csv("./mammal//result_mammal.csv")
mammal_diet_FD <- read.csv("./mammal/result_det_mammal.csv")
mammal_mass_FD <- read.csv("./mammal/result_mass_mammal.csv")
mammal_reproduction_FD <- read.csv("./mammal/result_reproduction_mammal.csv")


# 给列名加上类群名，除了grid_id列
colnames(amphibian_FD) <- ifelse(colnames(amphibian_FD)!='grid_id',paste0('amphibian_',colnames(amphibian_FD)),'grid_id') 
colnames(amphibian_body_size_FD) <- ifelse(colnames(amphibian_body_size_FD)!='grid_id',paste0('amphibian_',colnames(amphibian_body_size_FD)),'grid_id') 

colnames(reptile_FD) <- ifelse(colnames(reptile_FD)!='grid_id',paste0('lizard_',colnames(reptile_FD)),'grid_id') 
colnames(lizards_clutch_size_FD) <- ifelse(colnames(lizards_clutch_size_FD)!='grid_id',paste0('lizard_',colnames(lizards_clutch_size_FD)),'grid_id') 
colnames(lizards_mass_FD) <- ifelse(colnames(lizards_mass_FD)!='grid_id',paste0('lizard_',colnames(lizards_mass_FD)),'grid_id') 

colnames(ave_FD) <- ifelse(colnames(ave_FD)!='grid_id',paste0('bird_',colnames(ave_FD)),'grid_id')
colnames(bird_clutch_size_FD) <- ifelse(colnames(bird_clutch_size_FD)!='grid_id',paste0('bird_',colnames(bird_clutch_size_FD)),'grid_id')
colnames(bird_diet_FD) <- ifelse(colnames(bird_diet_FD)!='grid_id',paste0('bird_',colnames(bird_diet_FD)),'grid_id')
colnames(bird_ForStrat_FD) <- ifelse(colnames(bird_ForStrat_FD)!='grid_id',paste0('bird_',colnames(bird_ForStrat_FD)),'grid_id')
colnames(bird_mass_FD) <- ifelse(colnames(bird_mass_FD)!='grid_id',paste0('bird_',colnames(bird_mass_FD)),'grid_id')

colnames(mammal_FD) <- ifelse(colnames(mammal_FD)!='grid_id',paste0('mammal_',colnames(mammal_FD)),'grid_id')
colnames(mammal_diet_FD) <- ifelse(colnames(mammal_diet_FD)!='grid_id',paste0('mammal_',colnames(mammal_diet_FD)),'grid_id')
colnames(mammal_mass_FD) <- ifelse(colnames(mammal_mass_FD)!='grid_id',paste0('mammal_',colnames(mammal_mass_FD)),'grid_id')
colnames(mammal_reproduction_FD) <- ifelse(colnames(mammal_reproduction_FD)!='grid_id',paste0('mammal_',colnames(mammal_reproduction_FD)),'grid_id')
# -

# # phylogenetic diversity

# transfer MPD,MNTD to NRI,NTI
amphibian_phylog <- read.csv("./amphibian_phylogenetic_diversity.csv") %>% 
                        select(grid_id,amphibian_ntaxa.x,amphibian_NRI,amphibian_NTI,amphibian_pd.obs,amphibian_pd.obs.z)
lizard_phylog <- read.csv("./lizard_phylogenetic_diversity.csv") %>% 
                    select(grid_id,lizard_ntaxa.x,lizard_NRI,lizard_NTI,lizard_pd.obs,lizard_pd.obs.z)
ave_phylog <- read.csv("./ave_phylogenetic_diversity.csv") %>% 
                    select(grid_id,ave_ntaxa.x,ave_NRI,ave_NTI,ave_pd.obs,ave_pd.obs.z)
mammal_phylog <- read.csv("./mammal_phylogenetic_diversity.csv") %>% 
                    select(grid_id,mammal_ntaxa.x,mammal_NRI,mammal_NTI,mammal_pd.obs,mammal_pd.obs.z)


# # environmental variables

env <- read.csv("./environment_variables.csv")

colnames(env)

total_table <- full_join(amphibian_FD,ave_FD,by = 'grid_id') %>% 
                full_join(mammal_FD,by = 'grid_id') %>%
                full_join(reptile_FD,by = 'grid_id')  %>% 
                full_join(amphibian_body_size_FD,by = 'grid_id') %>% 
                full_join(lizards_clutch_size_FD,by = 'grid_id') %>% 
                full_join(lizards_mass_FD,by = 'grid_id') %>% 
                full_join(bird_clutch_size_FD,by = 'grid_id') %>% 
                full_join(bird_diet_FD,by = 'grid_id') %>% 
                full_join(bird_ForStrat_FD,by = 'grid_id') %>% 
                full_join(bird_mass_FD,by = 'grid_id') %>% 
                full_join(mammal_diet_FD,by = 'grid_id') %>% 
                full_join(mammal_mass_FD,by = 'grid_id') %>% 
                full_join(mammal_reproduction_FD,by = 'grid_id') %>% 
                full_join(amphibian_phylog,by = 'grid_id') %>% 
                full_join(ave_phylog,by = 'grid_id') %>% 
                full_join(mammal_phylog,by = 'grid_id') %>% 
                full_join(lizard_phylog,by = 'grid_id') %>% 
                full_join(env,by = c('grid_id'='id'))

# # model analyze

res <- cor(select(total_table,contains(c('LGM','mid_Holocene','prec','tavg','pop','dem','Rdls'))),use = 'complete.obs')
options(repr.plot.width=13, repr.plot.height=8)
corrplot(res,method = "shade",shade.col = NA, tl.col ="black", tl.srt = 45, order = "alphabet",tl.cex = 1.5)

spamm_performing <- function(i){# Spatial regression in R part 1: spaMM vs glmmTMB: https://www.r-bloggers.com/2019/09/spatial-regression-in-r-part-1-spamm-vs-glmmtmb/
    tmp <- select(total_table, i, x, y, prec, tavg, LGM_tavg_velocity,dem_value) %>% na.omit() %>% scale() %>% as.data.frame()
    # fit a non-spatial model
    fml <- as.formula(paste(i,'prec + tavg + LGM_tavg_velocity + dem_value',sep = '~'))
    print(fml)
    m_non <- lm(fml, tmp)
    # # plot residuals
    # tmp$resid <- resid(m_non)
    # ggplot(tmp, aes(x = x, y = y, size = resid)) +
    #   geom_point(alpha=0.2) +
    #   scale_size_continuous(range = c(0.1,3))

    # formal test
    sims <- simulateResiduals(m_non)
    moran <- testSpatialAutocorrelation(sims, x = tmp$x, y = tmp$y, plot = FALSE) # # need to take into account space if p < 0.05
    print(i)
    print(moran)
    if (moran$p.value < 0.05){
        # fit the model
        spamm_fml <- as.formula(paste(i,'prec + tavg + LGM_tavg_velocity + dem_value + Matern(1 | x + y)',sep = '~'))
        m_spamm <- spaMM::fitme(spamm_fml, data = tmp, family = "gaussian") # this take a bit of time
        taxa <- strsplit(i,split = '_')[[1]][1]
        diversity_index <- paste(strsplit(i,split = '_')[[1]][-1],collapse="_")
        summary_table <- as.data.frame(summary(m_spamm)$beta_table) %>% mutate(item = row.names(.)) %>%
                            mutate(class = rep(taxa,nrow(.)), diversity_index = rep(diversity_index,nrow(.)))
        result <- list()
        result$m_spamm <- m_spamm
        result$summary_table <- summary_table
        return(result$summary_table)
    }
}

colnames(total_table)

y_variables <- c('amphibian_FD.FRic','amphibian_FD.FEve','amphibian_FD.FDiv',
                 'amphibian_FD_body_size.FRic','amphibian_FD_body_size.FEve','amphibian_FD_body_size.FDiv',
                 'lizard_FD.FRic','lizard_FD.FEve','lizard_FD.FDiv',
                 'lizard_clutch_size_mean','lizard_clutch_size_sd',
                 'lizard_FD_body_size.FRic','lizard_FD_body_size.FEve','lizard_FD_body_size.FDiv',
                 'bird_FD.FRic','bird_FD.FEve','bird_FD.FDiv',
                 'bird_clutch_size_grid_mean','bird_clutch_size_sd',
                 'bird_FD_body_size.FRic','bird_FD_body_size.FEve','bird_FD_body_size.FDiv',
                 'bird_FD_diet.FRic','bird_FD_diet.FEve','bird_FD_diet.FDiv',
                 'bird_FD_ForStrat.FRic','bird_FD_ForStrat.FEve','bird_FD_ForStrat.FDiv',
                 'mammal_FD.FRic','mammal_FD.FEve','mammal_FD.FDiv',
                 'mammal_FD_det.FRic','mammal_FD_det.FEve','mammal_FD_det.FDiv',
                 'mammal_FD_mass.FRic','mammal_FD_mass.FEve','mammal_FD_mass.FDiv',
                 'mammal_FD_reproduction.FRic','mammal_FD_reproduction.FEve','mammal_FD_reproduction.FDiv',
                 'amphibian_NRI','amphibian_NTI',
                 'ave_NRI','ave_NTI',
                 'mammal_NRI','mammal_NTI',
                 'lizard_NRI','lizard_NTI')

library(foreach)
library(doParallel)
print(paste0('CPUs_used:',length(y_variables)))
cl <- makeCluster(length(y_variables))
registerDoParallel(cl)
model_result_tmp <- foreach(
    i = y_variables,
    .combine = rbind,
    .export = c('total_table','spamm_performing'),
    .packages = c("spaMM","dplyr",'DHARMa')
) %dopar% spamm_performing(i)
stopCluster(cl)


# +
names(model_result_tmp)[names(model_result_tmp) == 't-value'] <- 't_value'
model_result <- mutate(model_result_tmp, sig = cut(model_result_tmp$t_value,
                                                   breaks = c(-Inf,-1.8,1.8,Inf),
                                                   labels = c('significant','not_significant','significant'))) %>% 
                    filter(item != '(Intercept)')

model_result$class[model_result$class=='ave'] <- 'bird'
model_result$diversity_index[model_result$diversity_index=='FD_det.FRic'] <- 'FD_diet.FRic'
model_result$diversity_index[model_result$diversity_index=='FD_det.FEve'] <- 'FD_diet.FEve'
model_result$diversity_index[model_result$diversity_index=='FD_det.FDiv'] <- 'FD_diet.FDiv'
model_result$diversity_index[model_result$diversity_index=='clutch_size_grid_mean'] <- 'clutch_size_mean'
model_result$diversity_index <- gsub('mass','body_size',model_result$diversity_index)
model_result$diversity_index <- gsub('FD\\.','',model_result$diversity_index)
model_result$diversity_index <- gsub('FD_','',model_result$diversity_index)
head(model_result)
# -

model_result <- read.csv('model_result.csv')
options(repr.plot.width=18, repr.plot.height=8)
model_result$diversity_index <- factor(model_result$diversity_index,
                                       levels = c('NRI','NTI','FRic','FEve','FDiv','body_size.FRic','body_size.FEve','body_size.FDiv',
                                                  'clutch_size_mean','clutch_size_sd','reproduction.FRic','reproduction.FEve','reproduction.FDiv',
                                                 'diet.FRic','diet.FEve','diet.FDiv','ForStrat.FRic','ForStrat.FEve','ForStrat.FDiv'))
model_result$item <- factor(model_result$item,
                            levels = c('LGM_tavg_velocity','prec', 'tavg','dem_value'))
ggplot(model_result,aes(x = item, y = Estimate, fill = sig)) + geom_point(shape=21,size = 4) + 
    scale_fill_manual(breaks = c("significant", "not_significant"),
                      values = c('red','gray')) + # fill
    geom_hline(yintercept = c(0), linetype="dotted")+
    facet_grid(class ~ diversity_index)+
    theme(strip.text = element_text(size = rel(1.1)), # 分面标签字号
         axis.title.x = element_text(size = 11),axis.title.y = element_text(size = 11),
         axis.text.x = element_text(size = 11,angle = 45),axis.text.y = element_text(size = 10))
# ggsave('model_result.pdf',height = 300,width = 780,units = 'mm')
# write.csv(model_result,'model_result.csv',row.names=F)

options(repr.plot.width=14, repr.plot.height=8)
model_result_total <- filter(model_result,diversity_index %in% c('NRI','NTI','FRic','FEve','FDiv'))
ggplot(model_result_total,aes(x = item, y = Estimate, fill = sig)) + geom_point(shape=21,size = 6) + 
    scale_fill_manual(breaks = c("significant", "not_significant"),
                      values = c('red','gray')) + # fill
    geom_hline(yintercept = c(0), linetype="dotted")+
    facet_grid(class ~ diversity_index)+
    theme_bw()+
    theme(strip.text = element_text(size = rel(2)), # 分面标签字号
         axis.title.x = element_text(size = 14),axis.title.y = element_text(size = 14),
         axis.text.x = element_text(size = 14,angle = 45),axis.text.y = element_text(size = 13))
ggsave('model_result_total.pdf',height = 300,width = 550,units = 'mm')


options(repr.plot.width=18, repr.plot.height=8)
model_result_sub <- filter(model_result,!(diversity_index %in% c('NRI','NTI','FRic','FEve','FDiv')))
ggplot(model_result_sub,aes(x = item, y = Estimate, fill = sig)) + geom_point(shape=21,size = 6) + 
    scale_fill_manual(breaks = c("significant", "not_significant"),
                      values = c('red','gray')) + # fill
    geom_hline(yintercept = c(0), linetype="dotted")+
    facet_grid(class ~ diversity_index)+
    theme(strip.text = element_text(size = rel(1.3)), # 分面标签字号
         axis.title.x = element_text(size = 14),axis.title.y = element_text(size = 14),
         axis.text.x = element_text(size = 13,angle = 45),axis.text.y = element_text(size = 13))
ggsave('model_result_sub.pdf',height = 300,width = 750,units = 'mm')

