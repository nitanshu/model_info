module ModelInfo
  module Api
    module V1
      class ModelsController < BaseController
        before_action :find_model_object, only: %i[edit update show destory]

        def index
          render json: model.all
        end

        def create
          @model = model.new(permit_params)
          render json: @model.save
        end

        def update
          byebug
          @model.update(permit_params)
        end

        private
        def model
          @model = request.path.split('/').last.constantize
        end

        def permit_params
          params.require(:"#{model.to_s.downcase}").permit(model_attributes)
        end

        def model_attributes
          except ||= %w[id created_at updated_at]
          model.attribute_names.reject { |attr| except.include?(attr) }
        end

        def find_model_object
          @model = model.find()
        end
      end
    end
  end
end
