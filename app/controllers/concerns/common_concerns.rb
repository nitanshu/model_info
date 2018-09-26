module MainConcern
  extend ActiveSupport::Concern
  def model_attributes
    @model_class.constantize.column_names
  end
end
