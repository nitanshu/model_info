require_dependency "model_info/application_controller"
module ModelInfo
	class DownloadsController < ApplicationController
		before_filter :authenticate_request

		def download_csv
			csv_string = CSV.generate do |csv|
				csv << params[:model_class].constantize.column_names
				@model_data.each do |model|
					values = model.attributes.values
					csv.add_row values
				end
			end
			send_data csv_string,
			          :type => 'text/csv; charset=iso-8859-1; header=present',
			          :disposition => "attachment; filename=#{params[:model_class]}-#{DateTime.now}.csv"
		end

		def download_json
			send_data @model_data.to_json,
			          :type => 'text/json; charset=iso-8859-1; header=present',
			          :disposition => "attachment; filename=#{params[:model_class]}-#{DateTime.now}.json"
		end

		def download_xml
			send_data @model_data.to_xml,
			          :type => 'text/xml; charset=iso-8859-1; header=present',
			          :disposiftion => "attachment; filename=#{params[:model_class]}-#{DateTime.now}.xml"
		end

		private

		def authenticate_request
			if params[:associated_model]
				fetch_associated_model_data
			else
				fetch_model_data
			end
		end

		def fetch_model_data
			@model_data = params[:model_class].constantize.all
		end

		def fetch_associated_model_data
			@model_data = params[:model_class].constantize.find(params[:model_object_id]).send(params[:associated_model])
		end
	end
end