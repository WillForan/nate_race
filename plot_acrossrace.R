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
   c('^patrick ','pat ')  ,
   c('^bradley ','brad '),
   c('^rosemary ','rose '),
   c('^jonathan ','jon '),
   c('^joseph ','joe '),
   c('^rose iacovino','rose foran'),
   c('^kathrine ','katherine '),
   c('^nathan ','nate '),
   c('william ','will ') )

 # interively apply each replacemnt
 Reduce(function(r,x) gsub(x[1],x[2],r), nicks,init=n)
}

## read in data
# count number of years name is seen
d <-
 read.table('txt/year_person.txt',sep="\t",header=F) %>%
 `names<-`(c('year','fullname','time')) %>%
 mutate(name=nickname(fullname),
        time_s=period_to_seconds(hm(time)) ) %>%
 group_by(name) %>% 
 mutate(nraces=n()) 

# by years run
#d %>% filter(nraces>13) %>% nrow()


filterpeps <- function(d,peps) {
 pepregex <- paste(peps,sep='|',collapse='|')
 d %>% filter( grepl(pepregex,name,perl=T ))
}

plot_race <- function(d) {
 ggplot(d) + 
 aes(x=as.factor(year),
     y=time_s/(60^2),
     color=name,
     group=name) +
 geom_point() +
 theme_bw()
 #scale_y_continuous(limits=c(18,35))+
}
save_img <-function(f,p) ggsave(path.expand(c('imgs',f)),p,width=11,height=5)


## 
p.foran <- d %>% filterpeps(c('foran','rachel elder','emily mente')) %>% plot_race
pf.line <- p.foran + geom_line()
pf.lm <- p.foran + geom_smooth(method='lm',se=F) 

save_img('foran_family_year.png',pf.line)
save_img('foran_family_year_lm.png',pf.lm)

## 

willcohort <- c('will foran','brad argentine','jon williams','brad frink','joe kopnitsky', 'kayla curtis','aaron walker','rob argentine')
p.willcohort <- d %>% filterpeps(willcohort) %>% plot_race
print( p.willcohort + geom_line()  )
print( p.willcohort + geom_smooth(method='lm',se=F)  )



