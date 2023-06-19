class Assignment < ApplicationRecord
  belongs_to :course
  has_many_attached :uploads

  enum assignment_type: { homework: 'homework', quiz: 'quiz', exam: 'exam' }
  enum submission_type: { online: 'online', offline: 'offline' }
  enum grade_type: { numeric: 'numeric', passing: 'passing', letter: 'letter' }

  def uploads_data
    uploads.map do |upload|
      {
        name: upload.blob.filename.to_s,
        url: Rails.application.routes.url_helpers.url_for(upload)
      }
    end
  end
end
