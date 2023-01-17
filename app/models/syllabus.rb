class Syllabus < ApplicationRecord
  belongs_to :course

  has_many_attached :uploads

  def uploads_data
    uploads.map do |upload|
      {
        name: upload.blob.filename.to_s,
        url: Rails.application.routes.url_helpers.url_for(upload)
      }
    end
  end
end
