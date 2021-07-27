Rails.application.routes.draw do
  root 'homepage#index'
  post '/withdraw', to: "homepage#withdraw" 
  get '/credentials', to: "homepage#credentials"
  get '/*path' => 'homepage#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
