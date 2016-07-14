require 'resque'
require './screenshot_getter'

def screenshotlayer(url, options={})
  access_key = 'd67955e3e35cbc09d843e280376fe664'
  secret_keyword = 'hooli'
 
  parameters = {
    :url      => url,
    :width    => options[:width],
    :viewport => options[:viewport],
    :delay => options[:delay]
  }
   
  query = parameters.
    sort_by {|s| s[0].to_s }. 
    select {|s| s[1] }.       
    map {|s| s.map {|v| CGI::escape(v.to_s) }.join('=') }.
    join('&')
  
  # generate md5 secret key
  secret_key = Digest::MD5.hexdigest(url + secret_keyword)
 
  "https://api.screenshotlayer.com/api/capture?access_key=#{access_key}&secret_key=#{secret_key}&#{query}"
end


File.open("large-10000-list.txt", "r") do |f|
  f.each_line do |url|
    full_url = screenshotlayer(url, { width: "400", viewport: "1440x900", delay: "2"})   
    file_name = url.gsub("http://", "").gsub("https://", "")

    Resque.enqueue(ScreenshotGetter, full_url, file_name)
  end
end

