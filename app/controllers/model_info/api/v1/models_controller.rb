module ModelInfo
  module Api
    module V1
      # :nodoc
      class ModelsController < BaseController
        before_action :find_model_object, only: %i[edit update show destroy]

        # GET /models or /models.json
        def index
          render json: model.all
        end

        # GET /comapnies/new
        def show
          render json: @model_object
        end

        def create
          model_object = model.new(permit_params)
          if model_object.save
            render json: { status: :created }
          end
        end

        def update
          @model_object.update(permit_params)
        end

        def destroy
          @model_object.destroy
        end

        private

        def model
          model = request.path.split('/').select { |element| models_array.include?(element) }.first
          @model = model.classify.constantize
        end

        # Only allow a list of trusted parameters through.
        def permit_params
          params.require(:"#{model.to_s.downcase}").permit(model_attributes)
        end

        def model_attributes
          except ||= %w[id created_at updated_at]
          model.attribute_names.reject { |attr| except.include?(attr) }
        end

        # Use callbacks to share common setup or constraints between actions.
        def find_model_object
          @model_object = model.find(params[:id])
        end
      end
    end
  end
end
