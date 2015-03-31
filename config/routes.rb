ModelInfo::Engine.routes.draw do
  get 'associations/index'

  get 'associations/create'

  get 'associations/show'

  get 'associations/edit'

  get 'associations/destroy'

  patch 'associations/update'

  get 'fetch_model_infos/index'
  post 'fetch_model_infos_create', to: 'fetch_model_infos#create'
  get 'fetch_model_infos/new', to: 'fetch_model_infos#new'
  get 'fetch_model_infos/display', to: 'fetch_model_infos#display'
  get 'fetch_model_infos_show' => 'fetch_model_infos#show'
  get 'fetch_model_infos_edit' => 'fetch_model_infos#edit'
  get 'fetch_model_infos_destroy' => 'fetch_model_infos#destroy'
  patch 'fetch_model_infos_update' => 'fetch_model_infos#update'
  get 'fetch_model_infos_association_data' => 'fetch_model_infos#association_data'
end
