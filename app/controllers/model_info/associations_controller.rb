require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :fetch_model_class

    def new
      @model_data=params[:model_class].constantize.find(params[:model_object_id])
      @associated_data=@model_data.send(params[:associated_model]).build
    end

    def index
      @model_class, @model_object_id, @associated_model, @associated_model_class, @macro, @page = params[:model_class].constantize, params[:model_object_id], params[:associated_model], params[:associated_model_class].constantize, params[:macro], params[:page]
      @models_data=@model_class.find(params[:model_object_id])
      @associated_data=@models_data.send(@associated_model)
      @macro == 'has_one' || @macro == 'belongs_to' ? @associated_model_pagination = 1 : @associated_model_pagination = @associated_data.page(params[:page]).per(10)
    end

    def create
      @associated_data=params[:model_class].constantize.find(params[:model_object_id]).send(params[:associated_model]).create(permit_params)
      redirect_to association_show_path(associated_model_class: params[:associated_model_class].constantize, data: @associated_data.id)
    end

    def show
      @associated_model_class=params[:associated_model_class].constantize
      @single_associated_data=@associated_model_class.find(params[:data])
    end

    def edit
      @single_associated_data=params[:associated_model_class].constantize.find(params[:data])
    end

    def update
      params[:associated_model_class].constantize.find(params[:data]).update(permit_params)
      redirect_to association_show_path(associated_model_class: params[:associated_model_class].constantize, data: params[:data])
    end

    def destroy
      params[:associated_model_class].constantize.find(params[:data]).destroy
      redirect_to :back
    end

    private
    def permit_params
      params.require(@model_name).permit!
    end
  end
end
