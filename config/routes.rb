Rails.application.routes.draw do
  get 'blog/index'
  get 'blog/new'
  get 'blog/create'
  get 'blog/edit'
  get 'blog/update'
  get 'blog/delete'
  get 'blog/search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
