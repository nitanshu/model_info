module ModelInfo
  class ApplicationController < ::ApplicationController
    before_action :models_tab

    private
    def models_tab
      array=[], @model_array=[]
      Rails.application.eager_load!
      array=ActiveRecord::Base.descendants.collect { |x| x.to_s if x.table_exists? }.compact
      array.each do |x|
        if x.split('::').last.split('_').first != "HABTM"
          @model_array.push(x)
        end
        @model_array.delete('ActiveRecord::SchemaMigration')
      end
    end

    def fetch_model_class
      @model_class = params[:model_class].try(:constantize)
      @model_name = @model_class.to_s.downcase
    end
  end
end
