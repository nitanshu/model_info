require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :models_tab

    def new
      @model_class,@model_object_id,@associated_model,@associated_model_class=params['model_class'].constantize,params['model_object_id'],params['associated_model'],params['associated_model_class']
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model).build
    end

    def index
      @model_class,@model_object_id,@associated_model,@associated_model_class,@macro=params['model_class'].constantize,params['model_object_id'],params['associated_model'], params['associated_model_class'].constantize, params['macro']
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model)
      @macro == "has_one" || @macro == "belongs_to" ? @associated_model_pagination = 1 : @associated_model_pagination = @associated_data.page(params[:page]).per(10)
    end

    def create
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
      end
      @model_object_id,@model_class,@associated_model, @associated_model_class=params[:model_object_id],params[:model_class].constantize,params['associated_model'], params['associated_model_class'].constantize
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model).create(permit_params)
      redirect_to association_show_path(model_class: @model_class, model_object_id: @model_object_id,associated_model: @associated_model,associated_model_class: @associated_model_class, data: @associated_data.id)
    end

    def show
      @model_class,@model_object_id,@associated_model,@data,@associated_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['associated_model'],params['data'],params['associated_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model)
      @single_associated_data=@associated_model_class.find(@data)
    end

    def edit
      @model_class,@model_object_id,@associated_model,@data,@associated_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['associated_model'],params['data'],params['associated_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model)
      @single_associated_data=@associated_model_class.find(@data)
    end

    def update
      @model_class,@model_object_id,@associated_model,@associated_model_class,@data=params['model_class'].constantize,params['model_object_id'],params['associated_model'], params['associated_model_class'].constantize,params['data']
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model)
      @single_associated_data=@associated_model_class.find(@data)
      @model_string=@associated_model.singularize
      @single_associated_data.update(permit_params)
      redirect_to association_show_path(:model_class => @model_class,model_object_id: @model_object_id,associated_model: @associated_model, associated_model_class: @associated_model_class,data: @data)
    end

    def destroy
      @model_class,@model_object_id,@associated_model,@associated_model_class,@data=params['model_class'].constantize,params['model_object_id'],params['associated_model'],params['associated_model_class'].constantize,params['data']
      @models_data=@model_class.find(@model_object_id)
      @associated_data=@models_data.send(@associated_model)
      @single_associated_data=@associated_model_class.find(@data)
      @single_associated_data.destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_string).permit!
    end
  end
end
