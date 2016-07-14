require 'mechanize'

class ScreenshotGetter
  @agent = Mechanize.new
  @queue = "screenshots"

  def self.perform(full_url, file_name)
    puts file_name
    @agent.get(full_url).save('shots/' + file_name.chomp + '.png') 
  end
end
