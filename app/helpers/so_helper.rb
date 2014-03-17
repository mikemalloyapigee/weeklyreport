module SoHelper
  def curl_url(url)
    c = Curl::Easy.perform(url)
    gz = Zlib::GzipReader.new( StringIO.new( c.body_str ) ).read
    jdata = JSON.parse(gz)
  end

  def SOData(start_date, end_date)
    min= Time.utc(start_date.year,start_date.month,start_date.day).to_i 
    max= Time.utc(end_date.year,end_date.month,end_date.day).to_i
    key="J2L9)ViIDwPorFr3npJWSQ(("
    next_page = true
    page = 1
    items = []
    while(next_page)
      url = "https://api.stackexchange.com/2.1/questions?"+ "page=" + page.to_s + "&pagesize=50&order=desc&fromdate=" + min.to_s + "&todate=" + max.to_s 
      url = url +"&sort=activity&tagged=apigee&filter=default&site=stackoverflow&run=true&key=" + key
      #debugger
      jdata = curl_url(url)
      jdata["items"].each do |question|
        items << question
      end
      if jdata["next_page"]
        page = page + 1
      else
        next_page = false
      end
    end
    items
  end
end