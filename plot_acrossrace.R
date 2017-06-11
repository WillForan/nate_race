library(dplyr)
library(magrittr)
library(ggplot2)
library(lubridate)

# quick function to remove inconsitant names
# always use a nickname
nickname <- function(n) {
 # fullname to nickname
 # or typo to not
 nicks<-list(
   c('^ \\+',''),
   c(' \\+$',''),
   c('patrick ','pat ')  ,
   c('bradley ','brad '),
   c('rosemary ','rose '),
   c('jonathan ','jon '),
   c('rose iacovino','rose foran'),
   c('kathrine ','katherine '),
   c('william ','will ') )

 # interively apply each replacemnt
 Reduce(function(r,x) gsub(x[1],x[2],r), nicks,init=n)
}

## read in data
# count number of years name is seen
d <-
 read.table('txt/year_person.txt',sep="\t",header=F) %>%
 `names<-`(c('year','name','time')) %>%
 mutate(name=nickname(name),
        time_s=period_to_seconds(hm(time)) ) %>%
 group_by(name) %>% 
 mutate(nraces=n()) 


#d %>% filter(nraces>13) %>% nrow()
peps <- c('foran','emily mente')
#          ,'argentine','rachel elder'
#          ,'steve fie','jon williams'
#          )
pepregex <- paste(peps,sep='|',collapse='|')

d.foran <- d %>% filter( grepl(pepregex,name,perl=T ))
p.foran <-
 ggplot(d.foran) + 
 aes(x=as.factor(year),y=time_s/(60^2),color=name,group=name) +
 geom_point() +
 theme_bw()
 #scale_y_continuous(limits=c(18,35))+

pf.line <- p.foran + geom_line()
pf.lm <- p.foran + geom_smooth(method='lm',se=F) 

print(pf.line)
ggsave('imgs/foran_family_year.png',pf.line,width=11,height=5)
ggsave('imgs/foran_family_year_lm.png',pf.lm,width=11,height=5)
