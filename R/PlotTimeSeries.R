#' Plot time series, original
#'
#' This function will plot the time series data.  See the initial portion of the function for parts that you can alter.
#'
#' The default plot is the standard IEA time series plot. If you include a "treshold" value, the plot will shift
#' format to plotting versus a threshold. If so, threshold.loc, will swap the plotting of grey polygons to indicate
#' periods where the timeseries is above or below the threshold.
#'
#' There are special plots for Seabirds: For seabird plots you must include both Y2 and Y.outlier in the plot call.
#' For seabird mortality, Y is all the data, Y2 is data with outliers removed, Y.outlier are just the outliers.
#' Trends are evaluated with the outliers removed.
#'
#' @param dframe expected column names are: "year", "index", "timeseries", "metric","SEup", "SElo", "SE"
#' @param X column name, typically "year", to plot on x axis
#' @param Y column name, typically "index", to plot on y axis
#' @param Y2 ...
#' @param Y.outlier ...
#' @param threshold threshold value
#' @param threshold.loc ...
#' @param threshold.correct ...
#' @param sig.trend significant trend
#' @param sig.mean significant mean
#' @param stats.years ...
#' @param LWD ...
#' @param LWD.threshold ...
#' @param SE ...
#' @param SEup NOTE: if you call SEup separately (say to plot SD instead of SE), the first value cannot be an NA. Set it and SElo to the index data point for that value.
#' @param SElo ...
#' @param XLIM ...
#' @param YLIM ...
#' @param Xlab ...
#' @param Ylab ...
#' @param Title ...
#' @param Xangle ...
#' @param Xaxis.cex ...
#' @param Yaxis.cex ...
#' @param Ylab.cex ...
#' @param TitleCex ...
#' @param YATS ...
#' @param Y.lab.drop ...
#' @param Y.axis.labels ...
#' @param yminor ...
#' @param Label.cex ...
#' @param Pt.cex ...
#' @param TicsEvery ...
#' @param MinorTics ...
#' @param ALPHA ...
#' @param PERIOD ...
#' @param Arrow.cex ...
#' @param AltTxt.Period ...
#' @param AltTxt ...
#' @param AltTxt.file.name ...
#' @param Mar ...
#' @param Bmar ...
#' @param Lmar ...
#' @param Tmar ...
#' @param Rmar ...
#' @param Ylab_line ...
#'
#' @return
#' @export
#'
#' @concept plot_original
PlotTimeSeries <-function(
  dframe=NA,
  X = NA,
  Y = NA,
  Y2 = NULL, # set to NA to NOT plot points
  Y.outlier = NULL, # for birds to exclude outliers
  threshold = NA,
  threshold.loc = "below",
  threshold.correct = FALSE, # corrects for missing values in the threshold plots. Assumes zero is minimum.
  sig.trend = NA, # for plotting stream flow data.   values are c('positive','negative','not_sig')
  sig.mean = NA,
  stats.years = NA, # to calculate mean and sd for a specific set of years not whole time series.  For climate data.
  LWD = 1,
  LWD.threshold = 1,
  SE = NULL,
  SEup = NA,
  SElo = NA,
  XLIM = NA,
  YLIM = NA,
  Xlab = NA,
  Ylab = NULL,
  Title = NULL,
  Xangle = 0,
  Xaxis.cex = 0.9, # plotted separately from y axis
  Yaxis.cex = 0.9, # plotted separately from x axis
  Ylab.cex = 0.9, # 1
  TitleCex = 0.9,
  YATS = 3, # number of tics on Y axis
  Y.lab.drop = FALSE, # quick trigger to skip every other label on the yaxis.  Set to TRUE to skip
  Y.axis.labels = NA, # eg,  c(0, 0.50, 1.00)  overides other axis plotting
  yminor = NA, # location of minor tics on y axis, eg  c( 0.25, 0.75,)
  Label.cex = 0.9, # 1.0,
  # Axis.cex = 1,
  Pt.cex = 0.3, # change point size on plots
  TicsEvery = 10,
  MinorTics = 1,
    # NULL names the file based on the timeseries.  NA does not plot a title.
  ALPHA = 200,
  PERIOD = 5,  # set to 0 to not plot diagnostics
  Arrow.cex = 2,
  AltTxt.Period = '5-years',
  AltTxt = NA,
  AltTxt.file.name = NA,  # this output name is necessary if you have weird characters in the time series name (eg, a colon, ":")
  Mar = c(0, 3.5, 0.7, 0),  # set all margins at once
  #Mar = c(5, 4, 4, 2),
  Bmar = NA, ## or one at a time
  Lmar = NA,
  Tmar = NA,
  Rmar = NA, # occassionally necessary to make space for legend
  Ylab_line = 2.5){ # occasionally necessary to make space for the Ylabel if the #'s are large

  ####################################### end input ###############################################
  # set color scheme here ####
  # col2rgb("lightblue")

  mn.col = 'black'
  sd.col =  box.col = threshold.col = rgb(63, 173, 213, max = 255)
  pt.col =  rgb(225, 118, 44, max = 255)
  line.col = "black"
  error.col = rgb(211, 211, 211, alpha = ALPHA, max = 255) # transparent grey
  arrow.color = "black"
  # threshold.col = rgb(65, 173, 213, max = 255)
  threshold.fill.col = "lightgrey"

  # SET PLOT PARAMETERS HERE ####
  title.font = 2

  if(is.na(Bmar == TRUE)){Bmar = Mar[1]}
  if(is.na(Lmar == TRUE)){Lmar = Mar[2]}
  if(is.na(Tmar == TRUE)){Tmar = Mar[3]}
  if(is.na(Rmar == TRUE)){Rmar = Mar[4]}

  par(ps = 10, cex = 1, cex.axis = Yaxis.cex, cex.main = TitleCex, cex.lab=Label.cex, mar=c(Bmar,Lmar,Tmar,Rmar))#, bg=NA)

  # load data; set title and TS for alt text ####
  if(length(dframe)==1){X = X; Y = Y; TS = Title}
  if(length(dframe)!=1){
    X=dframe$year
    Y=dframe$index

    if(is.na(Y2) || is.null(Y2)){Y2 <- Y} # for when y is raw.data but no fitted data exist. to plot points.

    # browser()

    TS = Title
    if(is.null(Title)){Title=dframe$timeseries[1]; TS=Title}else{
      if(is.na(Title)){Title=NA; TS=dframe$timeseries[1]}}
    if(is.null(Ylab)){Ylab=dframe$metric[1]}else{if(is.na(Ylab)){Ylab=NA}}

    #### calculate SE ###
    # find SEup and SElo
    if(is.na(SEup[1] == TRUE)){
      if(length(SEup) > 1){SEup[1] = SElo[1] <- Y[1]}
    }

    if(is.na(SEup[1])==TRUE){ # use SEup if specified externally or calculate within
      cn = colnames(dframe)
      se.up = grep('SEup',cn)
      # for SEup and SElo in dframe
      if(length(se.up)>0){SEup=dframe$SEup;SElo=dframe$SElo}
      # if(length(se.up)==1){SEup=dframe$SEup;SElo=dframe$SElo}
      # for just specifying SE
      if(is.null(SE)){
        if(length(se.up)==0){if(!is.null(dframe$SE)){SEup=dframe$index+dframe$SE; SElo=dframe$index-dframe$SE}}
        if(length(se.up)==0){if(!is.null(dframe$se)){SEup=dframe$index+dframe$se; SElo=dframe$index-dframe$se}}
      }}
  }

  # convert to time. Data should be 2011-04-28 or just year 2009
  if(nchar(as.character(X[1]))>10){ X = substring(X,1,10)} # X is correct.  Removes extra characters.
  if(nchar(as.character(X[1]))==10){ x = as.POSIXct(X)}                 # year-month-day
  if(nchar(as.character(X[1]))== 7){ x = as.POSIXct(paste(X,01,sep='-'))}   # year-month
  if(nchar(as.character(X[1]))== 4){ x = as.POSIXct(paste(X,01,01,sep='-'))}# year
  XY = data.frame(cbind(x,Y))
  XXYY = XY  # used later for polygons in threshold plots
  XY = na.omit(XY)
  XLIM1 = as.numeric(substring(as.POSIXct(strptime(XLIM[1], "%Y")),1,4))
  XLIM2 = as.numeric(substring(as.POSIXct(strptime(XLIM[2], "%Y")),1,4))

  #prep for x-axis labels and ranges####
  x1 = as.numeric(substring(as.POSIXct(strptime(x, "%Y")),1,4))
  xmin1 = min(x1)
  xmin2=ifelse(is.na(XLIM1)==TRUE,xmin1,XLIM1)
  Xmin = as.POSIXct(paste((xmin2-1),11,01,sep='-'))
  xmax = max(x)
  xmax1 = as.POSIXct(paste(max(x1),01,01,sep='-'))

  # covert for date within year by extending to next year
  if(xmax>xmax1){xmax2 = max(x1)+1}else{xmax2=max(x1)}
  xmax3 = ceiling(xmin2 + 1.02*(xmax2 -xmin2))
  xmax4 = ifelse(is.na(XLIM2)==TRUE,xmax3,ceiling(min(xmin2) + 1.02*(XLIM2 - xmin2)))
  Xmax = as.POSIXct(paste(xmax4,01,01,sep='-'))
  xL = length(X)   # for pch and lwd
  xmax5 = ifelse(is.na(XLIM2)==TRUE,xmax2,XLIM2)

  # range of xlabels
  labrange = c(xmin2:xmax5)
  atx  = as.POSIXct(paste(labrange,01,01,sep='-'))
  xlabs = as.numeric(substring(as.POSIXct(strptime(atx, "%Y")),1,4))

  # mean and sd of the full time series####
  Y[Y %in% c(-999, -9999)] <- NA  # replace -999 with NAs
  if(!is.null(Y2)){Y2[Y2 %in% c(-999, -9999)]<- NA} # replace -999 with NAs
  SEup[SEup %in% c(-999, -9999)] <- NA
  SElo[SElo %in% c(-999, -9999)] <- NA

  # remove points a priori identified as outliers. mostly for seabirds
  if(!is.null(Y.outlier)){Y.calc = Y2}else{Y.calc = Y}

  if(is.na(stats.years[1])==TRUE){ # for most plots
    stdev = sd(Y.calc, na.rm=TRUE)
    mn = mean(Y.calc, na.rm=TRUE)
    Usd = mn+stdev
    Lsd = mn-stdev

    # for seabirds, I think
    stdev.plot = sd(Y, na.rm=TRUE)
    mn.plot = mean(Y, na.rm=TRUE)
    Usd.plot = mn.plot+stdev.plot
    Lsd.plot = mn.plot-stdev.plot
  }else{ # for specifying the years to calculate stats. Mostly for ONI, PDO, NGPO data
    x.yr = substr(x,1,4)
    Y.temp = data.frame(cbind(x.yr,Y.calc))
    Y.calc2 = as.numeric(as.character(Y.temp[Y.temp$x %in% stats.years,'Y.calc']))
    stdev = sd(Y.calc2, na.rm=TRUE)
    mn = mean(Y.calc2, na.rm=TRUE)
    Usd = mn+stdev
    Lsd = mn-stdev
  }

  #set Y range based on data and/or SE
  if(is.na(YLIM[1])==TRUE){ymin = min(Y,Y2,SElo,Lsd,na.rm=TRUE)}else{ymin=YLIM[1]}
  if(length(YLIM==2)){
    if(is.na(YLIM[2])==TRUE){ymax = max(Y,Y2,SEup, Usd, na.rm=TRUE)}else{ymax=YLIM[2]}
  }
  # yats = pretty(c(ymin,ymax), n=YATS)
  # Y.axis.labels = c(0, 1.0, 2.0)

  if(is.na(Y.axis.labels[1]) == TRUE){yats = pretty(c(ymin,ymax), n=YATS)}else{yats = Y.axis.labels}
  # format maintains decimal places for integers
  maxats = max(yats)
  Ymin1=ifelse(is.na(YLIM[1])==TRUE,ymin,YLIM[1])
  Ymax=ifelse(is.na(YLIM[2])==TRUE,max(ymax,maxats),YLIM[2])
  Ymin = Ymin1 - 1*(Ymax-Ymin1) # makes space below the graph.  Not for axis labeling

  # for shifting 45 degree years.
  mdfy=length(xlabs)/100
  xshift = max(mdfy*diff(xlabs)[1],0.3)

  #### PLOT COMMAND ####
  plot(Y~x, xlab=NA, ylab=NA, pch='19', type="n",
       xlim=c(Xmin, Xmax), ylim=c(Ymin,Ymax),
       bty="n", xaxt="n", yaxt='n')
  xline =  min(min(yats) - 0.05*(par()$usr[4]-par()$usr[3]),ymin)
  modif1 = ifelse(length(atx)>21,0.06,0.05)
  tl =     min(xline) - modif1*(par()$usr[4]-par()$usr[3])
  tl2 =    min(xline) - 0.03*(par()$usr[4]-par()$usr[3])
  modif2 = ifelse(length(atx)>21,0.16,0.14)
  txtloc = min(xline) - modif2*(par()$usr[4]-par()$usr[3])

  # yaxis
  # quick function to drop everyother ylab to make axes easier to see if they are crowded.
  if(Y.lab.drop == TRUE){
    g = seq(1, length(yats),2)
    ymajor = yats[g]
    h = seq(2, length(yats),2)
    yminor = yats[h]
  }else{ymajor <- yats}
  yats.label = format(ymajor)

  axis(side=2, at=ymajor, labels=yats.label, las=1, cex=1)
  if(is.na(yminor[1])==FALSE){axis(side=2, at=yminor, labels=NA, tck = -0.05)}

  #### location of x lables ##############
  ########### Xangle == 0####
  if(is.na(TicsEvery)==TRUE){
    if(Xangle==0){
      if(length(atx)<=13){
        lines(c(Xmin,atx[length(atx)]),c(xline,xline))
        for(g in 1:length(atx)){
          arrows(atx[g],xline,atx[g],tl,length=0)

        }
        for(g in 1:length(atx)){
          #text(atx[g]-xshift,txtloc,xlabs[g], srt=Xangle, cex=0.7)
          text(atx[g],txtloc,xlabs[g], srt=Xangle, cex = Xaxis.cex)
        }
      }
      if(length(atx)>13){
        seq.num=3
        if((length(atx)/2==floor(length(atx)/2))==TRUE){seq.num=2}
        if((length(atx)/3==floor(length(atx)/3))==TRUE){seq.num=3}
        if((length(atx)/4==floor(length(atx)/4))==TRUE){seq.num=4}
        if(length(atx)>50){seq.num=5}
        if(length(atx)>99){seq.num=10}
        atx2 = as.numeric(substring(as.character(atx),1,4))
        atx3 = rev(abs(seq(-max(atx2), -min(atx2), seq.num)))
        atx4 = as.POSIXct(paste(atx3,01,01,sep='-'))
        lines(c(Xmin,atx[length(atx)]),c(xline,xline))
        for(g in 1:length(atx)){
          arrows(atx4[g],xline,atx4[g],tl,length=0)
        }
        for(g in 1:length(atx3)){
          text(atx4[g],txtloc,atx3[g], srt=Xangle, cex = Xaxis.cex)
        }
      }
    }
    ############ Xangle == 45 or 90  ####
    if(Xangle!=0){
      if(length(atx)<=13){
        lines(c(Xmin,atx[length(atx)]),c(xline,xline))
        for(g in 1:length(atx)){
          arrows(atx[g],xline,atx[g],tl,length=0)

        }
        for(g in 1:length(atx)){
          text(atx[g]-xshift,txtloc,xlabs[g], srt=Xangle, cex= Xaxis.cex)
        }
      }
      if(length(atx)>13){
        seq.num=3
        if((length(atx)/2==floor(length(atx)/2))==TRUE){seq.num=2}
        if((length(atx)/3==floor(length(atx)/3))==TRUE){seq.num=3}
        if((length(atx)/4==floor(length(atx)/4))==TRUE){seq.num=4}
        if(length(atx)>50){seq.num=5}
        if(length(atx)>99){seq.num=10}
        atx2 = as.numeric(substring(as.character(atx),1,4))
        atx3 = rev(abs(seq(-max(atx2), -min(atx2), seq.num)))
        atx4 = as.POSIXct(paste(atx3,01,01,sep='-'))
        lines(c(Xmin,atx[length(atx)]),c(xline,xline))
        for(g in 1:length(atx)){
          arrows(atx4[g],xline,atx4[g],tl,length=0)
        }
        for(g in 1:length(atx3)){
          text(atx4[g]-xshift,txtloc,atx3[g], srt=Xangle,  cex= Xaxis.cex)
        }
      }
    }
    ############
  }else{
    atx2 = as.numeric(substring(as.character(atx),1,4))
    atx3 = rev(abs(seq(-max(atx2), -min(atx2), TicsEvery)))
    atx4 = as.POSIXct(paste(atx3,01,01,sep='-'))
    lines(c(Xmin,atx[length(atx)]),c(xline,xline))
    for(g in 1:length(atx)){
      arrows(atx4[g],xline,atx4[g],tl,length=0)
    }
    for(g in 1:length(atx3)){
      text(atx4[g],txtloc,atx3[g], srt=Xangle,cex= Xaxis.cex)
    } # end g
  } # end else

  # minor tics ####
  if(is.na(MinorTics)==TRUE){atx2 = as.numeric(substring(as.character(atx),1,4))
  if(length(atx)>99){atx5 = rev(abs(seq(-max(atx2),-min(atx2),5)))}else{atx5=atx}
  atx6 = as.POSIXct(paste(atx5,01,01,sep='-'))
  for(g in 1:length(atx5)){
    arrows(atx6[g],xline,atx6[g],tl2,length=0)}
  }else{
    atx2 = as.numeric(substring(as.character(atx),1,4))
    atx5 = rev(abs(seq(-max(atx2),-min(atx2),MinorTics)))
    atx6 = as.POSIXct(paste(atx5,01,01,sep='-'))
    for(g in 1:length(atx5)){
      arrows(atx6[g],xline,atx6[g],tl2,length=0)}
  }

  # title(Title, line=0, font=title.font, cex.main=TitleCex)

  # get time period for analysis.
  period = PERIOD-1
  xeval = atx[(length(atx)-period)]
  yloc = length(Y)-period
  if(is.null(Y.outlier)){Y5 = Y[yloc:length(Y)]}else{Y5 = Y2[yloc:length(Y2)]}
  X5 = x[yloc:length(x)]

  #### plot longterm mean and sd & replot the data on top ####

  # for error envelope
  # color <- rgb(190, 190, 190, alpha=ALPHA, maxColorValue=255)

  # set up for missing data so line and error don't skip
  x2 = ifelse(is.na(Y),NA,x)[is.na(Y)==FALSE]
  y2 = ifelse(is.na(Y),NA,Y)[is.na(Y)==FALSE]
  SEup2 = ifelse(is.na(Y),NA,SEup)[is.na(Y)==FALSE]
  SElo2 = ifelse(is.na(Y),NA,SElo)[is.na(Y)==FALSE]


  ### STANDARD plot features ####
  if(PERIOD!=0){
    if(is.na(threshold)){
      # plot se envelope style

      if(is.null(Y.outlier)){
        # plot box around evaluation period. upper and lower are set by Usd and Lsd.
        polygon(x=c(X5[1],max(X5),max(X5),X5[1]), y=c(Usd,Usd,Lsd,Lsd), border=NA,col=box.col)
        # plot mean and sd of full time series ####
        segments(Xmin,mn,max(x),mn, col=mn.col,lty="dotted",lwd=1)
        segments(Xmin,Usd,max(x),Usd, col=sd.col,lwd=1)
        segments(Xmin,Lsd,max(x),Lsd,col=sd.col,lwd=1)
        if(is.na(SEup[1])==FALSE){polygon(c(x2,rev(x2)),c(SEup2,rev(SElo2)),border=NA,col=error.col)}

      }
      if(!is.null(Y.outlier)){
        # plot box around evaluation period
        polygon(x=c(X5[1],max(X5),max(X5),X5[1]), y=c(Usd.plot,Usd.plot,Lsd.plot,Lsd.plot),col=box.col, border = NA, lwd=0.5)
        # plot mean and sd of full time series ####
        # polygon(x=c(Xmin,max(x),max(x),Xmin), y=c(Usd,Usd,Lsd,Lsd),lty = 'dotted',col=NA )
        segments(Xmin, Usd, max(x), Usd, lty = 'dotted')
        segments(Xmin, Lsd, max(x), Lsd, lty = 'dotted')
      }


      #get plot dimensions for scaling
      xx<-par()
      x1<-xx$usr[1]
      x2<-xx$usr[2]

      # run regression on last 5 years
      #check if the change is greater or less than one sd of full time series

      m1 = lm(Y5~X5)
      s1 <- summary(m1)
      b1 <- s1$coefficients[2,1]
      pval <- s1$coefficients[2,4]
      pred = predict(m1)
      delta = pred[length(pred)] - pred[1]
      Z = abs(delta)-(stdev)

      x01 <- (x2-x1)*0.97 + x1     	# center of point on xaxis

      y01 = yats[1] + (max(yats) - yats[1])*0.7
      y02 = yats[1] + (max(yats) - yats[1])*0.3


      # plot upper arrow or equals sign ####
      LineWT = 3

      afont = 2
      arrow.cex= Arrow.cex

      # switch to user imput symbols for flow data
      if(is.na(sig.trend[1])==FALSE){
        Z = ifelse(sig.trend[1] %in% c('positive','negative'), 1, 0)
        delta = ifelse(sig.trend[1] == 'positive', 1, -1)
      }

      if(Z<=0){text(x01,y01,"\\->", family="HersheySymbol", cex=arrow.cex, col=arrow.color, font=2)}
      if(Z>0 & delta>0){text(x01,y01,"\\#H2296", family="HersheySymbol", cex=arrow.cex, col=arrow.color, font=2)}
      if(Z>0 & delta<0){text(x01,y01,"\\#H2299", family="HersheySymbol", cex=arrow.cex, col=arrow.color, font=2)}

      mn5 = mean(Y5, na.rm=TRUE)
      dMean = mn-mn5
      Z2 = abs(dMean)-stdev

      # plot pl or minus sign

      # switch to user imput symbols for flow data
      if(is.na(sig.mean[1])==FALSE){
        Z2 = ifelse(sig.mean[1] %in% c('positive','negative'), 1, 0)
        dMean = ifelse(sig.mean[1] == 'positive', -1, 1)
      }

      if(Z2<=0){points(x01,y02,cex=1, pch=19, col='black')}
      if(Z2>0 & dMean>0){text(x01,y02,"_", cex=1, col=arrow.color, font=afont)}
      if(Z2>0 & dMean<0){text(x01,y02,"+", cex=1, col=arrow.color, font=afont)}

    } # end standard plot ###
  } # end standard plot features on/off

  # some preparations; files used below.
  XY = data.frame(cbind(x,Y))
  XY0 = XY

  if(threshold.loc == 'above'){XY0[is.na(XY)] <- 0}else{XY0[is.na(XY)] <- threshold}

  XY = na.omit(XY)
  # NA/s converted to zeros for plotting on thresholds

  # THRESHOLD line and polygon fill ####
  if(!is.na(threshold)){
    if(threshold.loc=='n'){segments(Xmin,threshold,max(x),threshold,col=threshold.col,lwd=1)}else{
      if(threshold.correct == TRUE){
        d1 = c(XY0$x,rev(XY0$x))
        d2 = c(XY0$Y, rep(threshold,length(XY0$Y)))}else{
          d1 = c(XY$x,rev(XY$x))
          d2 = c(XY$Y, rep(threshold,length(XY$Y)))}
      polygon(d1,d2, border=NA, col=threshold.fill.col)
      d3.l = length(d1)/2
      fill.loc = ifelse(threshold.loc=="above",min(yats),max(yats))
      d3 = c(rep(threshold,d3.l),rep(fill.loc,d3.l))
      polygon(d1,d3, border=NA, col="white")
      #threshold line #####
      if(threshold>xline){segments(Xmin,threshold,max(x),threshold,col=threshold.col,lwd=LWD.threshold)}
    }

  } #####

  #REPLOT time series on top ####
  if(is.na(LWD)==TRUE){LWD = ifelse(100/xL > 2, 0.5, ifelse(100/xL < 1,0.5, 1))}else{LWD = LWD}

  if(threshold.correct == TRUE){
    lines(Y~x,lwd=LWD,col=line.col)
    lines(XY0$Y~XY0$x,lwd=LWD,col=line.col, lty="dotted")
  }else{lines(Y~x,lwd=LWD,col=line.col)
    lines(XY$Y~XY$x,lwd=LWD,col=line.col, lty="dotted")}
  Y3 = na.omit(Y2)
  if(!is.na(Y3[1])){points(Y2~x, pch=20, col=pt.col, cex=Pt.cex)}

  # seabird extra plot - plot outliers as new point symbol to identify ####

  if(!is.null(Y.outlier)){
    Y.out = data.frame(cbind(x, Y.outlier))
    Y.out = na.omit(Y.out)
    points(Y.out[,1],Y.out[,2], pch=21, cex=Pt.cex*1.5, bg='white')
  }

  if(!is.na(threshold)){
    if(is.na(SEup[1])==FALSE){
      lines(x,SEup,lty="dotted")
      lines(x,SElo,lty="dotted")
    }}

  # AXIS LABELS ####
  if(is.na(Xlab)!=TRUE){mtext(side=1, Xlab, line=-1)}
  loc = par()$usr[3] + 0.7*(par()$usr[4]- par()$usr[3])
  mtext(side=2,Ylab, line=Ylab_line, at=loc, cex=Ylab.cex)

  # title ####
  if(!is.na(Title)==TRUE){title(Title, line=0, font=title.font, cex.main=TitleCex)}

  # update note on figure ####

  if(exists('note.update.status')==TRUE){
    if(note.update.status == TRUE){if(dframe$type[1] != 'current.data'){legend('topleft',legend='old data', bg='red')}else{
      legend('topleft',legend='new data', bg='green')}}
  }

  ############### ALT Text doesn't work special bird plots

  ##########   ALT Text ########
  if(!is.na(AltTxt)){
    d1 = substring(AltTxt,nchar(AltTxt),nchar(AltTxt))
    if(d1!="/"){AltTxt= paste(AltTxt,"/",sep="")}
    atxmin = min(X)
    atxmax = max(X)
    YMin = round(Ymin,2); YMax = round(Ymax,2)
    atymin = ifelse(Ymin<0,paste("negative",abs(YMin)),YMin)
    atymax = ifelse(Ymax<0,paste("negative",abs(YMax)),YMax)
    xy = data.frame(cbind(X,Y))
    xy$X = as.character(xy$X)
    xy$Y = as.numeric(as.character(xy$Y))
    ymx = xy[match(max(na.omit(xy$Y)),xy$Y),]
    ymn = xy[match(min(na.omit(xy$Y)),xy$Y),]


    if(is.null(Ylab)){Ylab = dframe$metric[1]}
    if(is.na(Ylab)){Ylab = dframe$metric[1]}

    ##### Standard plotting alt text ####
    if(is.na(threshold)){

      OpeningStatement = paste0("This figure shows time-series data for ", TS," (y-axis, ", Ylab,") from ", atxmin," to ",atxmax," (x-axis, Year). ")
      # MeanStatement = paste0("The mean of the full time series was ",round(mn,2),". ")
      Mean_SD = paste0("The mean of the full time series was ",round(mn,2)," (lower standard deviation = ", round(Lsd,2), ", upper standard deviation = ",round(Usd,2), "). ")
      HighLowYears = paste0( "The index was highest in ", ymx[1,1]," (at ", round(ymx[1,2],2),"), and lowest in ", ymn[1,1]," (at ", round(ymn[1,2],2),"). ")
      # StandardDeviationStatement = paste0("The upper standard deviation was ", round(Usd,2),", and the lower standard deviation was ",round(Lsd,2),".")

      # alt text to describe the arrows
      if(Z<=0){PeriodTrend = paste0('The index changed by less than one standard deviation of the full time series over the last ', AltTxt.Period, '. ')}
      if(Z>0 & delta>0){PeriodTrend = paste0('The index increased by more than one standard deviation of the full time series over the last ' ,AltTxt.Period, '. ')}
      if(Z>0 & delta<0){PeriodTrend = paste0('The index decreased by more than one standard deviation of the full time series over the last ', AltTxt.Period, '. ')}

      # alt text to describe the plus and minus
      if(Z2<=0){points(x01,y02,cex=1, pch=19)
        PeriodMean = paste0("The mean of the last ", AltTxt.Period," was within one standard deviation of the long-term mean. ")
      }
      if(Z2>0 & dMean>0){PeriodMean = paste0("The mean of the last ", AltTxt.Period,"  was more than one standard deviation below the mean of the full time series. ")}
      if(Z2>0 & dMean<0){PeriodMean = paste0("The mean of the last ",AltTxt.Period," was more than one standard deviation above the mean of the full time series. ")}

      ###################### alt text "above years" ###################
      above.sd = na.omit(xy[xy$Y>Usd,])
      if(nrow(above.sd)==0){
        AboveYears = 'The index was never above one standard deviation of the full time series. '
      }
      if(nrow(above.sd)==1){
        above.last = above.sd[1,1]
        AboveYears = paste0("The index was more than one standard deviation above the mean of the full time series in ",above.last,'. ')
      }
      if(nrow(above.sd)==2){
        AboveYears = paste0("The index was  more than one standard deviation above the mean of the full time series in ",above.sd[1,1]," and ",above.sd[2,1],". ")
      }
      if(nrow(above.sd)>2){
        no.yrs = nrow(above.sd)
        above.first = above.sd[1,1]
        above.last = above.sd[no.yrs,1]
        above = above.first
        for(i in 2:(no.yrs-1)){
          above = paste0(above,", ",above.sd[i,1])
        }
        above.years = paste0(above," and ",above.last)
        AboveYears = paste0("The index was more than one standard deviation above the mean of the full time series in ",above.years,". ")
      }

      ### below years ####
      below.sd = na.omit(xy[xy$Y<Lsd,])
      if(nrow(below.sd)==0){
        BelowYears = 'The index was never below one standard deviation of the full time series. '
      }
      if(nrow(below.sd)==1){
        below.last = below.sd[1,1]
        BelowYears = paste0("The index was more than one standard deviation below the mean of the full time series in ",below.last,'. ')
      }
      if(nrow(below.sd)==2){
        BelowYears = paste0("The index was more than one standard deviation below the mean of the full time series in ",below.sd[1,1]," and ",below.sd[2,1],". ")
      }
      if(nrow(below.sd)>2){
        no.yrs = nrow(below.sd)
        below.first = below.sd[1,1]
        below.last = below.sd[no.yrs,1]
        below = below.first
        for(i in 2:(no.yrs-1)){
          below = paste0(below,", ",below.sd[i,1])
        }
        below.years = paste0(below," and ",below.last)
        BelowYears = paste0("The index was more than one standard deviation below the mean of the full time series in ",below.years,". ")
      }
      LastYear = paste0("The index was ",round(Y[length(Y)],2), " in ",X[length(X)],", the most recent year of the time series. ")

      AltText = paste0(OpeningStatement, Mean_SD, AboveYears, BelowYears, LastYear)
      # AltText

      #file.name = paste(AltTxt,TS,"_alt.txt", sep='')
      # file.name = paste0(AltTxt,TS,"_alt.txt")
      # fileConn<-file(file.name)
      # writeLines(AltText, fileConn)
      # close(fileConn)
    } # end standard alt text

    ##################### Alt text for threshold graph ##########################
    if(!is.na(threshold)){
      OpeningStatement = paste0("This figure shows time-series data for ", TS," from ",atxmin," to ",atxmax," (x-axis, Year). The y-axis (",Ylab, ") varies from ",atymin," to ",atymax,". The index is plotted relative to a threshold value of ",threshold,". The threshold is indicated by a blue line.")

      # above ####
      at3 = paste0("The index was highest in ", ymx[1,1]," (at ", round(ymx[1,2],2),"), and lowest in ", ymn[1,1]," (at ", round(ymn[1,2],2),"). ",sep='')
      above.th = na.omit(xy[xy$Y>threshold,])
      if(nrow(above.th)==0){
        AboveYears = paste0('The index was never above the threshold')
      }
      if(nrow(above.th)==1){
        above.last = above.th[1,1]
        AboveYears = paste0("The index was above the threshold value of")
      }
      if(nrow(above.th)==2){
        AboveYears = paste0("The index was above the threshold in ",above.th[1,1]," and ",above.th[2,1],". ")
      }
      if(nrow(above.th)>2){
        no.yrs = nrow(above.th)
        above.first = above.th[1,1]
        above.last = above.th[no.yrs,1]
        above = above.first
        for(i in 2:(no.yrs-1)){
          above = paste(above,", ",above.th[i,1], sep='')
        }
        above.years = paste0(above," and ",above.last)
        AboveYears = paste0("The index was above the threshold in ",above.years,". ")
      }
      # below
      below.th = na.omit(xy[xy$Y>Lsd,])
      if(nrow(below.th)==0){
        BelowYears = 'The index was never below the threshold. '
      }
      if(nrow(below.th)==1){
        below.last = below.th[1,1]
        BelowYears = paste0("The index was below the threshold in ",below.last,'. ')
      }
      if(nrow(below.th)==2){
        BelowYears = paste0("The index was below the threshold in ",below.th[1,1]," and ",below.th[2,1],". ")
      }
      if(nrow(below.th)>2){
        no.yrs = nrow(below.th)
        below.first = below.th[1,1]
        below.last = below.th[no.yrs,1]
        below = below.first
        for(i in 2:(no.yrs-1)){
          below = paste0(below,", ",below.th[i,1])
        }
        below.years = paste0(below," and ",below.last)
        BelowYears = paste0("The index below the threshold in ",below.years,". ")
      }
      LastYear = paste0("The index was ",round(Y[length(Y)],2), " in ",X[length(X)],", the most recent year of the time series. ")

      AltText = paste0(OpeningStatement, AboveYears, BelowYears, LastYear)

      # file.name = paste(AltTxt,TS,"_alt.txt", sep='')
      # fileConn<-file(file.name)
      # writeLines(AltText, fileConn)
      # close(fileConn)
    } # end threshold alt text

    prefix= opts_current$get()$label
    if(is.null(prefix)){prefix <- ""}

    if(is.na(AltTxt.file.name)==TRUE){alt.name = TS}else{alt.name=AltTxt.file.name}

    #browser()
    file.name = paste0(AltTxt, prefix,"_", alt.name, "_alt.txt")
    fileConn <- file(file.name)
    writeLines(AltText, fileConn)
    close(fileConn)
  }  # end all alt text
     # return(XXYY)
}  # end funtion



