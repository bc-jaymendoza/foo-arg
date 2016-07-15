require 'bundler'

Bundler.require

module StoreSearch
  class App < Sinatra::Application
    APP_ID = 'FP9WZYG9KK'
    ADMIN_KEY = '6f8534882bd2383dc21b40b1458091df'
    
    before do
      Algolia.init :application_id => APP_ID, :api_key => ADMIN_KEY
      @index = Algolia::Index.new('index_BC')
    end

    get '/' do
      erb :index
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
  end
end
