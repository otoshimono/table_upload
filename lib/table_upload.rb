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
      exec_upload(all_table_classes.map{|klass| TableUpload.to_table_setting(klass)})
    end

    def exec_upload(table_settings)
      table_settings.each do |table_setting|
        exporter.export(table_setting)
        uploader.instance.upload(table_setting.klass.to_s.downcase)
      end
    end

    def all_table_classes
      Rails.application.eager_load!
      ActiveRecord::Base.descendants
    end

    def set_default
      self.google_drive_session_config = "config.json"
      self.exporter = Exporter::CSVExporter
      self.uploader = Uploader::SpreadsheetUploader
    end

    TableSetting = Struct.new(:klass, :option)
    def to_table_setting(klass, option = {})
      TableSetting.new(klass, option)
    end
  end
end