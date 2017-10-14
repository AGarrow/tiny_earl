Rails.application.routes.draw do
  resources :earls, only: %i[index show create], param: :short_url, path: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
