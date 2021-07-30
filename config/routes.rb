Rails.application.routes.draw do
  root 'homepage#index'
  post '/authenticate', to: "homepage#authenticate"
  post '/', to: "homepage#authenticate"
  post '/withdraw', to: "homepage#withdraw" 
  get '/not-found', to: "homepage#unauthorized" 
  get '/credentials', to: "homepage#credentials"
  get '/user-info', to: "homepage#user_info" 
  get '/*path' => 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
