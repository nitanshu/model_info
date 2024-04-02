# frozen_string_literal: true

module ModelInfo
  module Api
    module V1
      # :nodoc
      class BaseController < ::ApplicationController
        def models_array
          Rails.application.eager_load!
          model_names = ActiveRecord::Base.descendants.collect { |model| model.to_s if model.table_exists? }.compact
          model_names.delete('ActiveStorage::Blob')
          model_names.delete('ActiveStorage::Attachment')
          @model_array = model_names.map(&:pluralize).map(&:downcase)
        end
      end
    end
  end
end
