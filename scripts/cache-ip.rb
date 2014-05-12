#!/bin/ruby

require 'rest-client'
require 'json'

json = RestClient.get "ip-api.com/json"
location = JSON.parse(json)
ip = location["query"]

File.open("#{Dir.home}/.conky/cache/ip", 'w+') { |f| f.write ip }
print ""
