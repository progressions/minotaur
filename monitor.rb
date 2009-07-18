#!/usr/bin/env ruby
require 'fileutils'
require 'rubygems'
require 'json'
require 'httparty'

@file = "monitor.js"
@url = 'http://www.weracketeer.com'
   
while true do
  File.open(@file, "w") do |f|
    response = HTTParty.get(@url)
    f.write JSON.generate({
      :url => @url,
      :status => response.code
    })
    puts "writing"
  end
  sleep(5)
end
