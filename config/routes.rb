Rails.application.routes.draw do
  scope '/r5test' do
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
