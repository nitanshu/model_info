require_dependency "model_info/application_controller"

module ModelInfo
  class ModelsController < ApplicationController
    before_action :models_tab
    before_action :fetch_model_name, only: [:create, :update]

    def index
      redirect_to model_display_url(model_class: @model_array.first)
    end

    def display
      @model_class, @page = params[:model_class], params[:page]
      @model_pagination = @model_class.constantize.page(@page).per(10)
    end

    def new
      @model_class = params[:model_class].constantize
      @model_data = @model_class.new
    end

    def create
      @model_class=params[:model_class].constantize
      @model_class.create(permit_params)
      if @model_class.last
        redirect_to model_show_path(model_class: @model_class, model_object_id: @model_class.last.id)
      else
        redirect_to :back
      end
    end

    def edit
      @model_class=params[:model_class].constantize
      @model_data=@model_class.find(params[:model_object_id])
    end

    def show
      @model_class=params[:model_class].constantize
      @model_data=@model_class.find(params[:model_object_id])
    end

    def update
      params[:model_class].constantize.find(params[@model_name][:id]).update(permit_params)
      redirect_to model_show_path(model_class: params[:model_class].constantize, model_object_id: params[@model_name][:id])
    end

    def destroy
      params[:model_class].constantize.find(params[:model_object_id]).destroy
      redirect_to :back
    end

    private

    def permit_params
      params.require(@model_name).permit!
    end
  end
end