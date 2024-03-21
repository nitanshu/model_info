# frozen_string_literal: true

module ModelInfo
  module Api
    module V1
      # :nodoc
      class BaseController < ::ApplicationController
        before_action :models

        private

        def models
          @model_array = []
          Rails.application.eager_load!
          model_names = ActiveRecord::Base.descendants.collect { |model| model.to_s if model.table_exists? }.compact
          model_names.each do |model_name|
            @model_array.push(model_name) if model_name.split('::').last.split('_').first != 'HABTM'
            @model_array.delete('ActiveRecord::SchemaMigration')
            $model_array = @model_array
          end
        end
      end
    end
  end
end
