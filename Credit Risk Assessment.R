# Install packages
install.packages("tidyverse")
install.packages("tidymodels")
install.packages("gridExtra")
install.packages("Amelia")
install.packages("psych")
install.packages("vip")
install.packages("extrafont")
install.packages("caret")
install.packages("rsample")

#load libraries
library(tidyverse) # for data manipulation and visualization
library(tidymodels) # for creating linear and logistic regression models
library(gridExtra) # for arranging visualizations
library(Amelia) # for dealing with missing data
library(psych) # for data visualization & descriptive statistics
library(vip) # for visualizing variable importance in models
library(extrafont) # for extra font customization
library(caret) # for additional model analysis
library(rsample) # for creating data splits and resamples

#Import data

#duplicate the data for EDA
eda_data = Apex_Trust_Dataset

#assign all the categorical columb names to an object
cat_cols <- c('status',
              'duration',
              'credit_history',
              'purpose',
              'amount',
              'savings',
              'employment_duration',
              'installment_rate',
              'other_debtors',
              'present_residence',
              'property',
              'age',
              'other_installment_plans',
              'housing',
              'number_credits',
              'job',
              'people_liable',
              'telephone',
              'foreign_worker',
              'credit_risk')

# Convert columns to a factor variable
eda_data[,cat_cols] <- lapply(eda_data[,cat_cols],factor)

# Rename variable values to something more meaningful for EDA
eda_data = eda_data |> mutate(credit_risk = ifelse(credit_risk == 0, 'bad', 'good'))

# Transform 'status' column
eda_data$status = ifelse(eda_data$status == 1, 'no checking account', 
                         ifelse(eda_data$status == 2, '<0 USD',
                                ifelse(eda_data$status == 3, '0 USD >== & < 200 usd', '>200 USD')))

# Convert 'status' to a factor
eda_data$status = factor(eda_data$status, levels = c('no checking account','<0 USD',
                                                     '0 USD >== & < 200 usd','>200 USD'))

# Convert 'savings' to a factor
eda_data$savings = factor(eda_data$savings, levels = c('unknown/ no savings account', '<100 USD',
                                                       '100 >== & < 500 usd', '500>= & 1000 USD', '>=1000 USD'))

# Ensure 'credit_risk' is a factor
eda_data$credit_risk = as.factor(eda_data$credit_risk)


# Check the transformed data types
str(eda_data)


#explore the data
summary(eda_data)

#visualize EDA for categorical variables
#determine the response variable distribution
credit_risk_dist <- ggplot(eda_data,aes(x= credit_risk))+
  geom_bar(width = 0.25, fill= 'darkgreen') +
  theme_minimal()+
  labs(x = 'Credit Risk',
       y = 'Count',
       title = "Distribution of Response Variable")+
  theme(plot.title = element_text(size = 17, family = "sans", hjust = 0.5),
        plot.subtitle = element_text(size = 12, family = "sans", hjust = 0.5),
        plot.background = element_rect(fill ="#FFFFFF"))
credit_risk_dist

# visualizing distributions of individual variables by credit risk, using Histograms
df2 = Apex_Trust_Dataset |>
  mutate(credit_risk = as.factor(ifelse(credit_risk == 0, 'bad', 'good')))


#status
status <- ggplot(df2, aes(x = status)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
status

# duration
duration <- ggplot(df2, aes(duration)) +
  geom_histogram(breaks = seq(0, 80, by = 5), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
duration

# age
age <- ggplot(df2, aes(age)) +
  geom_histogram(breaks = seq(0, 80, by = 5), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
age

# credit history
credit_history <- ggplot(df2, aes(credit_history)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()

credit_history


# job
job <- ggplot(df2, aes(job)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
job


# number_credits
number_credits <- ggplot(df2, aes(job)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
number_credits

# other installment plans
other_installment_plans <- ggplot(df2, aes(other_installment_plans)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
other_installment_plans


# savings
savings <- ggplot(df2, aes(savings)) +
  geom_histogram(breaks = seq(0, 5, by = 1), 
                 col = "black", 
                 aes(fill = after_stat(count))) +
  facet_wrap(~credit_risk) +
  scale_fill_gradient("Count", low = "lightgreen", high = "darkgreen") +
  theme_minimal()
savings


# amount
amount <- ggplot(data =df2, aes(amount))+
  geom_histogram(breaks = seq(0,20000, by =1000),
                 col = "black",
                 aes(fill = after_stat(count)))+
  facet_wrap(~credit_risk)+
  scale_fill_gradient("COunt", low ="lightgreen", high="darkgreen")
theme_minimal()

amount



grid.arrange(status, duration,age, credit_history, job,number_credits,
             other_installment_plans, savings, amount, ncol=2)

#boxpplot for numerical variables
df_num = Apex_Trust_Dataset |> select(age, amount, duration)
df_num = cbind(df_num, eda_data$credit_risk)
colnames(df_num) = c('age', 'amount', 'duration', 'credit_risk')

bp1 <- ggplot(df_num, aes(age))+
  geom_boxplot(fill = "lightgreen", color = "black", alpha = 0.3, width = 0.5)+
  facet_wrap(~credit_risk) + coord_flip()+
  theme_minimal()

bp1 


bp2 <- ggplot(df_num, aes(duration))+
  geom_boxplot(fill = "lightgreen", color = "black", alpha = 0.3, width = 0.5)+
  facet_wrap(~credit_risk) + coord_flip()+
  theme_minimal()

bp2 


bp3 <- ggplot(df_num, aes(amount))+
  geom_boxplot(fill = "lightgreen", color = "black", alpha = 0.3, width = 0.5)+
  facet_wrap(~credit_risk) + coord_flip()+
  theme_minimal()

bp3 

grid.arrange(bp1,bp2,bp3)

## Checking for correlations within variables 
# duplicate the data and transform all factor variables to numeric
cor_data= Apex_Trust_Dataset |> mutate_if(is.factor, as.numeric)

#Correlation plot
corPlot(cor_data, alpha = 0.7)

# Had to close open graphics
graphics.off()


#Data Preprocessing
#missing values
missmap(Apex_Trust_Dataset)

# Model Development
# Set a seed for random number generation to ensure repeatability
set.seed(1234)

#randomly partition data into training(70%) and test (30%) sets
ind <- sample(2, nrow(Apex_Trust_Dataset), replace = TRUE, prob = c(0.7, 0.3))
train <- Apex_Trust_Dataset[ind == 1,]
test <- Apex_Trust_Dataset[ind == 2,]

#Logistic regression model
#fit a logistic regression model to predict the credit risk using all other variables
m1 <- glm(credit_risk~., data = train, family = 'binomial')

summary(m1)


# visualize the most important features using the 'vip' package

m1 %>%
  vip(num_features = 20,
      geom ="point",
      aesthetics = list(
        size = 2,
        color = "#3C6255"
      ))+
  theme_minimal(base_size = 18) +
  labs(title = "Logistic Regresson: Feature Importance")

#predictions on the training data
p1 <- predict(m1, train, type = 'response')
pred1 <- ifelse(p1 >0.5, 1, 0)

pred1

#predictions on the test data
p2 <- predict(m1, train, type = 'response')
pred2 <- ifelse(p2 >0.5, 1, 0)

pred2

# Calculate confusion matrix for training data
cmlg1 <-confusionMatrix(factor(pred1), factor(train$credit_risk), positive = '1')

#print
cmlg1



# Calculate confusion matrix for test data
cmlg2 <-confusionMatrix(factor(pred2), factor(test$credit_risk), positive = '1')

#print
cmlg2











































  







