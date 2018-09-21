ModelInfo::Engine.routes.draw do

  root to: 'models#index'

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
  delete 'association_destroy',to: 'associations#destroy'

  get 'download_csv', to: 'downloads#download_csv'
  get 'download_json', to: 'downloads#download_json'
  get 'download_xml', to: 'downloads#download_xml'
end
