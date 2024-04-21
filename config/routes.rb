Rails.application.routes.draw do
  devise_for :users
  
  namespace :v1 do
    resource :auth do
      post :sign_up
      post :sign_in
    end

    resource :account do
      get :show
    end
    
  end
end
