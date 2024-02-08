###################################################
#### Write your names and student numbers here ####
#Hua_Tan_tanhua_1008071337
#Di_Zhu_zhudi17_1007967568 

###################################################
## Define your sets here

set J;	#the num of type of shoes 557
set N;	#RM_Num
set E;	#machine num
set W;	#the num of warehouse


###################################################
## Define your parameters here
#BOM 
param quantity{J,N} default 0;
param cost{N};
#machine master
param avgDuration{J, E} default 0;
param opcost{E};
#Product_Master
param sales{J}; 
#RM_Num
param s_Quantity{N};
#Warehouse_Master
param capacity{W};
#Product demand
param demand{J};


###################################################
## Define your decision variables here
var x{J} >=0; 

###################################################
## Define your objective function here
maximize Profit: sum{j in J} sales[j]*x[j]- 10*(sum{j in J} (2*demand[j]-x[j]))- sum{j in J, n in N}x[j]*quantity[j, n]*cost[n]- sum{j in J, e in E} (1/60)*x[j]*opcost[e]*avgDuration[j, e] - sum{j in J, e in E} (25/3600)*x[j]*avgDuration[j, e];

###################################################
## Define your constraints here
subject to material: sum{j in J, n in N} x[j]*quantity[j,n]*cost[n] <= 100000000;
subject to Capacity : sum {j in J} x[j] <= sum{w in W}capacity[w];
subject to rawMaterial {n in N}: sum{j in J} x[j]*quantity[j, n] <= s_Quantity[n];
subject to machineTIme {e in E}: sum{j in J} (1/60)*x[j]*avgDuration[j, e] <= 20160;
subject to DEMand {j in J}: x[j] <= demand[j];
