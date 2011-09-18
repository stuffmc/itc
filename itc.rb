#!/usr/bin/env ruby
DIR      = File.dirname(__FILE__) # change this if the other files than itc.rb aren't in the same directory. Not in most cases
require File.join(DIR, 'itc-pwd.rb') 
require 'mechanize'

# You shouldn't change these but if Apple changes, we'll need to change it ;-)
ITC = "https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/wo/"
LOGIN = "6.0.9.3.5.2.1.1.3.1.1?theAccountName=#{USERNAME}&theAccountPW=#{PASSWORD}"
APPS = "Manage Your Applications"
ALERT = "Your Status for #{APP} changed on iTunes Connect"
changed = false

def alarm
  puts ALERT
  puts "\a\a\a\a\a"
  system("say '#{ALERT}' -v alex")
  true
end

loop do
  if changed
    # this is to ensure the "It's okay, I'll do something factor!"
    changed = alarm
    # You'll have to break and restart the app for it to stop! ;-)
  else
    puts "\n\nLogin to iTunes Connect at " + Time.now.to_s
    agent = Mechanize.new
    page = agent.get(ITC+LOGIN) # Loging
    puts "Clicking '#{APPS}'..."
    page = agent.page.links.find { |l| l.text == APPS }.click # clicking "Manage Your Applications"
    puts "Clicking '#{APP}'..."
    page = agent.page.links.find { |l| l.text =~ /#{APP}/ }.click # clicking the App you want to track

    puts "Checking Status..."
    # Warning VERY fuzzy way of looking for the "status" <span>. There's always mostly version of your app: the current one and the next one. If it's the first one you might want to change the 5 to a 1. Then we check the content of this span, which should be something else than what we have in a file located in the same directory as the script.
    status = page.search(".//div[@class='version-container']/div/p/span")[5].content().strip()
    puts "Status: " + status

    # We'll now check the "YOUR APP.txt" file to see if we have a new status
    file = File.join(DIR, APP+'.txt')
    if File.exists?(file)
      if File.open(file, 'rb') { |f| f.read } != status
        changed = alarm
      end
    else
      File.open(file, 'w') {|f| f.write(status) }
    end
  end
  sleep 600 # It's probably fine to check every 10 minutes. Checking too often might not please Apple :)
end

