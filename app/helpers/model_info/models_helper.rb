module ModelInfo
  module ModelsHelper
    def model_download_actions
      content_tag :div, class: 'model_downloads' do
        capture do
          concat 'Download: '
          concat link_to 'CSV', download_csv_path(model_class: @model_class), format: :csv
          concat ' '
          concat link_to 'JSON', download_json_path(model_class: @model_class), format: :json
        end
      end
    end
  end
end