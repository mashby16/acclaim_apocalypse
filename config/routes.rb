Rails.application.routes.draw do
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  '/signup', to: 'accounts#new'
  post '/signup', to: 'accounts#create'
  get '/myaccount', to: 'accounts#show', :as => :root
  patch '/myaccount', to: 'accounts#update'
  get '/edit', to: 'accounts#edit'
  get '/new_candidates', to: 'candidates#new'
  post '/fetch_candidates', to: 'candidates#fetch'
  post '/assign_badge', to: 'candidates#assign_badge'
  delete '/remove_candidate', to: 'candidates#destroy'
end
