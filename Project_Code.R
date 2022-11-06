setwd("~/Desktop/DA 401/Project/Data")

total_hurricanes = read.csv("clean_all_hurricanes.csv")

#Filtering Latitude to fit inclusion criteria
library(dplyr)
library(ggplot2)

CARIB_data = total_hurricanes %>% filter(Latitude %in% (9.5:30.5))
CARIB_data = CARIB_data %>% filter(between(Longitude, -89, -57.4))
CARIB_data = CARIB_data %>% filter(Maximum.Wind %in% (64:160))

#Creating Decade Groups
CARIB_data$Decade = ifelse((CARIB_data$Year<= 2021) & (CARIB_data$Year>= 2012), "2012-2021",
                           ifelse((CARIB_data$Year<= 2011) & (CARIB_data$Year>= 2002), "2002-2011",
                           ifelse((CARIB_data$Year<= 2001) & (CARIB_data$Year>= 1992), "1992-2001", "Other")))

write.csv(CARIB_data, "caribbean_hurricanes.csv")

#Summary Statistics for total hurricanes and each decade in the data set
hurricanes1992 = CARIB_data[CARIB_data$Decade == "1992-2001",]
hurricanes2002 = CARIB_data[CARIB_data$Decade == "2002-2011",]
hurricanes2012 = CARIB_data[CARIB_data$Decade == "2012-2021",]
#Total data set
summary(CARIB_data$Minimum.Pressure)
summary(CARIB_data$Maximum.Wind)
summary(CARIB_data$Latitude)
summary(CARIB_data$Longitude)
#1992 - 2001
summary(hurricanes1992$Minimum.Pressure)
summary(hurricanes1992$Maximum.Wind)

#2002 - 2011
summary(hurricanes2002$Minimum.Pressure)
summary(hurricanes2002$Maximum.Wind)

#2002 - 2011
summary(hurricanes2012$Minimum.Pressure)
summary(hurricanes2012$Maximum.Wind)

#Looking at the correlation between minimum pressure and wind speed
library(grid)
textbox = grobTree(textGrob("Correlation = -0.8985", x=0.1,y=0.1,hjust = 0,
                            gp = gpar(col = "black", fontsize = "13", fontface = "bold")))

ggplot(CARIB_data, aes(x = Minimum.Pressure, y = Maximum.Wind))+
  geom_point()+
  geom_smooth(method = lm)+
  ggtitle("Minimum Pressure vs. Maximum Wind Speed")+
  xlab("Minimum Pressure (mb)")+
  ylab("Maximum Wind Speed (knots)")+
  theme(axis.line = element_line(colour = "black"),
        axis.text = element_text(size = 12, colour = "black", face = "bold"),
        axis.title = element_text(size = 13, colour = "black", face = "bold"),
        plot.title = element_text(size = 14, color = "black", face = "bold"))+
  scale_x_continuous(breaks = seq(880,1020, by = 20))+
  scale_y_continuous(breaks = seq(0,180, by = 20))+
  annotation_custom(textbox)

cor_df = na.omit(CARIB_data)
cor(cor_df$Maximum.Wind, cor_df$Minimum.Pressure)


#Creating a data set for the yearly hurricane counts 
CARIB_year_counts = aggregate(data = CARIB_data,
                            ID ~ Year,
                            function(ID) length(unique(ID)))
#Calculating the Exponentially weighted moving average
library(pracma)
CARIB_year_counts$EWM_3day = movavg(CARIB_year_counts$ID, n=3, type = "e")
CARIB_year_counts$EWM_2day = movavg(CARIB_year_counts$ID, n=2, type = "e")
CARIB_year_counts$EWM_4day = movavg(CARIB_year_counts$ID, n=4, type = "e")
CARIB_year_counts$EWM_6day = movavg(CARIB_year_counts$ID, n=6, type = "e")


write.csv(CARIB_year_counts, "hurricane_counts.csv")
# Graphing the Yearly Counts:
library(ggplot2)
colors = c("Yearly Count" = "navy", "Exponential 6-Year Moving Average" = "dark orange")

ggplot(CARIB_year_counts, aes(x = Year)) + #6-day exponential moving average
  geom_line(aes(y = ID, color = "Yearly Count"), size = 1.2) +
  geom_line(aes(y = EWM_6day, color = "Exponential 6-Year Moving Average"), size = 1.2) +
  labs(x = "Year",
       y = "Total Hurricanes",
       color = "Legend:") +
  scale_color_manual(values = colors)+
  scale_x_continuous(breaks = seq(1850,2021, by = 17))+
  scale_y_continuous(breaks = seq(1,20, by = 2))+
  ggtitle("Total Hurricanes in the Caribbean per Year")+
  theme(legend.position="bottom", 
        legend.box = "vertical",
        axis.line = element_line(colour = "black"),
        axis.text = element_text(size = 11, colour = "black", face = "bold"),
        axis.title = element_text(size = 13, colour = "black", face = "bold"),
        plot.title = element_text(size = 14, color = "black", face = "bold"),
        legend.text = element_text(size = 11))

# same plot as above but limiting the years to 1992 - 2021 
filtered_years = CARIB_year_counts %>% filter(Year %in% 1992:2021)
filtered_years$EWM_3day = movavg(filtered_years$ID, n=3, type = "e")
filtered_years$EWM_2day = movavg(filtered_years$ID, n=2, type = "e")
filtered_years$EWM_4day = movavg(filtered_years$ID, n=4, type = "e")
filtered_years$EWM_6day = movavg(filtered_years$ID, n=6, type = "e")

colors2 = c("Yearly Count" = "navy", "Exponential 4-Year Moving Average" = "dark orange")
ggplot(filtered_years, aes(x = Year)) + #4-day exponential moving average
  geom_line(aes(y = ID, color = "Yearly Count"), size = 1.2) +
  geom_line(aes(y = EWM_4day, color = "Exponential 4-Year Moving Average"), size = 1.2) +
  labs(x = "Year",
       y = "Total Hurricanes",
       color = "Legend:") +
  scale_color_manual(values = colors2)+
  scale_x_continuous(breaks = seq(1992,2021, by = 4))+
  scale_y_continuous(breaks = seq(1,20, by = 2))+
  ggtitle("Total Hurricanes in the Caribbean per Year")+
  theme(legend.position="bottom", 
        legend.box = "vertical",
        axis.line = element_line(colour = "black"),
        axis.text = element_text(size = 12, colour = "black", face = "bold"),
        axis.title = element_text(size = 13, colour = "black", face = "bold"),
        plot.title = element_text(size = 14, color = "black", face = "bold"),
        legend.text = element_text(size = 12))

#Creating Data sets to explore yearly average and maximum wind speed
filtered_years2 = CARIB_data %>% filter(Year %in% 1992:2021)
CARIB_year_wind_avg = aggregate(data = filtered_years2,
                                Maximum.Wind ~ Year,
                                function(Maximum.Wind) mean(Maximum.Wind))
CARIB_year_wind_max = aggregate(data = filtered_years2,
                                Maximum.Wind ~ Year,
                                function(Maximum.Wind) max(Maximum.Wind))
CARIB_year_winds = merge(CARIB_year_wind_max, CARIB_year_wind_avg, by = "Year")
names(CARIB_year_winds)[names(CARIB_year_winds) == "Maximum.Wind.x"] = "Maximum.Wind"
names(CARIB_year_winds)[names(CARIB_year_winds) == "Maximum.Wind.y"] = "Average.Wind"
write.csv(CARIB_year_winds, "yearly_winds.csv")

#Visualizing the Wind Speed data set created above
wind_colors = c("Max. Wind Speed" = "navy", "Avg. Maximum Wind Speed" = "dark orange")
ggplot(CARIB_year_winds, aes(x = Year)) + 
  geom_line(aes(y = Maximum.Wind, color = "Max. Wind Speed"), size = 1.2) +
  geom_line(aes(y = Average.Wind, color = "Avg. Maximum Wind Speed"), size = 1.2) +
  labs(x = "Year",
       y = "Wind Speed (kts)",
       color = "Legend:") +
  scale_color_manual(values = wind_colors)+
  scale_x_continuous(breaks = seq(1992,2021, by = 4))+
  ggtitle("Maximum Wind Speed Over-Time in the Caribbean")+
  theme(legend.position="bottom", 
        legend.box = "vertical",
        axis.line = element_line(colour = "black"),
        axis.text = element_text(size = 12, colour = "black", face = "bold"),
        axis.title = element_text(size = 13, colour = "black", face = "bold"),
        plot.title = element_text(size = 14, color = "black", face = "bold"),
        legend.text = element_text(size = 12))

#Creating Data sets to explore yearly average and minimum pressure
CARIB_year_pressure_avg = aggregate(data = filtered_years2,
                                Minimum.Pressure ~ Year,
                                function(Minimum.Pressure) mean(Minimum.Pressure))
CARIB_year_pressure_min = aggregate(data = filtered_years2,
                                Minimum.Pressure ~ Year,
                                function(Minimum.Pressure) min(Minimum.Pressure))
CARIB_year_pressures = merge(CARIB_year_pressure_min, CARIB_year_pressure_avg, by = "Year")
names(CARIB_year_pressures)[names(CARIB_year_pressures) == "Minimum.Pressure.x"] = "Minimum.Pressure"
names(CARIB_year_pressures)[names(CARIB_year_pressures) == "Minimum.Pressure.y"] = "Average.Pressure"
write.csv(CARIB_year_pressures, "yearly_pressures.csv")

#Visualizing the Pressure data created above
pressure_colors = c("Minimum Pressure" = "navy", "Avg. Minumum Pressure" = "dark orange")
ggplot(CARIB_year_pressures, aes(x = Year)) + 
  geom_line(aes(y = Minimum.Pressure, color = "Minimum Pressure"), size = 1.2) +
  geom_line(aes(y = Average.Pressure, color = "Avg. Minumum Pressure"), size = 1.2) +
  labs(x = "Year",
       y = "Pressure (mb)",
       color = "Legend:") +
  scale_color_manual(values = pressure_colors)+
  scale_x_continuous(breaks = seq(1992,2021, by = 4))+
  ggtitle("Minimum Pressure Over-Time in the Caribbean")+
  theme(legend.position="bottom", 
        legend.box = "vertical",
        axis.line = element_line(colour = "black"),
        axis.text = element_text(size = 12, colour = "black", face = "bold"),
        axis.title = element_text(size = 13, colour = "black", face = "bold"),
        plot.title = element_text(size = 14, color = "black", face = "bold"),
        legend.text = element_text(size = 12))

#One-way ANOVA test: 
View(CARIB_data)
CARIB_data1992 = CARIB_data %>% filter(Year %in% (1992:2021))

keeps = c("Maximum.Wind", "Minimum.Pressure", "Decade")
CARIB_data1992 = CARIB_data1992[keeps]
#Visualizing the Data
library(ggpubr)
ggboxplot(CARIB_data1992, x = "Decade", y = "Maximum.Wind",  #Wind Speed
          color = "Decade", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("1992-2001", "2002-2011", "2012-2021"),
          ylab = "Maximum Wind Speed", xlab = "Decade")+
          theme(legend.position="bottom", 
                legend.box = "vertical",
                axis.line = element_line(colour = "black"),
                axis.text = element_text(size = 12, colour = "black", face = "bold"),
                axis.title = element_text(size = 13, colour = "black", face = "bold"),
                plot.title = element_text(size = 13, color = "black", face = "bold"),
                legend.text = element_text(size = 12))+
          ggtitle("Variance of Maximum Wind Speed for Each Group")

ggboxplot(CARIB_data1992, x = "Decade", y = "Minimum.Pressure", #Minimum Pressure
          color = "Decade", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("1992-2001", "2002-2011", "2012-2021"),
          ylab = "Minimum Pressure", xlab = "Decade")+
          theme(legend.position="bottom", 
              legend.box = "vertical",
              axis.line = element_line(colour = "black"),
              axis.text = element_text(size = 12, colour = "black", face = "bold"),
              axis.title = element_text(size = 13, colour = "black", face = "bold"),
              plot.title = element_text(size = 13, color = "black", face = "bold"),
              legend.text = element_text(size = 12))+
          ggtitle("Variance of Minimum Pressure for Each Group")


#One-Way ANOVA for Maximum Wind Speed
Wind.aov = aov(Maximum.Wind ~ Decade, data = CARIB_data1992)
summary(Wind.aov)
TUKEY = TukeyHSD(Wind.aov)
TUKEY
#check normality
plot(Wind.aov,2)
#looking at differences 
plot(TUKEY, las = 1, col = "blue")

#One-Way ANOVA for Minimum Pressure
Pressure.aov = aov(Minimum.Pressure ~ Decade, data = CARIB_data1992)
summary(Pressure.aov)
TUKEY2 = TukeyHSD(Pressure.aov)
TUKEY2
#check normality
plot(Pressure.aov,2)
#looking at differences 
plot(TUKEY2, las = 2, col = "blue")




