#!/usr/bin/ruby

require File.dirname(__FILE__) + "/../config/application"
Rails.application.require_environment!

require 'gnuplot'

x1 = []
x2 = []
y1 = []
y2 = []
x3 = []
y3 = []

Temperatures.where(:probe_name => "Probe 1").limit(100).each do |row|
 x1 << row.tstamp.strftime("%d-%m-%Y-%H:%M")
 y1 << row.value
end

Temperatures.where(:probe_name => "Probe 2").limit(100).each do |row|
 x2 << row.tstamp.strftime("%d-%m-%Y-%H:%M")
 y2 << row.value
end

#Temperatures.where(:probe_name => "Probe 3").limit(100).each do |row|
# x3 << row.tstamp.strftime("%d-%m-%Y-%H:%M")
# y3 << row.value
#end


Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  
    plot.title  "Yo"
    plot.ylabel "Temp"
    plot.xlabel "Time"
    plot.xtics 3600
    plot.xdata "time"
    plot.timefmt '"%d-%m-%Y-%H:%M"'
    plot.format 'x "%d-%m-%Y-%H:%M"'
    #pp x1
    plot.xrange '["' + x1.first + '":"'+ x1.last + '"]'
    
    plot.data  = [
	    Gnuplot::DataSet.new( [x1, y1] ) { |ds1|
	      ds1.with = "linespoints"
	      ds1.linewidth = 2
	      ds1.using = "1:2"
	      ds1.title = "Probe 1"
	    },
            Gnuplot::DataSet.new( [x2, y2] ) { |ds2|
              ds2.with = "linespoints"
              ds2.linewidth = 1
              ds2.using = "1:2"
              ds2.title = "Probe 2"
            }
 #           Gnuplot::DataSet.new( [x3, y3] ) { |ds3|
 #             ds3.with = "linespoints"
 #             ds3.linewidth = 1
 #             ds3.using = "1:2"
 #             ds3.title = "Probe 3"
 #           }
    ]
  end
end

