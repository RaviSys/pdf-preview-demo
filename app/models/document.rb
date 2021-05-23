class Document < ApplicationRecord
  validates :title, :description, presence: true
  # Active storage attachments
  has_one_attached :doc_file
  has_many_attached :doc_file_pages

end
