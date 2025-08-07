data = read.csv("/Users/williarj/Desktop/2025_mut_recomb_correlation_sim/data/2025_08_07/combined_results.csv", header=T)

library(ggplot2)
pdf("quick_analysis.pdf")
ggplot(data, aes(x = factor(MU), y = pi_neutral)) +
  facet_grid(~ factor(RHO))+
  #geom_boxplot()+
  geom_jitter(width = 0.2, alpha = 0.7, color=factor(data$MU)) +
  theme_minimal()

dev.off()

boxplot(data$pi_neutral ~ data$MU + data$RHO)
stripchart(data$pi_neutral, method="jitter", pch=16, col=data$RHO)
