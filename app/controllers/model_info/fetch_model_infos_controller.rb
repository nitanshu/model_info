require_dependency "model_info/application_controller"

module ModelInfo
  class FetchModelInfosController < ApplicationController
    def index
      array=[]
      ActiveRecord::Base.descendants.each do |x|
        array.push(x)
        @model_array=array
      end
      @model_array.delete(@model_array.last)
      @model_array
    end

    def new
      @model_new_data = params['model_new_data'].constantize.new
    end

    def create
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
      end
      @model_class=@model_string.classify.constantize
      @model_class.create(permit_params)
      @model_object_id=@model_class.last.id
      redirect_to fetch_model_infos_show_path(resource: @model_class,data: @model_object_id)
    end

    def display
      @model_pagination = params['model_name'].constantize.page(params[:page]).per(10)
    end

    def edit
      @resource=params['resource'].constantize
      @data=params['data']
    end

    def show
      @resource=params['resource'].constantize
      @data=params['data']
      @model_data_resource=@resource.find(@data)
    end

    def update
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
      end
      @model_class=params['model_class'].constantize
      @model_object_id=params[@model_string]['id']
      @model_object=@model_class.find(@model_object_id)
      @model_object.update(permit_params)
      redirect_to fetch_model_infos_show_path(resource: @model_class, data: @model_object_id)
    end

    def destroy
      @resource=params['resource'].constantize
      @resource=@resource.find(params['data'])
      @resource.destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_string).permit!
    end
  end
end
