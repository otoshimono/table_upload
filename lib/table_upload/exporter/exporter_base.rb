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

        def attribute_names(klass)
          klass.new.attributes.keys
        end

      end
    end
  end
end
