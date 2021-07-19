############################### problem1 ###########################
#Problem Statement: -
#There are two dataset consists of information for the connecting routes and flight hault. Create network analytics model on both the datasets separately and measure degree Centrality, degree of closeness centrality and degree of in-between centrality respectively.
#Flight_hault=c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
#connecting routes=c("flights", " ID", "main Airport", "main Airport ID", "Destination ","Destination  ID","haults","machinary")

install.packages("igraph")
library(igraph)
#load the dataset
flight_haults <- read.csv("E:\\DATA SCIENCE ASSIGNMENT\\Class And Assignment Dataset\\Asss\\Network Analytics\\flight_hault.csv")
colnames(flight_haults) <- c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
con_routes <- read.csv("E:\\DATA SCIENCE ASSIGNMENT\\Class And Assignment Dataset\\Asss\\Network Analytics\\connecting_routes.csv")
con_routes <- con_routes[,-c(7)]
colnames(con_routes) <- c("flights", " ID", "main Airport", "main Airport ID", "Destination ","Destination  ID","haults","machinary")

con_routesNW <- graph.edgelist(as.matrix(con_routes [, c(3, 5)]), directed = TRUE)
plot(con_routesNW)

## How many flights are there in the network?
?vcount
vcount(con_routesNW)

## How many connections are there in the network?
?ecount
ecount(con_routesNW)

# Which airport has most flights coming in, and how many?
?degree
indegree <- degree(con_routesNW, mode = "in")
max(indegree)
index <- which(indegree == max(indegree))
indegree[index]
which(flight_haults$IATA_FAA == "ATL")
flight_haults[3583, ]

# Which airport has most flights going out of, and how many?
outdegree <- degree(con_routesNW, mode = "out")
max(outdegree)
index <- which(outdegree == max(outdegree))
outdegree[index]
which(flight_haults$IATA_FAA == "ATL")
flight_haults[3583, ]

# Which airport is close to most of the airports (in terms of number of flights)
?closeness
closeness_in <- closeness(con_routesNW, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(flight_haults$IATA_FAA == "FRA")
flight_haults[337, ]

# Which airport comes in between most of the routes and hence is an important international hub?
?betweenness
btwn <- betweenness(con_routesNW, normalized = TRUE)
max(btwn)
index <- which(btwn == max(btwn))
btwn[index]
which(flight_haults$IATA_FAA == "LAX")
flight_haults[3385,]

# Degree, closeness, and betweenness centralities together
centralities <- cbind(indegree, outdegree, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)

# correlations of the centralities
cor(centralities)

# Any pair with low correlation?
plot(centralities[, "closenessIn"], centralities[, "betweenness"])
?subset
subset(centralities, (centralities[,"closenessIn"] > 0.015) & (centralities[,"betweenness"] > 0.06))
flight_haults[which(flight_haults$IATA_FAA == "LAX"), ]
flight_haults[which(flight_haults$IATA_FAA == "CDG"), ]
flight_haults[which(flight_haults$IATA_FAA == "ANC"), ]

subset(centralities, (centralities[, "closenessIn"] < 0.005) & (centralities[, "betweenness"] < 0.02))

# Which is one of the most important airport in the world (the Google way)?
?eigen_centrality
eigenv <- eigen_centrality(con_routesNW, directed = TRUE, scale = FALSE, weights = NULL)
eigenv$vector
max(eigenv$vector)
index <- which(eigenv$vector == max(eigenv$vector))
eigenv$vector[index]
which(flight_haults$IATA_FAA == "ATL")
flight_haults[3583, ]

?page_rank
pg_rank <- page_rank(con_routesNW, damping = 0.999) # do not put damping=1; the solution not necessarily converges; put a value close to 1.
pg_rank$vector
max(pg_rank$vector)
index <- which(pg_rank$vector == max(pg_rank$vector))
pg_rank$vector[index]
which(flight_haults$IATA_FAA == "ATL")
flight_haults[3583, ]

################################### problem2 ###################################
############# circular network using adjacency matrix

#Problem statement
#There are three datasets given such as Facebook, Instagram and LinkedIn. Construct and visualize the following networks:
#.	circular network for Facebook
#.	star network for Instagram
#.	star network for LinkedIn

#load the dataset
fb <- read.csv("E:\\DATA SCIENCE ASSIGNMENT\\Class And Assignment Dataset\\Asss\\Network Analytics\\facebook.csv",header = TRUE)
head(fb)

#creat a network using adjacency matrix
fbNW <- graph.adjacency(as.matrix(fb), mode="undirected", weighted=TRUE)
plot(fbNW)

############## star network for instagram
#load the dataset
ins <- read.csv("E:\\DATA SCIENCE ASSIGNMENT\\Class And Assignment Dataset\\Asss\\Network Analytics\\instagram.csv",header = TRUE)
head(ins)

#creat a star network for instagram
AnotherstarNW <- graph.adjacency(as.matrix(ins), mode = "undirected", weighted = TRUE)
plot(AnotherstarNW)

############## star network for LinkedIn
#load the dataset
linkedin <- read.csv("E:\\DATA SCIENCE ASSIGNMENT\\Class And Assignment Dataset\\Asss\\Network Analytics\\linkedin.csv",header = TRUE)
head(linkedin)

#creat a star network for linkedin
AnotherstarNW <- graph.adjacency(as.matrix(linkedin), mode = "undirected", weighted = TRUE)
plot(AnotherstarNW)

######################################## END ####################################