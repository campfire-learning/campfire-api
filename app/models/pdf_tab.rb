class PdfTab < ApplicationRecord  
    has_one_attached :pdf
    has_one :tab
  end
  