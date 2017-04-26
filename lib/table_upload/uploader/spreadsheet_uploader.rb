module TableUpload
  module Uploader
    class SpreadsheetUploader
      include Singleton

      attr_accessor :session, :folder

      def initialize
        self.session     = GoogleDrive::Session.from_config(TableUpload.google_drive_session_config)
        self.folder      = session.collection_by_title(TableUpload.google_drive_dir)
      end

      def upload(name)

        # パスを取得
        file_name = "#{name}.csv"
        path = TableUpload.export_dir.join(file_name)

        # 既存ファイルを削除
        file = folder.file_by_title(file_name)
        folder.remove(file)

        # 再作成
        file = session.upload_from_file(path.to_s, file_name)
        folder.add(file)

      end
    end
  end
end
