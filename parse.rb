# take in mbox archive and export target xpath node values as csv

require 'mbox'
require 'base64'
require 'oga'
require 'csv'

#ensure file passed in, file should be .mbox
if ARGV[0].length < 1
  abort 'You have to pass in a file'
end

#for each email in .mbox, parse with mbox gem and store as HTML chunk

html_content = []

Mbox.open(ARGV[0]).each do |mail|
  html_content << mail.content.first.to_s
end

#for each HTML chunk, parse using Oga and store values in array of arrays

values = []  #initialize arr_of_arrs

#load html and set target xpaths to export
html_content.each do |html|
  parsed_html = Oga.parse_html(html)
  title = parsed_html.at_xpath('/html/body/table/tr/td/table/tr[2]/td/span/span[2]/a')
  name = parsed_html.xpath('/html/body/table/tr/td/table/tr[3]/td/table/tr[2]/td[1]')
  email = parsed_html.xpath('/html/body/table/tr/td/table/tr[3]/td/table/tr[2]/td[2]')
  values << [title.text.strip,name.text.strip,email.text.strip]  #strip whitespace from html and write to arr_of_arrs
end

#write arr_of_arrs to csv with headers
CSV.open("splash_rsvp.csv", "w",
    :write_headers=> true,
    :headers => ["challenge","name","email"]) {|csv| values.each {|elem| csv << elem} }
