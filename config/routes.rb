Rails.application.routes.draw do

  get 'projects' => 'projects#index'
  
  resources :projects do
    resources :reviews
  end

end
