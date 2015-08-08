Rails.application.routes.draw do

  # mount MetaFarm::Engine => "/meta_farm"
  
  get 'home', to: 'pages#home', as: 'home'
  
  root to: 'pages#home'
end
