
library(ggplot2)
library(ggforce)
library(ggthemes)
library(ggExtra)
library(colorspace)
library(scales)

#print tsne ro file
png(filename="clusters.png",       # use this device for scalable, high-res graphics
    type="cairo",
    units = "in",
    width = 7.5,
    height = 6.5,
    pointsize = 10,
    res = 300)

ggplot(plotit1, aes(tsneX, tsneY))+
        geom_point(aes(color = as.factor(targcluster), shape = as.factor(partition), size = as.factor(targcluster)), alpha = 0.9)+
        scale_color_manual(values=c("gray68", "darkorange2")
                     , guide = FALSE)+
        scale_shape_manual(values = c(seq.int(49,57), 18)
                     , guide = FALSE)+
        scale_size_manual(values=c(4, 5)
                    , guide = FALSE)+
        theme_minimal()+

        theme(axis.text.x = element_blank(), axis.text.y = element_blank())+
        labs(y = "t-SNE 2", x = "t-SNE 1")

dev.off()


# plot all factors for exploration
for (i in 1:ncol(mtx1)) {
  gpp <- ggplot(vndr1, aes(x = peer_group, y = get(colnames(mtx1)[i]))) +
    geom_sina(aes(color = as.factor(area)))+
    scale_color_brewer(palette="Set1")+
    labs(y = colnames(mtx1)[i])
  print(gpp)
  }

# show ggplot2 shapes
df_shapes <- data.frame(shape = 0:24)
ggplot(df_shapes, aes(0, 0, shape = shape)) +
  geom_point(aes(shape = shape), size = 5, fill = 'red') +
  scale_shape_identity() +
  facet_wrap(~shape) +
  theme_void()


# use plotly 
library(plotly)

myset <- palette(rainbow(m$G))

hovers = paste(vndr1$vendor, vndr1$vndr_name, vndr1$peer_group, plotit1$tsneX, plotit1$tsneY, sep = " - ")
p <- plot_ly(plotit1, x = ~tsneX, y = ~tsneY
             , type = "scatter"
             , mode = "markers"
             , color = ~as.factor(indicted)
             , colors = "Set1"
             , symbol = ~as.factor(indicted)
             , symbols = c('circle', 'x')
             , size = ~indicted
             , sizes = c(6, 11) #, 11, 11)
             , opacity = 0.4
             , showlegend = TRUE
             , hoverinfo = "text", text = hovers
             , showlegend = FALSE
) %>%

  layout(title = ""
         , xaxis = list(zeroline = TRUE
                        , title = ""
                        , showticklabels = FALSE
                        , dtick = 10)
         , yaxis = list(title = ""
                        , zeroline = TRUE
                        , showticklabels = FALSE
                        , dtick = 10)
  ) %>%

  add_markers( showlegend = FALSE)

p





