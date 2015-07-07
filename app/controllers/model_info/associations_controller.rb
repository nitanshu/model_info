require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :models_tab

    def new
      @model_class,@model_object_id,@relational_model,@relational_model_class=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['relational_model_class']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model).build
    end

    def index
      @model_class,@model_object_id,@relational_model,@relational_model_class,@macro=params['model_class'].constantize,params['model_object_id'],params['relational_model'], params['relational_model_class'].constantize, params['macro']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @macro == "has_one" || @macro == "belongs_to" ? @relational_model_pagination = 1 : @relational_model_pagination=@relational_data.page(params[:page]).per(10)
    end

    def create
      params.each do |k, v|
        @model_string= k.to_s if params[k].is_a?(Hash)
      end
      @model_object_id,@model_class,@relational_model, @relational_model_class=params[:model_object_id],params[:model_class].constantize,params['relational_model'], params['relational_model_class'].constantize
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model).create(permit_params)
      redirect_to associations_show_path(model_class: @model_class, model_object_id: @model_object_id,relational_model: @relational_model,relational_model_class: @relational_model_class, data: @relational_data.id)
    end

    def show
      @model_class,@model_object_id,@relational_model,@data,@relational_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['data'],params['relational_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_model_class.find(@data)
    end

    def edit
      @model_class,@model_object_id,@relational_model,@data,@relational_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['data'],params['relational_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_model_class.find(@data)
    end

    def update
      @model_class,@model_object_id,@relational_model,@relational_model_class,@data=params['model_class'].constantize,params['model_object_id'],params['relational_model'], params['relational_model_class'].constantize,params['data']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_model_class.find(@data)
      @model_string=@relational_model.singularize
      @single_relational_data.update(permit_params)
      redirect_to associations_show_path(:model_class => @model_class,model_object_id: @model_object_id,relational_model: @relational_model, relational_model_class: @relational_model_class,data: @data)
    end

    def destroy
      @model_class,@model_object_id,@relational_model,@relational_model_class,@data=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['relational_model_class'].constantize,params['data']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_model_class.find(@data)
      @single_relational_data.destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_string).permit!
    end
  end
end
