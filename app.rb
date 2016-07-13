require 'bundler'

Bundler.require

module StoreSearch
  class App < Sinatra::Application
    APP_ID = 'FP9WZYG9KK'
    SEARCH_API_KEY = '987bdd9558561da935683e87c907137a'

    Algolia.init :application_id => APP_ID, :api_key => SEARCH_API_KEY

    get '/' do
      erb :index
    end

    post '/search' do
      index = Algolia::Index.new('bc_stores')
      results = index.search(params[:query])
      hits = results["hits"]
      erb :results, :locals => {:hits => hits}
    end
  end
end
