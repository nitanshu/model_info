ModelInfo::Engine.routes.draw do
  root to: 'models#index'

  namespace :api do
    namespace :v1 do
      Rails.application.eager_load!
      model_names = ActiveRecord::Base.descendants.collect { |model| model.to_s if model.table_exists? }.compact
      model_names.delete('ActiveStorage::Blob')
      model_names.delete('ActiveStorage::Attachment')
      model_names.each do |model|
        get model, to: 'models#index'
        post model, to: 'models#create'
        put model, to: 'models#update'
      end
    end
  end
  get 'models', to: 'models#index'
  get 'model_new', to: 'models#new'
  post 'model_create', to: 'models#create'
  get 'model_show', to: 'models#show'
  get 'model_edit', to: 'models#edit'
  patch 'model_update', to: 'models#update'
  delete 'model_destroy', to: 'models#destroy'

  get 'associations_index',  to: 'associations#index'
  get 'association_new', to: 'associations#new'
  post 'association_create', to: 'associations#create'
  get 'association_show', to: 'associations#show'
  get 'association_edit', to: 'associations#edit'
  patch 'association_update', to: 'associations#update'
  delete 'association_destroy', to: 'associations#destroy'

  get 'download_csv', to: 'downloads#download_csv'
  get 'download_json', to: 'downloads#download_json'
  get 'download_xml', to: 'downloads#download_xml'
end
