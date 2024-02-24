install.packages("dplyr")
install.packages("dbplyr")
install.packages("RMariaDB")
library(dplyr)
library(dbplyr)
library(RMariaDB)

connection <- dbConnect(RMariaDB::MariaDB(), 
                        dsn="mysql",
                        Server = "localhost",
                        dbname = "samplecs102", 
                        user = "root", 
                        password = '')
dbListTables(connection)

dbListFields(connection,"personal_info")

posts_dta <- dbGetQuery(connection, "SELECT * FROM samplecs102.personal_info")
glimpse(posts_dta)

empi_data <- dbGetQuery(connection, "SELECT * FROM samplecs102.personal_info")
glimpse(empi_data)

empi_data[c(1:10),]

empi_data <- dbGetQuery(connection, "SELECT * FROM samplecs102.personal_info")
tail(empi_data)

posts_data <- dbGetQuery(connection, "SELECT name, age, bday, sex FROM samplecs102.personal_info")
posts_data[c(1:2),]

query <- "INSERT INTO personal_info (name, age, bday, sex) VALUES ('Yumeko Jabami', 18, '2000-04-05', 'F')"
query1 <- "INSERT INTO personal_info (name, age, bday, sex) VALUES ('Mary Saotome', 19, '2000-04-05', 'F')"
query2 <- "INSERT INTO personal_info (name, age, bday, sex) VALUES ('Midari Ikishima', 23, '2000-04-05', 'F')"
query3 <- "INSERT INTO personal_info (name, age, bday, sex) VALUES ('Kirari Momobami', 22, '2000-04-05', 'F')"
query4 <- "INSERT INTO personal_info (name, age, bday, sex) VALUES ('Misaki Sakinoyama', 21, '2000-04-05', 'F')"
query_result <- dbSendQuery(connection, query)
dbClearResult(query_result)


dbDisconnect(connection)
