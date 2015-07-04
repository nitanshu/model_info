require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :models_tab

    def new

    end

    def index
      @model_class,@model_object_id,@relational_model,@relational_model_class,@macro=params['model_class'].constantize,params['model_object_id'],params['relational_model'], params['relational_model_class'].constantize, params['macro']
      @models_data=@model_class.find(@model_object_id)
      @relational_data=@models_data.send(@relational_model)
      logger.info "#{@relational_data.inspect}=========="
      @macro == "has_one" || @macro == "belongs_to" ? @relational_model_pagination = 1 : @relational_model_pagination=@relational_data.page(params[:page]).per(10)
    end

    def create
      @macro,@model_object_id,@relational_model_class=params['macro'],params['model_object_id'],params['relation_model_class']
      if @macro ='has_one'||'belongs_to'

      else

      end
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
      @single_relational_data=@relational_model_class.find(@model_object_id)
      @single_relational_data.destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_string).permit!
    end
  end
end
