Rails.application.routes.draw do
  devise_for :users
  
  namespace :v1 do
    resource :auth do
      post :sign_up
      post :sign_in
    end

    resources :users do
      collection do
        get :account
      end
    end
  end
end
