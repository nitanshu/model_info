ModelInfo::Engine.routes.draw do
  get 'fetch_model_infos/index'
  get 'fetch_model_infos/display', to: 'fetch_model_infos#display'
  get 'fetch_model_infos_show' => 'fetch_model_infos#show'
  get 'fetch_model_infos_edit' => 'fetch_model_infos#edit'
  get 'fetch_model_infos_destroy' => 'fetch_model_infos#destroy'
  patch 'fetch_model_infos_update' => 'fetch_model_infos#update'
end
