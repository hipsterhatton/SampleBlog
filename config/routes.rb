Rails.application.routes.draw do
  root to: 'blog#index'

  resources :blogs, constraints: {id: /[0-9]+/}
end
