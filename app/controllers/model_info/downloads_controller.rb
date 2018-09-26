require_dependency "model_info/application_controller"
module ModelInfo
  class DownloadsController < ApplicationController
    before_action :set_model_instance
    before_action :authenticate_request

    def download_csv
      csv_string = CSV.generate do |csv|
        csv << model_attributes
        @model_data.each do |model|
          values = model.attributes.values
          csv.add_row values
        end
      end
      send_data csv_string,
                :type => 'text/csv; charset=iso-8859-1; header=present',
                :disposition => "attachment; filename=#{@model_name}-#{DateTime.now}.csv"
    end

    def download_json
      send_data @model_data.to_json,
                :type => 'text/json; charset=iso-8859-1; header=present',
                :disposition => "attachment; filename=#{@model_name}-#{DateTime.now}.json"
    end

    def download_xml
      send_data @model_data.to_xml,
                :type => 'text/xml; charset=iso-8859-1; header=present',
                :disposiftion => "attachment; filename=#{@model_name}-#{DateTime.now}.xml"
    end

    private

    def set_model_instance
      @model_class = params[:model_class].try(:constantize)
      @model_name = @model_class.to_s.downcase
    end

    def authenticate_request
      if params[:associated_model_name]
        fetch_associated_model_data
      else
        fetch_model_data
      end
    end

    def fetch_model_data
      @model_data = @model_class.all
    end

    def fetch_associated_model_data
      @model_data = @model_class.find(params[:model_object_id]).send(params[:associated_model_name])
    end
  end
end