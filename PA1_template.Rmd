---
output: html_document
---

## Coursera - Reproducible Research (repdata-006) 

### **Peer Assessment 1 **


### Loading and preprocessing the data:


```{r}
library(knitr)
library(markdown)
opts_chunk$set(echo = TRUE, fig.path="figures/", fig.align = "center")

df <- read.csv("/home/cesar/Coursera/A - Reproducible Research/activity.csv", header = TRUE)
```


### Calculating the mean of total number of steps taken per day:
 
```{r}
total_steps <- tapply(df$steps, df$date, sum, na.rm = TRUE)
```
 
* Making a histogram of the total number of steps taken each day

```{r}
hist(subset(total_steps, total_steps > 0), breaks = 20, col = "green", main = "Peer Assessment 1 - Histogram")
```


* Calculating and reporting the mean and median total number of steps taken per day

```{r}
mean(total_steps)

median(total_steps )
```


### Average daily activity pattern:

* Making a time series plot 

```{r}
interval <- tapply(df$steps, df$interval, mean, na.rm = TRUE)
list <- unique(df$interval)

plot(list, interval, type = "l")
```

* Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?

```{r}
interval <- data.frame(interval)
minutes <- interval[ interval == max(interval$interval), ]
minutes
```

### Imputing missing values:

* 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)
```{r}
NAs <- sum(is.na(df$steps))
NAs
```


* 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. 
```{r}
mean_steps <- mean(total_steps)
```


* 3. Create a new dataset that is equal to the original dataset but with the missing data filled in. 
```{r}

new_df <- df

for( i in 1:17568)
{
    if( is.na( new_df[ i, 1] ) == TRUE)
    {
        new_df[ i, 1] <- mean_steps
    }
}
```


* 4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?
```{r}
new_total_steps <- tapply(new_df$steps, new_df$date, sum )
# hist(subset(new_total_steps[ , 1]), breaks = 20, col = "blue", main = "New Histogram")
```
