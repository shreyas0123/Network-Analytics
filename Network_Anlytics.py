##################### problem1 ###################
#Problem Statement: -
#There are two dataset consists of information for the connecting routes and flight hault. Create network analytics model on both the datasets separately and measure degree Centrality, degree of closeness centrality and degree of in-between centrality respectively.
#connecting routes=c("flights", " ID", "main Airport”, “main Airport ID", "Destination ","Destination  ID","haults","machinary")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx

#degree centrality
#load the dataset
conn_routs = pd.read_csv("E:/DATA SCIENCE ASSIGNMENT/Class And Assignment Dataset/Asss/Network Analytics/connecting_routes.csv")
conn_routs.drop(conn_routs.columns[6],axis = 1, inplace = True)
conn_routs.columns = ["flights", "ID", "main Airport", "main Airport ID", "Destintion", "Destination ID", "haults", "machinary"]
                     
g = nx.Graph()
g = nx.from_pandas_edgelist(conn_routs, source = 'main Airport', target = 'Destintion')
print(nx.info(g))

b = nx.degree_centrality(g)  # Degree Centrality
print(b) 
pos = nx.spring_layout(g, k = 0.15)
nx.draw_networkx(g, pos, node_size = 25, node_color = 'blue')

# closeness centrality
closeness = nx.closeness_centrality(g)
print(closeness)

## Betweeness Centrality 
b = nx.betweenness_centrality(g) # Betweeness_Centrality
print(b)

## Eigen-Vector Centrality
evg = nx.eigenvector_centrality(g) # Eigen vector centrality
print(evg)

# cluster coefficient
cluster_coeff = nx.clustering(g)
print(cluster_coeff)

# Average clustering
cc = nx.average_clustering(g) 
print(cc)

