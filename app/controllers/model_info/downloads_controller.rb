require_dependency "model_info/application_controller"
require 'csv'
module ModelInfo
	class DownloadsController < ApplicationController
		before_action :fetch_model_data

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
			          :disposition => "attachment; filename=#{params[:model_class]}-#{DateTime.now}.xml"
		end

		def download_excel
		end

		private
		def fetch_model_data
			@model_data = params[:model_class].constantize.all
		end
	end
end