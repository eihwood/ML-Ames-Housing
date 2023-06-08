library(tidyverse)
library(ggplot2)
setwd("~/Documents/nycdsa/projects/machine-learning/")

price = read_csv('./Ames_HousePrice.csv')

t = read_csv('./Ames Real Estate Data.csv')


# Numeric columns
numeric_data = select_if(price, is.numeric)
numeric_features = numeric_data %>% select(-c(SalePrice, `...1`, `PID`))

pairs(numeric_features[,1:10])

names = colnames(numeric_features)
p = numeric_data$SalePrice / numeric_data$GrLivArea
p = log(numeric_data$SalePrice)

for (i in 1:length(names)){
  feature = pull(numeric_features, names[i])
  g = ggplot(mapping = aes(x = feature, y = p)) +
    geom_point() +
    theme_bw() +
    xlab(names[i]) +
    ylab('Log Housing Price')
 
 print(g)
 ggsave(filename = paste0("./Ellie/figs/LogPrice_by_", names[i], ".png"), plot = g,dpi = 300)
}
# GrLivArea - looks linear
plot(price$SalePrice/1000, price$GrLivArea)

# Definitely important
plot(price$SalePrice, price$OverallQual)

plot(price$SalePrice, price$OverallCond)


plot(log(price$SalePrice), log(price$YearRemodAdd))

# MAKE FUNCTION FOR BOXPLOTS 
cat_variables = select_if(price, is.character)
names = colnames(cat_variables)


for (i in 1:length(names)){
  feature = pull(cat_variables, names[i])
  g <- ggplot(mapping = aes(x = reorder(feature,p), 
                            y = p)) +
    geom_boxplot() + 
    theme_bw() + 
    geom_hline(yintercept = mean(p), color = 'forestgreen') +
    theme(axis.text.x = element_text(angle = 90)) + 
    ylab("Log Sale Price") +
    xlab(names[i])
  
  ggsave(filename = paste0("./Ellie/figs/Boxplot_LogPrice_vs_",names[i],".png"),plot=g,dpi = 300)
  
  print(g)
}



# PLOT Neighborhood
g <- ggplot(data = price, 
            mapping = aes(x = reorder(Neighborhood,price$SalePrice/price$GrLivArea), 
                                        y = price$SalePrice/price$GrLivArea)) +
  geom_boxplot() + 
  theme_bw() + 
  geom_hline(yintercept = mean(price$SalePrice/price$GrLivArea), color = 'forestgreen') +
  theme(axis.text.x = element_text(angle = 90)) + 
  ylab("Sale Price Per Above Ground Living Area") +
  xlab("Neighborhoods in Ames, Iowa")
g    

ggsave(filename = "./Ellie/figs/Boxplot_PricePerGrLivArea_vs_Neighborhood.png",dpi = 300)


# PLOT Zoning
g <- ggplot(data = price, 
            mapping = aes(x = reorder(MSZoning,price$SalePrice/price$GrLivArea), 
                          y = price$SalePrice/price$GrLivArea)) +
  geom_boxplot() + 
  theme_bw() + 
  geom_hline(yintercept = mean(price$SalePrice/price$GrLivArea), color = 'forestgreen') +
  theme(axis.text.x = element_text(angle = 90)) + 
  ylab("Sale Price Per Above Ground Living Area") +
  xlab("MS Zones in Ames, Iowa")
g    

ggsave(filename = "./figs/Boxplot_PricePerGrLivArea_vs_MSZoning.png",dpi = 300)
