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

how_many = 500
offset = 450

Temperatures.where(:probe_name => "Probe 1").order('created_at DESC').limit(how_many).offset(offset).each do |row|
 next if row.value == 0 || row.value == 85
 x1.unshift( row.created_at.strftime("%d-%m-%Y-%H:%M") )
 y1.unshift( row.value )
end

Temperatures.where(:probe_name => "Probe 2").order('created_at DESC').limit(how_many).offset(offset).each do |row|
 next if row.value == 0 || row.value == 85
 x2.unshift row.created_at.strftime("%d-%m-%Y-%H:%M")
 y2.unshift row.value
end

Temperatures.where(:probe_name => "Probe 3").order('created_at DESC').limit(how_many).offset(offset).each do |row|
 next if row.value == 0 || row.value == 85
 x3.unshift row.created_at.strftime("%d-%m-%Y-%H:%M")
 y3.unshift row.value
end


Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.output "plot.png"
    plot.terminal 'png'
    plot.title  "Yo"
    plot.ylabel "Temp"
    plot.xlabel "Time"
    plot.xtics 1800
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
            },
            Gnuplot::DataSet.new( [x3, y3] ) { |ds3|
              ds3.with = "linespoints"
              ds3.linewidth = 1
              ds3.using = "1:2"
              ds3.title = "Probe 3"
            }
    ]
  end
end

