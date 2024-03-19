module ModelInfo
  class ApplicationController < ::ApplicationController
    #========================= Example =================================#
    # class Employee < ApplicationRecord
    #  has_many :projects
    # end
    #============================ Naming Conventions ====================#
    # model_class 'Employee'
    # model_name 'employee'
    # model_object_id '1'
    # model_data '#<Employee id: 1, name: "Alen", salary: 10000, month: "Jan",manager_id: 8, lock_version: 4>'
    # associated_model_class 'Project'
    # associated_model_name 'projects'
    # associated_model_object_id '1'
    # associated_model_data '#<Project id: nil, name: nil, employee_id: 1, created_at: nil, updated_at: nil, properties: nil>'

    before_action :models_tab

    private

    def models_tab
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
