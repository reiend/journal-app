Rails.application.routes.draw do
  scope module: 'tasks' do
    get 'categories', to: 'category#index'
    get 'category/new', to: 'category#new'
    get 'category/:id/edit', to: 'category#edit', as: 'category_edit'

    patch 'category/:id', to: 'category#update', as: 'category_update'
    post 'category/create', to: 'category#create'
    delete 'category/:id', to: 'category#destroy', as: 'category_delete'
  end
end
