class PdfTab < ApplicationRecord  
    has_one_attached :pdf
    belongs_to :tab
  end
  