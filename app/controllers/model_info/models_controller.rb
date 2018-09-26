require_dependency "model_info/application_controller"

module ModelInfo
  class ModelsController < ApplicationController
    before_action :model_class_and_name

    def display
      @model_class, @page = params[:model_class] || @model_array.try(:first), params[:page] || 1
      @model_pagination = @model_class.constantize.page(@page).per(10)
    end

    def new
      @model_data = @model_class.new
    end

    def create
      @model_data =  @model_class.new(permit_params)
      if @model_data.save
        redirect_to model_show_path(model_class: @model_class, model_object_id: @model_class.last.id)
      else
        redirect_back(fallback_location: request.referrer)
      end
    end

    def edit
      @model_data=@model_class.find(params[:model_object_id])
    end

    def show
      @model_data=@model_class.find(params[:model_object_id])
    end

    def update
      @model_class.find(params[@model_name][:id]).update(permit_params)
      redirect_to model_show_path(model_class: @model_class, model_object_id: params[@model_name][:id])
    end

    def destroy
      @model_class.find(params[:model_object_id]).destroy
      redirect_back(fallback_location: request.referrer)
    end

    private

    def permit_params
      params.require(@model_name).permit!
    end

    def model_class_and_name
      @model_class = params[:model_class].try(:constantize)
      @model_name = @model_class.to_s.downcase
    end
  end
end