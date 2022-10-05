Rails.application.routes.draw do
  root 'homes#index'

  resources 'pokedexes' do
    get '/page/:page', action: :index, on: :collection
  end

  resources 'skills' do
    get '/page/:page', action: :index, on: :collection
  end

  resources 'pokemons' do
    get :edit_skill, on: :member
    post :update_skill, on: :member
    delete :destroy_skill, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
end
