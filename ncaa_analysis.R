library(data.table)
library(ggplot2)

ncaa = fread("../Desktop/ncaa/ncaa_data.csv", sep= ',')

# R is silly and doesn't rename the data fields 
ncaa[, winning_seed := ifelse(score_1 > score_2, seed_1, seed_2)]
ncaa[, favorite := ifelse(seed_1 < seed_2, seed_1, seed_2)]
ncaa[, upset := ifelse(winning_seed != favorite, 1, 0)]

# let's only consider the most recent ten years of data
relevant = ncaa[Year >= 2009]

# how do the winning seed distributions change deeper into the tournament?
ggplot(relevant, aes(x=winning_seed, color=as.factor(Round)))+
  facet_wrap(~Round)+
  geom_bar()


# what is the distribution of national champs?
ggplot(relevant[Round == 6], aes(x=winning_seed, color=as.factor(Round)))+
  facet_wrap(~Round)+
  geom_bar()
