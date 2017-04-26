module TableUpload
  module Exporter
    class CSVExporter < ExporterBase
      class << self
        def export(klass)
          attributes = attribute_names(klass)
          csv_data = CSV.generate(headers: true) do |csv|
            csv << attributes
            klass.unscoped.all.each do |obj|
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
