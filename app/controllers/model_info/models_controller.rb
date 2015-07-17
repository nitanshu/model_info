require_dependency "model_info/application_controller"
module ModelInfo
  class ModelsController < ApplicationController
    before_action :models_tab

    def index
      redirect_to model_display_url(model_name: @model_array.first)
    end

    def display
      @model_name=params['model_name']
      @page= params['page']
      @model_pagination = @model_name.constantize.page(@page).per(10)
    end

    def new
      @model_class= params['model_new_data'].constantize
      @model_new_data = @model_class.new
    end

    def create
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
      end
      @model_class=params['model_class'].constantize
      @model_class.create(permit_params)
      @model_object_id=@model_class.last.id
      redirect_to model_show_path(resource: @model_class, data: @model_object_id)
    end

    def edit
      @resource=params['resource'].constantize
      @data=params['data']
      @models_data=@resource.find(@data)
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
      redirect_to model_show_path(resource: @model_class, data: @model_object_id)
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