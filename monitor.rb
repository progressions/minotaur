#!/usr/bin/env ruby
require 'fileutils'
require 'rubygems'
require 'json'
require 'httparty'

@file = "javascripts/monitor.js"

def monitor()
  begin

  @sites = YAML.load_file("config/monitor.yml")["sites"]
  @result = []

  File.open(@file, "w") do |f|
      
    @sites.each do |site|
      @site_name = site[0]
      @url = site[1]["url"]
    
      if @url !~ /^http/
        @url = "http://#{@url}"
      end
    
      response = HTTParty.get(@url)
      @result << {
        :site => @site_name,
        :url => @url,
        :status => response.code,
        :date => Time.now.to_s
      }
    
      # TODO: Break into its own class or incorporate a logging library
      FileUtils.mkdir_p "log"
      File.open("log/monitor.log", "a") do |l|
        status_string = "#{Time.now.to_s} Pinging #{@url} with result #{response.code}\n"
        l.write status_string
        puts status_string
      end
    end
    f.write(JSON.generate(@result))
  end
  sleep(5)
  rescue e
    
  end
end

while true do
  monitor()
end
