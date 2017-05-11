module TableUpload
  module Exporter
    class ExporterBase
      class << self
        def export_all
          all_table_classes.each do |model|
            export(model)
          end
        end

        def export(table_class)
          raise "Please Define #export method!!"
        end

        def attribute_names(table_setting)
          table_setting.klass.new.attributes.keys - table_setting.option[:skip_columns].to_a.map(&:to_s)
        end

      end
    end
  end
end
