require 'table_upload/exporter/exporter_base'
require 'table_upload/exporter/csv_exporter'
require 'table_upload/uploader/spreadsheet_uploader'

module TableUpload

  mattr_accessor :google_drive_session_config, :google_drive_dir, :exporter, :uploader, :export_dir

  class << self

    def setup
      set_default
      yield self
    end

    def exec_upload_all
      exec_upload(all_table_classes)
    end

    def exec_upload(table_classes)
      table_classes.each do |klass|
        exporter.export(klass)
        uploader.instance.upload(klass.to_s.downcase)
      end
    end

    def all_table_classes
      Rails.application.eager_load!
      ActiveRecord::Base.descendants
    end

    def set_default
      self.google_drive_session_config = "spread_sheet_key.json"
      self.exporter = Exporter::CSVExporter
      self.uploader = Uploader::SpreadsheetUploader
    end
  end
end