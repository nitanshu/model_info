module ModelInfo
  class ApplicationController < ActionController::Base

    private
    def models_tab
      array=[], @model_array=[]
      Rails.application.eager_load!
      array=ActiveRecord::Base.descendants.collect{|x| x.to_s if x.table_exists?}.compact
      array.each do |x|
        if  x.split('::').last.split('_').first != "HABTM"
          @model_array.push(x)
        end
        @model_array.delete('ActiveRecord::SchemaMigration')
      end
    end
  end
end
