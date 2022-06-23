Rails.application.routes.draw do
  # NOTE: -> show must be below new request routes
  scope module: 'tasks' do
    # category
    get 'categories', to: 'category#index'
    get 'category/new', to: 'category#new'
    get 'category/:id', to: 'category#show', as: 'category_show'
    get 'category/:id/edit', to: 'category#edit', as: 'category_edit'

    post 'category/create', to: 'category#create'
    patch 'category/:id', to: 'category#update', as: 'category_update'
    delete 'category/:id', to: 'category#destroy', as: 'category_delete'
    # end category

    # task
    get 'tasks', to: 'task#index'
    get 'task/new', to: 'task#new'
    get 'task/:id', to: 'task#show', as: 'task_show'
    get 'task/:id/edit', to: 'task#edit', as: 'task_edit'

    post 'task/create', to: 'task#create'
    patch 'task/:id', to: 'task#update', as: 'task_update'
    delete 'task/:id', to: 'task#destroy', as: 'task_delete'

    # end of task
  end
end
