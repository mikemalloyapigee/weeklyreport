require 'json'
require 'zlib'
require 'date'
require 'curb'
require 'stringio'

min= Time.utc(2014,3,3).to_i 
max= Time.utc(2014,3,9).to_i
key="J2L9)ViIDwPorFr3npJWSQ(("

page = 1
url = "https://api.stackexchange.com/2.1/questions?"+ "page=" + page.to_s + "&pagesize=50&order=desc&fromdate=" + min.to_s + "&todate=" + max.to_s 
url = url +"&sort=activity&tagged=apigee&filter=default&site=stackoverflow&run=true&key=" + key
 
c = Curl::Easy.perform(url)
gz = Zlib::GzipReader.new( StringIO.new( c.body_str ) ).read
jdata = JSON.parse(gz)
puts gz["items"].length