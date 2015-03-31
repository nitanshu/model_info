module ModelInfo
  class ApplicationController < ActionController::Base
    private
    def models_tab
      array=[]
      ActiveRecord::Base.descendants.each do |x|
        array.push(x)
        @model_array=array
      end
      @model_array.delete(@model_array.last)
      @model_array
    end
  end
end
