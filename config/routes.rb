Rails.application.routes.draw do
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'

  # GET URI Pattern to: 'games#score'

  # POST '/score(.:format)' to: 'games#score'
end
