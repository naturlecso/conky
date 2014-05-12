#!/bin/ruby

require 'rest-client'
require 'nokogiri'
require 'time'

def time_12h_to_24h time_12h
  Time.strptime(time_12h.upcase, "%I:%M %p").strftime("%H:%M")
end

# Debrecen
rss = RestClient.get "http://weather.yahooapis.com/forecastrss?w=12593356&u=c"
doc = Nokogiri::XML(rss)

File.open("#{Dir.home}/.conky/cache/weather", 'w+') do |file|

  # info
  info = 'info '
  doc.xpath("//yweather:location").map do |params|
    info << params['city'] << ' '
  end

  doc.xpath("//yweather:astronomy").map do |params|
    info << "#{time_12h_to_24h params['sunrise']} #{time_12h_to_24h params['sunset']}"
  end
  
  file.puts info

  # day format: 'dayN day high low image'
  # day0
  doc.xpath("//yweather:condition").map do |params|
    file.puts "day0 N/A #{params['temp']} N/A #{params['code']}"
  end

  # day1..5
  doc.xpath("//yweather:forecast").each_with_index do |params, index|
    i = index + 1
    file.puts "day#{i} #{params['day']} #{params['high']} #{params['low']} #{params['code']}"
  end
end
