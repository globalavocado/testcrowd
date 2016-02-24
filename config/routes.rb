Rails.application.routes.draw do

  get 'projects' => 'projects#index'
  
  resources :projects

end
