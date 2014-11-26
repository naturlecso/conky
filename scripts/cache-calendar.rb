#!/bin/ruby

require 'rss'
require 'uri'

calendarfeed = File.open("#{Dir.home}/.conky/private/calendarfeed") { |f| f.readline }.chop

rss = RSS::Parser.parse(URI(calendarfeed), false)

File.open("#{Dir.home}/.conky/cache/calendar", 'w+') do |file|
  rss.items.each do |item|
    # get date from summary
    date = item.summary.content[/\d{4}.\d{2}.\d{2}./]
    # get event title and limit its length
    title = item.title.content
    title = title[0..28].gsub(/.{3}$/, '...') unless title.length <= 28

    file.puts "#{date} - #{title}"
  end
end
