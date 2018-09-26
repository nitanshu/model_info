module ModelInfo
  module AssociationsHelper
    def param_set
      {model_class: @model_class, model_object_id: @model_object_id, associated_model_class: @associated_model_class, associated_model_name: @associated_model_name}
    end
  end
end
