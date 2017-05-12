module TableUpload
  module Exporter
    class CSVExporter < ExporterBase
      class << self
        def export(table_setting)
          klass = table_setting.klass
          attributes = attribute_names(table_setting)
          csv_data = CSV.generate(headers: true) do |csv|
            csv << attributes
            klass.unscoped.all.order(id: :asc).each do |obj|
              csv << attributes.map { |attr| obj.send(attr) }
            end
          end

          File.open(TableUpload.export_dir.join("#{klass.to_s.downcase}.csv"), 'w') do |file|
            file.write(csv_data)
          end
        end
      end
    end
  end
end
