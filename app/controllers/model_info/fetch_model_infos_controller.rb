require_dependency "model_info/application_controller"

module ModelInfo
  class FetchModelInfosController < ApplicationController
    def index
      array=[]
      ActiveRecord::Base.descendants.each do |x|
        array.push(x)
        @model_array=array
      end
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
      @model_class=@model_string.classify.constantize
      @model_object_id=params[@model_string]['id']
      @model_object=@model_class.find(@model_object_id)
      @model_object.update(permit_params)
      redirect_to fet
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
