Rails.application.routes.draw do
  devise_for :users
  
  namespace :v1 do
    resource :auth do
      post :sign_up
      post :sign_in
    end
  end
end
