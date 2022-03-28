library(dplyr) 
library(readr)
library(tidyr)
library(ggplot2)
library(plotly)
library(tidyverse)
library('Cairo')
CairoWin()

driver <- read_csv('./dataset/drivers.csv')
d_standing <- read_csv('./dataset/driver_standings.csv')
c_standing <- read_csv('./dataset/constructor_standings.csv')
constructor <- read_csv('./dataset/constructors.csv')
races <- read_csv('./dataset/races.csv')
result <- read_csv('./dataset/results.csv')
budget <- read_csv('./dataset/budget.csv')
bahrain2022 <- read_csv('./dataset/bahraingp2022.csv')
saudi2022 <- read_csv('./dataset/saudigp2022.csv')

#Pada script ini, saya mengambil data dari tahun 2014, dimana saat itu Lewis
#Hamilton sudah berada di tim Mercedes AMG Petronas dan terus berada di klasemen
#dengan posisi nomor 1 di setiap akhir musim (kecuali tahun 2016 dan 2021)

#Load data tabular terkait f1 mulai dari tahun 2014 (saat berganti regulasi) sampai 2021
#Mengecek ID race terakhir setiap tahun

#2010
s10 <- races %>% filter(year == 2010)
s10 <- s10 %>% filter(date == max(date))
stats <- rbind(s10)

#2011
s11 <- races %>% filter(year == 2011)
s11 <- s11 %>% filter(date == max(date))
stats <- rbind(stats,s11)

#2012
s12 <- races %>% filter(year == 2012)
s12 <- s12 %>% filter(date == max(date))
stats <- rbind(stats,s12)

#2013
s13 <- races %>% filter(year == 2013)
s13 <- s13 %>% filter(date == max(date))
stats <- rbind(stats,s13)

#2014
s14 <- races %>% filter(year == 2014)
s14 <- s14 %>% filter(date == max(date))
stats <- rbind(stats,s14) #raceId terakhir di tahun 2014= 918

#2015
s15 <- races %>% filter(year == 2015)
s15 <- s15 %>% filter(date == max(date))
stats <- rbind(stats, s15) #raceId terakhir di tahun 2015 = 945

#2016
s16 <- races %>% filter(year == 2016)
s16 <- s16 %>% filter(date == max(date))
stats <- rbind(stats, s16) #raceId terakhir di tahun 2015 = 968

#2017
s17 <- races %>% filter(year == 2017)
s17 <- s17 %>% filter(date == max(date))
stats <- rbind(stats, s17) #raceId terakhir di tahun 2017 = 988

#2018
s18 <- races %>% filter(year == 2018)
s18 <- s18 %>% filter(date == max(date))
stats <- rbind(stats, s18) #raceId terakhir di tahun 2018 = 1009

#2019
s19 <- races %>% filter(year == 2019)
s19 <- s19 %>% filter(date == max(date))
stats <- rbind(stats, s19) #raceId terakhir di tahun 2019 = 1030

#2020
s20 <- races %>% filter(year == 2020)
s20 <- s20 %>% filter(date == max(date))
stats <- rbind(stats, s20) #raceId terakhir di tahun 2020 = 1047

#2021
s21 <- races %>% filter(year == 2021)
s21 <- s21 %>% filter(date == max(date))
stats <- rbind(stats, s21) #raceId terakhir di tahun 2021 = 1073

#Tabel stats kini terdiri dari 12 data dari 12 season (2010-2021) formula satu dimana tahun
#Tersebut merupakan tahun pertama mercedes masuk ke F1
#Daftar pembalap dari tim rival yang dalam hal ini saya mengambil ferrari dan juga
#Red BUll Racing karena mereka bertiga selalu bersaing untuk menjadi nomor 1. Dan juga 
#rekan hamilton sesama Mercedes. Beberapa anggota Red Bull Racing seperti Pierre Gasly, 
#Daniel Kvyat dan Alex Albon tidak dimasukan karena mereka sering berganti-ganti
#tim ke tim saudaranya yaitu Alpha Tauri/Toro Rosso yang kurang kompetitif dan kurang cocok
#dianggap sebagai rival Mercedes.
#0. Lewis Hamilton
#1. Sebastian Vettel
#2. Kimi Raikkonen
#3. Nico Rosberg
#4. Daniel Ricciardo
#5. Max Verstappen
#6. Charles Leclerc
#7. Sergio Perez
#8. Carlos Sainz
#9. Valterri Bottas
#10. Fernando Alonso

tmp <- driver %>%  filter(forename == "Lewis", surname == "Hamilton")
driver_analys <- rbind(tmp)
tmp <- driver %>%  filter(forename == "Sebastian", surname == "Vettel")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Kimi", surname == "Räikkönen")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Nico", surname == "Rosberg")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Daniel", surname == "Ricciardo")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Max", surname == "Verstappen")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Charles", surname == "Leclerc")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Sergio", surname == "Pérez")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Carlos", surname == "Sainz")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Valtteri", surname == "Bottas")
driver_analys <- rbind(driver_analys,tmp)
tmp <- driver %>%  filter(forename == "Fernando", surname == "Alonso")
driver_analys <- rbind(driver_analys,tmp)

##############################################################################
##                             GRAFIK DARI DRIVER                           ##
##############################################################################
#Melakukan filter untuk melihat data hasil balap terakhir dari title contender
#beserta rivalnya
resultCAP <- merge(result, driver, by="driverId", all.x = TRUE) %>% 
             filter(driverId %in% driver_analys$driverId) %>%
             filter(raceId %in% stats$raceId)

#Memasukan tahun/season
tahun <- races%>%select(raceId,year)%>%filter(year %in% stats$year)
resultCAP <- merge(resultCAP, tahun, by="raceId", all.x = TRUE)

#Mengurutkan berdasarkan id balapan dan posisi finish
resultCAP <- resultCAP%>%arrange(raceId, positionOrder)

#Menghapus beberapa item yang diperlukan
resultCAP <- resultCAP%>% select(-positionText,-points,-laps,-milliseconds,-fastestLapTime,
                                 -fastestLap,-rank,-fastestLapSpeed,-statusId,-driverRef,-number.y,
                                 -dob,-url,-code)

#Menambahkan total point dari driver standing
resultCAP <- merge(resultCAP, d_standing, c("raceId","driverId"), all.x = TRUE)
#Menambahkan nama tim 
tim <- constructor%>%select(constructorId,name) %>%
      filter(constructorId %in% resultCAP$constructorId)
resultCAP <- merge(resultCAP, tim, by="constructorId", all.x = TRUE)
#Mengurutkan berdasarkan id balapan dan posisi finish
resultCAP <- resultCAP%>%arrange(raceId, positionOrder)

#MEMPERBAIKI NAMA KOLOM
#Menggabungkan nama depan dan belakang
resultCAP$fullName <- paste(resultCAP$forename,resultCAP$surname)
resultCAP <- resultCAP%>%arrange(raceId, positionOrder)

#Rename kolom
resultCAP <- rename(resultCAP, Driver_Number = number.x)
resultCAP <- rename(resultCAP, Finish = position.x)
resultCAP <- rename(resultCAP, Time = time)
resultCAP <- rename(resultCAP, Year = year)
resultCAP <- rename(resultCAP, Points = points)
resultCAP <- rename(resultCAP, Classement = position.y)
resultCAP <- rename(resultCAP, Nationality = nationality)
resultCAP <- rename(resultCAP, Total_Wins = wins)
resultCAP <- rename(resultCAP, Constructor = name)
resultCAP <- rename(resultCAP, Full_Name = fullName)
#Mengurutkan kembali semisal ada yang berubah
resultCAP <- resultCAP%>%arrange(raceId, positionOrder)

#Menambil data yang diperlukan saja
resultCAP <- resultCAP %>% select(Year, Classement, Full_Name, Nationality, Driver_Number, Constructor, Finish, Time,
                                  Points, Total_Wins)

driver_graph <- ggplot(resultCAP, aes(x=Year, y=Points, color=Full_Name),size=1,se=FALSE) + 
  geom_line() + geom_point() + theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=7),
                                     axis.text.y = element_text(vjust = 0.5,size=7),
                                     text=element_text(size=10),
                                     legend.text = element_text(colour="black", size=10, 
                                                                face="bold"),
                                     legend.key = element_rect(colour = "transparent", fill = "white"),
                                     legend.key.size = unit(0.5, "cm")) +
  scale_color_manual(name = "Full_Name",
                     values = c("Lewis Hamilton" = "deepskyblue1",
                                "Sebastian Vettel" = "chocolate4",
                                "Kimi Räikkönen" ="indianred4",
                                "Nico Rosberg" = "steelblue4",
                                "Daniel Ricciardo" = "yellow",
                                "Max Verstappen" = "navyblue",
                                "Charles Leclerc" = "red",
                                "Sergio Pérez" = "blue",
                                "Carlos Sainz" = "firebrick1",
                                "Fernando Alonso" = "darkorange",
                                "Valtteri Bottas" = "cyan1")) +
  scale_x_continuous(breaks=seq(2010, 2021, 1))
ggplotly(driver_graph)
ggsave("contendernrival_plot.png",width = 1828,dpi = 200, type = 'cairo', height = 700, units = "px")

##############################################################################
##                          GRAFIK DARI CONSTRUCTOR                         ##
##############################################################################

#Tim yang merupakan rival mercedes dari 2014 adalah Ferrari,Red Bull dan McLaren.
#McLaren dimasukan karena awal tahun 2010-an tim tersebut sangat kompetitif apalagi
#Pembalapnya adalah Lewis Hamilton
#Maka keempat tim difilter dan dimasukan ke dalam dataframe baru
tmp <- constructor%>% filter(name=="Mercedes")
team_analys <- rbind(tmp)
tmp <- constructor%>% filter(name=="Ferrari")
team_analys <- rbind(team_analys, tmp)
tmp <- constructor%>% filter(name=="Red Bull")
team_analys <- rbind(team_analys, tmp)
tmp <- constructor%>% filter(name=="McLaren")
team_analys <- rbind(team_analys, tmp)

#Membuat dataframe baru
tmp_2 <- c_standing%>%filter(raceId %in% stats$raceId)%>%
         filter(constructorId %in% team_analys$constructorId)
timV2 <- tim%>%filter(constructorId %in% team_analys$constructorId)

resultCAP_TEAM <- merge(tmp_2, timV2, by="constructorId", all.x = TRUE)
resultCAP_TEAM <- merge(resultCAP_TEAM, tahun, by="raceId", all.x = TRUE)

#Rename kolom
resultCAP_TEAM <- rename(resultCAP_TEAM, Points = points)
resultCAP_TEAM <- rename(resultCAP_TEAM, Classement = position)
resultCAP_TEAM <- rename(resultCAP_TEAM, Total_Wins = wins)
resultCAP_TEAM <- rename(resultCAP_TEAM, Constructor = name)
resultCAP_TEAM <- rename(resultCAP_TEAM, Year = year)

#Mengurutkan kembali semisal ada yang berubah
resultCAP_TEAM <- resultCAP_TEAM%>%arrange(raceId, positionText)

#Menambil data yang diperlukan saja
resultCAP_TEAM <- resultCAP_TEAM %>% select(Year,Classement,Constructor,Total_Wins,Points)

constructor_graph <- ggplot(resultCAP_TEAM, aes(x=Year, y=Points, color=Constructor)) + 
  geom_line() + geom_point() + theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=6),
                                     axis.text.y = element_text(vjust = 0.5,size=6),
                                     text=element_text(size=7),
                                     legend.text = element_text(colour="black", size=8, 
                                                                face="bold"),
                                     legend.key = element_rect(colour = "transparent", fill = "white"),
                                     legend.key.size = unit(0.4, "cm")) +
  scale_color_manual(name = "Constructor",
                     values = c("Ferrari" = "#DC0000",
                                "Mercedes" = "#00D2BE",
                                "McLaren" = "#FF8700",
                                "Red Bull" ="#0600EF")) +
  ggtitle("Constructor Championship")+
  scale_x_continuous(breaks=seq(2010, 2021, 1))
ggplotly(constructor_graph)
ggsave("team_plot.png",width = 914, dpi = 200, type = 'cairo',height = 740, units = "px")

##############################################################################
##                          GRAFIK DARI TEAM BUDGET                         ##
##############################################################################
teamBudget <- merge(budget,constructor, by="constructorId", all.x = TRUE)
teamBudget <- teamBudget %>% select(year, constructorId, name, nationality, budget)
budget_graph <- ggplot(teamBudget, aes(x=year, y=budget, color=name)) + 
  geom_line() + geom_point() + theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=6),
                                     axis.text.y = element_text(vjust = 0.5,size=6),
                                     text=element_text(size=7),
                                     legend.text = element_text(colour="black", size=8, 
                                                                face="bold"),
                                     legend.key = element_rect(colour = "transparent", fill = "white"),
                                     legend.key.size = unit(0.4, "cm")) +
  scale_color_manual(name = "name",
                     values = c("Ferrari" = "red",
                                "Mercedes" = "deepskyblue1",
                                "McLaren" = "darkorange",
                                "Red Bull" ="navyblue")) +
  ggtitle("Team Budget")+
  scale_x_continuous(breaks=seq(2010, 2021, 1))
ggplotly(budget_graph)
ggsave("budget_plot.png",width = 914, height = 740,dpi = 200, type = 'cairo', units = "px")

##############################################################################
##                       BAR CHART ENGINE TEAM 2022                         ##
##############################################################################
barteam <- bahrain2022%>%count(bahrain2022$Engine)
barteam <- rename(barteam,Engine = `bahrain2022$Engine`)
barteam <- rename(barteam,count = n)
barteam$count <- as.numeric(as.character(barteam$count)) / 2

barplotEngine<-ggplot(data=barteam, aes(x=Engine, y=count,fill=Engine)) +
  geom_bar(stat="identity")+theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=7),
                                  axis.text.y = element_text(vjust = 0.5,size=7),
                                  text=element_text(size=10),
                                  legend.text = element_text(colour="black", size=10, 
                                                             face="bold"),
                                  legend.key = element_rect(colour = "transparent", fill = "white"),
                                  legend.key.size = unit(0.5, "cm"))+
  ggtitle("Power Unit distribution")+
  scale_fill_manual(name = "Engine",
                      values = c("Ferrari" = "red",
                               "Mercedes" = "cyan",
                               "RB PowerTrain" = "mediumblue",
                               "Renault" ="yellow"))
ggplotly(barplotEngine)
ggsave("barplotengine.png",width = 914, height = 740,dpi = 200, type = 'cairo', units = "px")

##############################################################################
##                           GRAFIK BAHRAIN GP 2022                         ##
##############################################################################
bahraingp2022 <- bahrain2022%>%pivot_longer(c('0':'57'),
                                            names_to = "laps", values_to =
                                              "position")
bahraingp2022$laps <- as.integer(bahraingp2022$laps)
str(bahraingp2022)

bahraingp2022 <- bahraingp2022 %>% arrange(Name,laps)


bahrain_plot <- ggplot(bahraingp2022, aes(x=laps, y=position, color=Name)) + 
  geom_line() + theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=7),
                      axis.text.y = element_text(vjust = 0.5,size=7),
                      text=element_text(size=10),legend.position = "none",
                      legend.text = element_text(colour="black", size=10, 
                                                 face="bold"),
                      legend.key = element_rect(colour = "transparent", fill = "white"),
                      legend.key.size = unit(0.5, "cm"))+
  scale_x_continuous(breaks=seq(0,57,1))+
  scale_y_continuous(breaks=seq(1,20,1))+
  ggtitle("Bahrain GP 2022 (warna berdasarkan PU)")+
  scale_color_manual(name = "Name",
                     values = c("Lewis Hamilton" = "cyan",
                                "George Russel" = "cyan",
                                "Charles Leclerc" = "red",
                                "Carlos Sainz" = "red",
                                "Max Verstappen" = "blue",
                                "Sergio Perez" = "blue",
                                "Pierre Gasly" = "blue",
                                "Yuki Tsunoda" = "blue",
                                "Zhou Guanyu" = "red",
                                "Valtteri Bottas" = "red",
                                "Kevin Magnussen" = "red",
                                "Mick Schumacher" = "red",
                                "Alexander Albon" = "cyan",
                                "Nicholas Latifi" = "cyan",
                                "Nico Hulkenberg" = "cyan",
                                "Lance Stroll" = "cyan",
                                "Esteban Ocon" = "yellow",
                                "Fernando Alonso" = "yellow",
                                "Lando Norris" = "cyan",
                                "Daniel Ricciardo" = "cyan"
                     ))
##PEWARNAAN DIDASARI PADA ENGINE YANG DIGUNAKAN
ggplotly(bahrain_plot)
ggsave("bahrain_plot.png",width = 1910,dpi = 200, height = 700, type = 'cairo',units = "px")

##############################################################################
##                           GRAFIK SAUDI GP 2022                          ##
##############################################################################

saudigp2022 <- saudi2022%>%pivot_longer(c('0':'50'),
                                            names_to = "laps", values_to =
                                              "position")
saudigp2022$laps <- as.integer(saudigp2022$laps)
str(saudigp2022)

saudigp2022 <- saudigp2022 %>% arrange(Name,laps)


saudi_plot <- ggplot(saudigp2022, aes(x=laps, y=position, color=Name)) + 
  geom_line() + theme(axis.text.x = element_text(angle = 45, vjust = 0.5,size=7),
                      axis.text.y = element_text(vjust = 0.5,size=7),
                      text=element_text(size=10),legend.position = "none",
                      legend.text = element_text(colour="black", size=10, 
                                                 face="bold"),
                      legend.key = element_rect(colour = "transparent", fill = "white"),
                      legend.key.size = unit(0.5, "cm"))+
  scale_x_continuous(breaks=seq(0,50,1))+
  scale_y_continuous(breaks=seq(1,20,1))+
  ggtitle("Saudi Arabia GP 2022 (warna berdasarkan PU)")+
  scale_color_manual(name = "Name",
                     values = c("Lewis Hamilton" = "cyan",
                                "George Russel" = "cyan",
                                "Charles Leclerc" = "red",
                                "Carlos Sainz" = "red",
                                "Max Verstappen" = "blue",
                                "Sergio Perez" = "blue",
                                "Pierre Gasly" = "blue",
                                "Yuki Tsunoda" = "blue",
                                "Zhou Guanyu" = "red",
                                "Valtteri Bottas" = "red",
                                "Kevin Magnussen" = "red",
                                "Mick Schumacher" = "red",
                                "Alexander Albon" = "cyan",
                                "Nicholas Latifi" = "cyan",
                                "Nico Hulkenberg" = "cyan",
                                "Lance Stroll" = "cyan",
                                "Esteban Ocon" = "yellow",
                                "Fernando Alonso" = "yellow",
                                "Lando Norris" = "cyan",
                                "Daniel Ricciardo" = "cyan"
                     ))
##PEWARNAAN DIDASARI PADA ENGINE YANG DIGUNAKAN
ggplotly(saudi_plot)
ggsave("saudi_plot.png",width = 1910,dpi = 200, height = 700, type = 'cairo',units = "px")

##############################################################################
##############################################################################
##############################################################################
##############################################################################