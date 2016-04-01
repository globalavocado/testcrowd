Rails.application.routes.draw do

  devise_for :users

  root to: 'projects#index'
  
  resources :projects, shallow: true do
    resources :reviews do
      resources :endorsements
    end
  end

end
