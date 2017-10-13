Rails.application.routes.draw do
  resources :earls, only: [:index, :show, :create], param: :short_url
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "earls#index"
end
