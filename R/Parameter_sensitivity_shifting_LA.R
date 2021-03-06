# This code performs sensitivity analysis with parameter shifting from 5L pot to free seedling
# and make Figure 6
#-------------------------------------------------------------------------------------
############## Combining all data in one dataframe
# Merge all Cday, Rd, Cleaf, Cstem, Croot data
data.set = merge(subset(Cday.data.processed,volume %in% c(5,1000)),subset(Rd.data.processed,volume %in% c(5,1000)), all = TRUE)
data.set = merge(data.set,subset(LA.data.processed,volume %in% c(5,1000)), all = TRUE)
data.set = merge(data.set,subset(tnc.data.processed[,c("Date","volume","tnc","tnc_SE")],volume %in% c(5,1000)), all = TRUE)
data.set = merge(data.set,subset(Mleaf.data.processed,volume %in% c(5,1000)), all = TRUE)
data.set = merge(data.set,subset(Mstem.data.processed,volume %in% c(5,1000)), all = TRUE)
data.set = merge(data.set,subset(Mroot.data.processed,volume %in% c(5,1000)), all = TRUE)
# names(data)[4:ncol(data)] = c("Rd","Sleaf","Sleaf_SD","Mleaf","Mleaf_SD","Mstem","Mstem_SD","Mroot","Mroot_SD")
names(data.set)[3:ncol(data.set)] = c("Cday","Rd","LA","LA_SD","Sleaf","Sleaf_SD","Mleaf","Mleaf_SD","Mstem","Mstem_SD","Mroot","Mroot_SD")
# data[ , c(9:ncol(data))] = data[ , c(9:ncol(data))] * 0.65 # Unit conversion: gDM to gC


# summary.param.set = subset(summary.param, variable %in% var[p] & volume %in% c(5,1000))
# keeps = c("Date", "variable", "Parameter", "volume")
# param.set = summary.param.set[ , keeps, drop = FALSE]
# param.set.casted = dcast( param.set , Date ~ variable )

##################------------------------------
# Consider everything (Cday, LA, Rd, sigma, parameters) for potted seedling 5L (group 1)
q=0 # Case 0
Cday.data.set = subset(Cday.data.processed,volume==5) # Consider the free seedling to test the parameter sensitivity
Rd.data.set = subset(Rd.data.processed,volume==5)
Mleaf.data.set = subset(Mleaf.data.processed,volume==5)
Mstem.data.set = subset(Mstem.data.processed,volume==5)
Mroot.data.set = subset(Mroot.data.processed,volume==5)
Sleaf.data.set = tnc.data = subset(tnc.data.processed,volume==5)
LA.data.set = subset(LA.data.processed,volume==5)

# sigma.data.set = subset(sigma.data.processed,volume==5)
# sla.harvest.data = subset(sla.harvest.processed,volume %in% 5)
# sigma.data.set$SLA = sla.harvest.data$sla_no_tnc
sigma.data.set = subset(sigma.data.processed,volume==1000)
sla.harvest.data = subset(sla.harvest.processed,volume %in% 5)
sigma.data.set$SLA = sla.harvest.data$sla_no_tnc

summary.param = result[[2]]
param = subset(summary.param,(volume.group %in% 1)) # volume.group = 1 is for potted seedling 5L
# param = subset(summary.param,(volume==5)) # volume.group = 1 is for potted seedling 5L
keeps = c("Date", "variable", "Parameter")
param = param[ , keeps, drop = FALSE]
param.casted = dcast( param , Date ~ variable )

# Set the colours for the graph (colourblind friendly palette)
# cbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
# cbPalette = c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00")
# cbPalette = c("gray", "orange", "skyblue", "black", "yellow", "vermilion", "reddishpurple")

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

##################------------------------------
# Take the Cday for free seedling
q=1 # Case 1
# Raw data processing for free seedling only (1000L)
Cday.data.set = subset(Cday.data.processed,volume==1000) # Consider the free seedling to test the parameter sensitivity
# sigma.data.set = subset(sigma.data.processed,volume==1000)
# sla.harvest.data = subset(sla.harvest.processed,volume %in% 1000)
# sigma.data.set$SLA = sla.harvest.data$sla_no_tnc

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

##################------------------------------
# Take the Cday, Rd for free seedling
q=2 # Case 2
Rd.data.set = subset(Rd.data.processed,volume==1000) # Consider the free seedling to test the parameter sensitivity

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

############----------------------------------------
# Take the parameters af, as, ar for free seedling
q=3 # Case 4
param.pot = subset(summary.param,(volume.group %in% 1 & variable %in% c("k","Y","sf")))
param.free = subset(summary.param,(volume.group %in% 3 & variable %in% c("af","as","ar")))
param = rbind(param.pot, param.free)
keeps = c("Date", "variable", "Parameter")
param = param[ , keeps, drop = FALSE]
param.casted = dcast( param , Date ~ variable )

sla.harvest.data = subset(sla.harvest.processed,volume %in% 1000)
sigma.data.set$SLA = sla.harvest.data$sla_no_tnc

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

############----------------------------------------
# Take the parameters Y, af, as, ar for free seedling
q=4 # Case 5
param.pot = subset(summary.param,(volume.group %in% 1 & variable %in% c("k","sf")))
param.free = subset(summary.param,(volume.group %in% 3 & variable %in% c("Y","af","as","ar")))
param = rbind(param.pot, param.free)
keeps = c("Date", "variable", "Parameter")
param = param[ , keeps, drop = FALSE]
param.casted = dcast( param , Date ~ variable )

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

############----------------------------------------
# Take the parameters Y, af, as, ar, sf for free seedling
q=5 # Case 6
param.pot = subset(summary.param,(volume.group %in% 1 & variable %in% c("k")))
param.free = subset(summary.param,(volume.group %in% 3 & variable %in% c("Y","af","as","ar","sf")))
param = rbind(param.pot, param.free)
keeps = c("Date", "variable", "Parameter")
param = param[ , keeps, drop = FALSE]
param.casted = dcast( param , Date ~ variable )

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

############----------------------------------------
# Take the parameters Y, k, af, as, ar, sf for free seedling
q=6 # Case 7
param = subset(summary.param,(volume.group %in% 3)) # volume.group = 3 is for free seedling from the 3 groups
keeps = c("Date", "variable", "Parameter")
param = param[ , keeps, drop = FALSE]
param.casted = dcast( param , Date ~ variable )

# This sript runs the model equations for parameter shifting from potted seedling to free seedling
source("R/CBM_model_shift.R")

############ Summarize the C pools plots
######## Plot both set of Cday
plot.shift = list() 
font.size = 12
title = as.character(c("A","B","C","D","E","F","G","H","I"))
# cbPalette = c("gray", "orange", "skyblue", "green3", "yellow3", "#0072B2", "#D55E00")
cbPalette = c("gray", "orange", "skyblue", "black", "yellow3", "#0072B2", "#D55E00", "#009E73", "#CC79A7")

Cday.data.processed$Date = as.Date(Cday.data.processed$Date)
Cday.set = subset(Cday.data.processed, volume %in% c(5,1000))
plot.shift[[1]] = plot.Cday(Cday.set, 1)

######## Plot both set of Rd
Rd.data.processed$Date = as.Date(Rd.data.processed$Date)
Rd.set = subset(Rd.data.processed, volume %in% c(5,1000))
plot.shift[[2]] = plot.Rd(Rd.set, 2)

# Plot individual modelled parameters ("k","Y","af","sf") against "volume"
summary.param.set = subset(summary.param, variable %in% as.factor(c("af","as","ar")) & volume.group %in% c(1,3))
plot.shift[[3]] = plot.allocation.fractions(summary.param.set, 3)

summary.param.set = subset(summary.param, variable %in% as.factor("Y") & volume.group %in% c(1,3))
plot.shift[[4]] = plot.Y(summary.param.set, 4)
# plot.shift[[4]] = plot.shift[[4]] + ylab(expression(Y~"(g C "*g^"-1"*" C "*d^"-1"*")"))
# + theme(axis.text.x=element_blank())

summary.param.set = subset(summary.param, variable %in% as.factor("sf") & volume.group %in% c(1,3))
plot.shift[[5]] = plot.sf(summary.param.set, 5)
# plot.shift[[5]] = plot.shift[[5]] + ylab(expression(s[f]~"(g C "*g^"-1"*" C "*d^"-1"*")")) 
#   + theme(axis.text.x=element_blank())

summary.param.set = subset(summary.param, variable %in% as.factor("k") & volume.group %in% c(1,3))
plot.shift[[6]] = plot.k(summary.param.set, 6)
# plot.shift[[6]] = plot.shift[[6]] + ylab(expression(k~"(g C "*g^"-1"*" C "*d^"-1"*")"))
#   # + theme(axis.text.x = element_text(size = font.size, vjust=0))
#   + theme(plot.margin=unit(c(0.25, 0.5, 0.25, 0.5), units="line"))

# # This sript plots the C pools for various test cases with parameter shifted from potted seedling to free seedling
# source("R/generate_figures_param_shift.R")
shift.output.Mleaf = subset(shift.output,(variable %in% "Mleaf"))
plot.shift[[7]] = plot.Mleaf(shift.output.Mleaf)

shift.output.Mstem = subset(shift.output,(variable %in% "Mstem"))
plot.shift[[8]] = plot.Mstem(shift.output.Mstem)

shift.output.Mroot = subset(shift.output,(variable %in% "Mroot"))
plot.shift[[9]] = plot.Mroot(shift.output.Mroot)

png("output/Figure_5_parameter_shifting.png", units="px", width=2000, height=3000, res=220)
lay <- rbind(c(1,7,7),c(2,7,7),c(3,8,8),c(4,8,8),c(5,9,9),c(6,9,9))
grid.arrange(grobs = plot.shift, layout_matrix = lay)
dev.off()
#-------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
# Quantify the changes of final biomasses
mass.quantify = subset(shift.output, Date %in% as.Date("2013-05-21"))
keeps = c("variable", "value", "Case")
mass.quantify = mass.quantify[ , keeps, drop = FALSE]
mass.quantify = dcast( mass.quantify , variable ~ Case )
mass.quantify = mass.quantify[1:3,]

mass.quantify = mass.quantify[,-1]
mass.quantify = data.frame(t(mass.quantify))
# mass.quantify = mass.quantify[-1,]
rownames(mass.quantify) = c("5L", "Cday", "Rd", "allocations", "Y", "sf", "k")
names(mass.quantify) = c("Ct,f", "Ct,w", "Ct,r")

# for (i in 2:7) {
#   mass.quantify[i,] = mass.quantify[i,] - mass.quantify[1,]
# }
# mass.quantify[8,] = colSums(mass.quantify)
mass.quantify[,4] = rowSums(mass.quantify)
# rownames(mass.quantify)[8] = "Total"
names(mass.quantify)[4] = "Ct"
mass.quantify[,5] = mass.quantify[,4]
for (i in 7:2) {
   mass.quantify[i,5] = mass.quantify[i,5] - mass.quantify[(i-1),5]
}

# mass.quantify$change.Cday = (mass.quantify[,3] - mass.quantify[,2])
# mass.quantify$change.Rd = (mass.quantify[,4] - mass.quantify[,2])
# mass.quantify$change.alloc = (mass.quantify[,5] - mass.quantify[,2])
# mass.quantify$change.Y = (mass.quantify[,6] - mass.quantify[,2])
# mass.quantify$change.sf = (mass.quantify[,7] - mass.quantify[,2])
# mass.quantify$change.k = (mass.quantify[,8] - mass.quantify[,2])
# 
# mass.quantify$change.Cday = (mass.quantify[,3] - mass.quantify[,2]) / mass.quantify[,2]
# mass.quantify$change.Rd = (mass.quantify[,4] - mass.quantify[,3]) / mass.quantify[,3]
# mass.quantify$change.alloc = (mass.quantify[,5] - mass.quantify[,4]) / mass.quantify[,4]
# mass.quantify$change.Y = (mass.quantify[,6] - mass.quantify[,5]) / mass.quantify[,5]
# mass.quantify$change.sf = (mass.quantify[,7] - mass.quantify[,6]) / mass.quantify[,6]
# mass.quantify$change.k = (mass.quantify[,8] - mass.quantify[,7]) / mass.quantify[,7]
# mass.quantify$total = rowSums(mass.quantify[,c(2,9:14)])
# mass.quantify[4,c(2:8)] = colSums(mass.quantify[,c(2:8)])

# mass.quantify = mass.quantify[,-c(2:8)]
write.csv(mass.quantify, file = "output/final_mass_changes.csv", row.names = FALSE)
#-------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------
#- Make figure for AGU presentation
source("R/Parameter_shifting_AGU_presentation.R")

#-------------------------------------------------------------------------------------

