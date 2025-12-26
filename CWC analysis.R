# STATISTICAL ANALYSIS OF GOAL CONCESSION IN FIFA CLUB WORLD CUP 2025 MATCHES USING 
#SURVIVAL ANALYSIS APPROACH

library(openxlsx)
library(dplyr)
library(survival)
library(ggsurvfit)
library(ggplot2)
library(survminer)

data <- read.xlsx("C:/Users/Desktop/CWC/CWC data.xlsx")
str(data)
summary(data)
table(data$Event)

# Summarize total goals conceded per team
team_concession_summary <- data %>%
  group_by(Team) %>%
  summarise(Total_Conceded = sum(`Number.of.event`, na.rm = TRUE)) %>%
  arrange(desc(Total_Conceded))

# Top 5 teams that conceded the most
top5_most <- head(team_concession_summary, 10)

# Top 5 teams that conceded the least
top5_least <- tail(team_concession_summary, 10)

# Combine both for side-by-side plot
combined_teams <- bind_rows(
  mutate(top5_most, Category = "Most Conceded"),
  mutate(top5_least, Category = "Least Conceded")
)

# Plot
ggplot(combined_teams, aes(x = reorder(Team, Total_Conceded), y = Total_Conceded, fill = Category)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ Category, scales = "free") +
  coord_flip() +
  labs(
    title = "Top 5 Teams: Most and Least Goals Conceded",
    x = "Team",
    y = "Total Goals Conceded"
  ) +
  theme_minimal()
## Goal concession by team strength
ggplot(data, aes(x = as.factor(Opponent.strength), y = Number.of.event)) +
  geom_boxplot(fill = "lightgreen") +
  labs(title = "Goals Conceded by Opponent Strength",
       x = "Opponent Strength",
       y = "Goals Conceded") +
  theme_minimal()

# Create survival object
surv_obj <- Surv(time = data$Time.to.concede, event = data$Event)

# Fit Kaplan-Meier survival curve
km_fit <- survfit(Surv(data$Time.to.concede, Event) ~ 1, data = data)

# Plot the survival curve
ggsurvplot(km_fit, 
           data = data,          
           conf.int = TRUE,
           xlab = "Minutes Played", 
           ylab = "Survival Probability (Not Yet Conceded)",
           title = "Kaplan-Meier Survival Curve for Goal Concession",
           surv.median.line = "hv")
# Fit the Cox Proportional Hazards Model
cox_model <- coxph(Surv(Time.to.concede, Event) ~ 
                     Opponent.strength +
                     Possession.of.opponent +
                     Errors.leading.to.shot +
                     Red.card.by.team +
                     Free.Kicks.Conceded +
                     Corner.kicks.conceded +
                     Gk.Saves +
                     Big.chances.of.opponents +
                     Interceptions,
                   data = data)


# Show summary
summary(cox_model)
# Test the proportional hazards assumption
ph_test <- cox.zph(cox_model)

# View test results
print(ph_test)

# Plot Schoenfeld residuals (to check visually)
plot(ph_test)
# Visual forest plot of hazard ratios
ggforest(cox_model, data = data)


