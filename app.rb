require 'bundler'
require 'pp'

Bundler.require

module StoreSearch
  class App < Sinatra::Application
    APP_ID = 'FP9WZYG9KK'
    ADMIN_KEY = '6f8534882bd2383dc21b40b1458091df'
    
    before do
      Algolia.init :application_id => APP_ID, :api_key => ADMIN_KEY
      @index = Algolia::Index.new('index_BC')
    end

    get '/foo' do
      content_type :json
      request.env.to_json
    end

    get '/' do
      ips = ['203.1.14.1', '107.23.25.145', '24.173.111.130', '66.55.20.19', '172.87.176.58', '172.87.176.59', '207.141.13.226', '173.200.71.96']
      if ips.include? request.env['HTTP_X_FORWARDED_FOR']
        erb :index
      else
        'nope.'
      end
    end

    post '/tags' do
      puts params
      content_type :json
      { :key1 => 'value1', :key2 => 'value2' }.to_json
    end

    post '/upvote' do
      @index.partial_update_object(
        {"votes" => {"value" => 1, "_operation" => "Increment"},
                                    "objectID" => params[:id]})
      return ''
    end

    post '/downvote' do
      @index.partial_update_object(
        {"votes" => {"value" => 1, "_operation" => "Decrement"},
                                    "objectID" => params[:id]})
      return ''
    end
  end
end
