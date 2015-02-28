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

    def display

    end

    def edit
      @resource=params['resource'].constantize
      @data=params['data']
    end

    def show
      @resource=params['resource'].constantize
      @data=params['data']
    end

    def update
      arry=[]
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
        arry.push(v) if params[k].is_a?(Hash)
      end
      @model_class=params['model_class'].constantize
      @model_object_id=params[@model_string]['id']
      @model_object=@model_class.find(@model_object_id)
      @model_object.update(permit_params)
      redirect_to fetch_model_infos_show_path(resource: @model_class)
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
