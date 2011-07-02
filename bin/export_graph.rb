#!/usr/bin/ruby

require '../lib/bootstrap.rb'

require 'gnuplot'

x1 = []
x2 = []
y1 = []
y2 = []

Database::Temperature.where(:probe_name => "Probe 1").each do |row|
 x1 << row.tstamp.strftime("%d-%m-%Y-%H:%M")
 y1 << row.value
end

Database::Temperature.where(:probe_name => "Probe 2").each do |row|
 x2 << row.tstamp.strftime("%d-%m-%Y-%H:%M")
 y2 << row.value
end


Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
  
    plot.title  "Yo"
    plot.ylabel "Temp"
    plot.xlabel "Time"
    plot.xtics 3600
    plot.xdata "time"
    plot.timefmt '"%d-%m-%Y-%H:%M"'
    plot.format 'x "%d-%m-%Y-%H:%M"'
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
    ]
  end
end

