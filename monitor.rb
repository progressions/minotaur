#!/usr/bin/env ruby
require 'fileutils'
require 'rubygems'
require 'json'
require 'httparty'

@file = "monitor.js"
   
while true do
  File.open(@file, "w") do |f|
    response = HTTParty.get('http://www.google.com')
    f.write JSON.generate({:status => response.code})
    puts "writing"
  end
  sleep(5)
end
