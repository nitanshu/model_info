module ModelInfo
  module ApplicationHelper
    def model_column_names
      @model_class.constantize.column_names
    end

    def model_reflection_on_associations
      @model_class.constantize.reflect_on_all_associations
    end

    def model_name
      @model_class
    end

    def model_column_value(model_data, model_column_name)
      column_value = model_data.send(model_column_name.to_sym)
      column_value.class =='String' ? column_value.truncate(14) : column_value.to_s.truncate(14)
    end

    def actions(model_data)
      content_tag :td, class: 'model_action' do
        capture do
          concat link_to 'View', model_show_path(model_class: @model_class, model_object_id: model_data.id, page: @page), class: 'btn btn-info'
          concat link_to 'Edit', model_edit_path(model_class: @model_class, model_object_id: model_data.id), class: 'btn btn-warning'
          concat link_to 'Delete', model_destroy_path(model_class: @model_class, model_object_id: model_data.id), method: :delete, data: {confirm: 'Are you sure?'}, class: 'btn btn-danger'
        end
      end
    end

    def download_actions
      content_tag :div, class: 'downloads' do
        capture do
          concat 'Download: '
          concat link_to 'CSV', download_csv_path(model_class: @model_class), format: :csv
          concat ' '
          concat link_to 'JSON', download_json_path(model_class: @model_class), format: :json
          concat ' '
          concat link_to 'XML', download_xml_path(model_class: @model_class), format: :xml
        end
      end
    end

    def associations_hash
      active_record_name=[], klass_name=[]
      model_reflection_on_associations.each do |reflection|
        reflection.options[:polymorphic] ? active_record_name.push(reflection.active_record.name) : klass_name.push(reflection.klass.name)
      end
      model_reflection_on_associations.map { |x| [x.name, x.macro] }.zip(active_record_name+klass_name).inject({}) { |h, e| h[e.first] = e.last; h }
    end
  end
end
