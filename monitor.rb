#!/usr/bin/env ruby
require 'fileutils'
require 'rubygems'
require 'json'
require 'httparty'

@file = "monitor.js"
 
while true do
  @sites = YAML.load_file("monitor.yml")["sites"]

  @sites.each do |site|
    puts site[1].inspect
    
    @url = site[1]["url"]
    
    if @url !~ /^http/
      @url = "http://#{@url}"
    end
    
    File.open(@file, "w") do |f|
      response = HTTParty.get(@url)
      @result = JSON.generate({
        :url => @url,
        :status => response.code
      })
      f.write(@result)
      puts "pinging #{@url} with result: #{@result}"
    end
  end
  sleep(5)
end
