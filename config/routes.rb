ModelInfo::Engine.routes.draw do

  get 'model_display', to: 'models#display'
  get 'models',to: 'models#index'
  get 'model_new',to: 'models#new'
  post 'model_create',to: 'models#create'
  get 'model_show',to: 'models#show'
  get 'model_edit',to: 'models#edit'
  patch 'model_update',to: 'models#update'
  delete 'model_destroy', to: 'models#destroy'

  get 'associations_index', to: 'associations#index'
  get 'association_new',to: 'associations#new'
  post 'association_create',to: 'associations#create'
  get 'association_show',to: 'associations#show'
  get 'association_edit',to: 'associations#edit'
  patch 'association_update',to: 'associations#update'
  get 'association_destroy',to: 'associations#destroy'
end
