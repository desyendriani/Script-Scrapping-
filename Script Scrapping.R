setwd("D:\\Semester 7\\SKRIPSI\\twitter")

install.packages("twitteR")
install.packages("ROAuth")
install.packages("RCurl")

library(twitteR)
library(ROAuth)
library(RCurl)



download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")


reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
CUSTOMER_KEY <- "nLl952QWh0KMywX0fSrC2m7H5" #consumerAPIkey
CUSTOMER_SECRET <- "ajzaWZX0PklgqJCZsahY0Fn437405SxPOUXzg1RvSCFPRR2i4q" #APISecretkey
ACCESS_TOKEN <- "1176774018113785857-WuXLymeEYQDSw37ePpwf4OyfM5QRYw"#Accesstoken
ACCESS_secret<- "r0NqsyLN4bGVgangMvVDBboYJH5nb3BmYMqpLSLV178Fk"#Accesstokensecret

setup_twitter_oauth(CUSTOMER_KEY, CUSTOMER_SECRET, ACCESS_TOKEN, ACCESS_secret)

#Mengambil data dari twitter

library(tidyverse)
library(twitteR)
tw<-searchTwitter("PPKM", n=5000,lang="id", since="2021-01-01",until="2021-11-30")
tw.df<-twListToDF(tw) 
head(tw.df$created)
tail(tw.df$created)
#Menyimpan Data Hasil Crawling
data.tw=data.frame(tw.df)
View(data.tw)
text=data.tw[1]
View(text)
lain=data.tw[2:16]
write.csv(text,file = "D:\\Semester 7\\SKRIPSI\\twitter\\PPKM c.csv")
write_excel_csv(text,file = "D:\\Semester 7\\SKRIPSI\\twitter\\PPKM.csv")


install.packages("textclean")
install.packages("katadasaR")
install.packages("tokenizers")
install.packages("wordcloud")
install.packages("dplyr")

library(textclean)
library(tokenizers)
library(wordcloud)
library(dplyr)

tweets=read.csv(file.choose(), header=TRUE)
tweets <- text
View(tweets)
tweets <- tweets$text %>% 
  as.character()
head(tweets)

tweets <- gsub( "\n"," ",tweets)
tweets[3]


tweets <- tweets %>% 
  replace_html() %>% # replace html with blank 
  replace_url()   # replace URLs with blank
tweets[3]


tweets <- tweets %>% 
  replace_emoji(.) %>% 
  replace_html(.)

tweets <- tweets %>% 
  replace_tag(tweets, pattern = "@([A-Za-z0-9_]+)",replacement="") %>%  # remove mentions
  replace_hash(tweets, pattern = "#([A-Za-z0-9_]+)",replacement="")      # remove hashtags

# print replaced text data on index [4:5]
tweets[4:5]



tweets<- gsub("RT :", "", tweets)
tweets[2]



spell.lex <-read.csv(file.choose(), header=TRUE)

# replace internet slang
tweets <- replace_internet_slang(tweets, slang = paste0("\\b",
                                                        spell.lex$slang, "\\b"),
                                 replacement = spell.lex$formal, ignore.case = TRUE)
tweets[1]



#Often it is useful to remove all non relevant symbols and case from a text 
tweets <- strip(tweets)
tweets[1]

#delete uniq
tweets <- tweets %>% 
  as.data.frame() %>% 
  distinct()
View(tweets)
nrow(tweets)

write.csv(tweets,file = "D:\\Semester 7\\SKRIPSI\\twitter\\PPKM cleaning.csv", row.names = FALSE)
write_excel_csv(tweets,file = "D:\\Semester 7\\SKRIPSI\\twitter\\PPKM cleaning.csv")


