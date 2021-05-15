class Document < ApplicationRecord
  validates :title, :description, presence: true
  # Active storage attachments
  has_one_attached :doc_file
  has_many_attached :doc_file_pages

  def convert_pdf_to_image
    document = self
    # path to current doc_file
    doc_path = ActiveStorage::Blob.service.send(:path_for, document.doc_file.key)
    # set minimagick image wrapper for pdf stored in @doc.uplaod
    magick = MiniMagick::Image.open(doc_path)
    magick.pages.each_with_index do |page, index|
      file_name = "page_#{(index+1).to_s}"
      # set path for tempfile that you are about to create (using rails post ruby 2.5 approach. Pre 2.5 ruby uses make_tmpname; post 2.5 ruby uses create; I like rails post 2.5 version)
      converted_file_path = File.join(Dir.tmpdir, "#{file_name}-#{Time.now.strftime("%Y%m%d")}-#{$$}-#{rand(0x100000000).to_s(36)}-.png")
      # create png and save to tempfile path
      MiniMagick::Tool::Convert.new do |convert|
        # prep format
        convert.background "white"
        convert.flatten
        convert.density 300
        convert.quality 100
        # add page to be converted,./
        convert << page.path
        # add path of page to be converted
        convert << converted_file_path
      end
      document.doc_file_pages.attach(io: File.open(converted_file_path), filename: file_name, content_type: "image/png")
    end
  end

end
