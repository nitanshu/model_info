require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :models_tab

    def new
    end

    def index
     @model_class,@model_object_id,@relational_model,@relational_class =params['model_class'].constantize,params['model_object_id'],params['relational_model'], params[:relational_class].constantize
     @models_data=@model_class.find(@model_object_id)
     @relational_data=@models_data.send(@relational_model)
     @relational_model_pagination=@relational_class.page(params[:page]).per(10)
    end

    def create
    end

    def show
      @model_class,@model_object_id,@relational_model,@data,@relational_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['data'],params['relational_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_data.find(@data)
    end

    def edit
      @model_class,@model_object_id,@relational_model,@data,@relational_model_class,@page=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['data'],params['relational_model_class'].constantize,params[:page]
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_data.find(@data)
    end

    def update
      @model_class,@model_object_id,@relational_model,@data=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['data']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_data.find(@data)
      @model_string=@relational_model.singularize
      @single_relational_data.update(permit_params)
      redirect_to associations_show_path(:model_class => @model_class,model_object_id: @model_object_id,relational_model: @relational_model, data: @data)
    end

    def destroy
      @model_class,@model_object_id,@relational_model,@relational_model_class,@data=params['model_class'].constantize,params['model_object_id'],params['relational_model'],params['relational_model_class'],params['data']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      @single_relational_data=@relational_data.find(@data)
      @single_relational_data.destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_string).permit!
    end
  end
end
