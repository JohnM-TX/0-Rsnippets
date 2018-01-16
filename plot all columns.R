# plot it
###### iterate for all names

library(ggplot2)
library(ggthemes)
library(ggExtra)
library(data.table)
library(gridExtra)
library(grid)


plotit1 <- cbind(embedding, storefactors)

setDF(plotit1)

plot_data_column = function (data, column){
    ggplot(data = plotit1, aes(tsneX, tsneY)) +
        geom_point(aes_string(color = column
                              #, shape = as.factor(plotit1$indicted)
                              #, size = as.factor(plotit1$indicted)
                              )) +
        scale_colour_gradient2(low="green2", mid="gray79", high="purple"
                               , midpoint = mean(plotit1[[column]]))+
       # scale_shape_manual(values = c(1, 17) , guide = FALSE)+
    #    scale_size_manual(values=c(3, 4) , guide = FALSE)+ 
        theme_minimal()+
        theme(axis.text.x = element_blank(), axis.text.y = element_blank())+
        labs(y = "", x = "")
}
myplots <- lapply(colnames(plotit1)[3:15], plot_data_column, data = plotit1)

grid.arrange(grobs = myplots)
