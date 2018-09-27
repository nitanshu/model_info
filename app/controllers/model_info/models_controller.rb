require_dependency 'model_info/application_controller'

module ModelInfo
  class ModelsController < ApplicationController
    before_action :model_class_and_name
    before_action :set_model_data, only: [:show, :edit, :update]

    def display
      @model_class, @page = params[:model_class] || @model_array.try(:first), params[:page] || 1
      @model_pagination = @model_class.constantize.page(@page).per(10)
    end

    def new
      @model_data = @model_class.new
    end

    def create
      @model_data = @model_class.new(permit_params)
      if @model_data.save
        redirect_to model_show_path(model_class: @model_class, model_object_id: @model_data.id)
      else
        flash[:error] = @model_data.errors.full_messages
        redirect_back(fallback_location: request.referrer)
      end
    end

    def edit
    end

    def show
    end

    def update
      if @model_data.update(permit_params)
        redirect_to model_show_path(model_class: @model_class, model_object_id: @model_data.id)
      else
        flash[:error] = @model_data.errors.full_messages
        redirect_back(fallback_location: request.referrer)
      end
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

    def set_model_data
      @model_data=@model_class.find(params[:model_object_id])
    end
  end
end