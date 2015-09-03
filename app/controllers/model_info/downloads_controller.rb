require_dependency "model_info/application_controller"
require 'csv'
module ModelInfo
	class DownloadsController < ApplicationController

		def download_csv
			@model_data = params[:model_class].constantize.all
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

		end

		def download_pdf

		end

		def download_xml

		end

		def download_excel

		end
	end
end