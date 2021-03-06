require_dependency "model_info/application_controller"

module ModelInfo
  class AssociationsController < ApplicationController
    before_action :set_variables_in_session, only: [:index]
    before_action :set_instance_variables
    before_action :set_associated_model_data, only: [:show, :edit, :update]

    def new
      @associated_model_data = @model_data.send(@associated_model_name).build
    end

    def index
      @macro, @page = params[:macro], params[:page]
      @associated_model_data = @model_data.send(@associated_model_name)
      if @macro == 'has_one' || @macro == 'belongs_to'
        @associated_model_pagination = 1
      else
        @associated_model_pagination = @associated_model_data.page(params[:page]).per(10)
      end
    end

    def create
      @associated_model_data = @model_data.send(@associated_model_name).build(permit_params)
      if @associated_model_data.save
        redirect_to association_show_path(associated_model_object_id: @associated_model_data.id)
      else
        flash[:error] = @associated_model_data.errors.full_messages
        redirect_back(fallback_location: request.referrer)
      end
    end

    def show
    end

    def edit
    end

    def update
      if @associated_model_data.update(permit_params)
        redirect_to association_show_path(associated_model_object_id: params[:associated_model_object_id])
      else
        flash[:error] = @associated_model_data.errors.full_messages
        redirect_back(fallback_location: request.referrer)
      end
    end

    def destroy
      @associated_model_class.find(params[:associated_model_object_id]).destroy
      redirect_back(fallback_location: request.referrer)
    end

    private
    def set_variables_in_session
      session['param_set'] =
        {
          model_class: params[:model_class],
          model_object_id: params[:model_object_id],
          associated_model_class: params[:associated_model_class],
          associated_model_name: params[:associated_model_name]
        }
    end

    def set_instance_variables
      @model_class = (session[:param_set][:model_class] || session['param_set']['model_class']).constantize
      @model_name = @model_class.to_s.downcase
      @model_object_id = session[:param_set][:model_object_id] || session['param_set']['model_object_id']
      @model_data = @model_class.find(@model_object_id)
      @associated_model_class = (session[:param_set][:associated_model_class] || session['param_set']['associated_model_class']).constantize
      @associated_model_name = session[:param_set][:associated_model_name] || session['param_set']['associated_model_name']
    end

    def set_associated_model_data
      @associated_model_data = @associated_model_class.find(params[:associated_model_object_id])
    end

    def permit_params
      params.require(@associated_model_class.to_s.downcase).permit!
    end
  end
end
