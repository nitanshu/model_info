module ModelInfo
  class ApplicationController < ActionController::Base
    private
    def models_tab
      array=[]
      ActiveRecord::Base.descendants.each do |x|
        array.push(x) if x.table_exists?
        @model_array=array
      end
    end
  end
end
