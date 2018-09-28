module ModelInfo
  module AssociationsHelper

    def associated_model_column_names
      @associated_model_class.column_names
    end

    def association_download_param
      {
        associated_model_name: @associated_model_name,
        model_class: @model_class,
        model_object_id: @model_object_id
      }
    end

    def association_actions(associated_model_data)
      content_tag :td do
        concat link_to 'View',
                       association_show_path(page: @page, associated_model_object_id: associated_model_data),
                       class: 'btn btn-info'
        concat ' '
        concat link_to 'Edit',
                       association_edit_path(associated_model_object_id: associated_model_data),
                       class: 'btn btn-warning'
        concat ' '
        concat link_to 'Delete',
                       association_destroy_path(associated_model_object_id: associated_model_data),
                       method: :delete,
                       data: {confirm: 'Are you sure?'},
                       class: 'btn btn-danger'
      end
    end

    def association_download_actions
      if @associated_model_class.any?
        content_tag :div, class: 'association_downloads' do
          capture do
            concat 'Download Associated Model Data: '
            concat link_to 'CSV', download_csv_path(association_download_param), format: :csv
            concat ' '
            concat link_to 'JSON', download_json_path(association_download_param), format: :json
          end
        end
      end
    end
  end
end
