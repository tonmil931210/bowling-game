Rails.application.routes.draw do
  get '/', to: 'games#index'
  
  #resources :frame_by_users
  resources :games do
    resources :frames
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
