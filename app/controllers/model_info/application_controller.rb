module ModelInfo
  class ApplicationController < ::ApplicationController
    #========================= Example =================================#
    #class Employee < ApplicationRecord
    #  has_many :projects
    #end
    #============================ Naming Conventions ====================#
    # model_class 'Employee'
    # model_name 'employee'
    # model_object_id '1'
    # model_data '#<Employee id: 1, name: "rooh", salary: 138001, month: "jan", created_at: "2018-08-29 07:47:43", updated_at: "2018-09-12 09:35:09", manager_id: 8, lock_version: 4>'
    # associated_model_class 'Project'
    # associated_model_name 'projects'
    # associated_model_object_id '1'
    # associated_model_data '#<Project id: nil, name: nil, employee_id: 1, created_at: nil, updated_at: nil, properties: nil>'

    before_action :models_tab

    private
    def models_tab
      array=[], @model_array=[]
      Rails.application.eager_load!
      array=ActiveRecord::Base.descendants.collect { |x| x.to_s if x.table_exists? }.compact
      array.each do |x|
        if x.split('::').last.split('_').first != 'HABTM'
          @model_array.push(x)
        end
        @model_array.delete('ActiveRecord::SchemaMigration')
      end
    end
  end
end
