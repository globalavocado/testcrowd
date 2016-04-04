Rails.application.routes.draw do

  root to: 'projects#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  resources :projects, shallow: true do
    resources :reviews do
      resources :endorsements
    end
  end

end
