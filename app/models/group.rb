class Group < ApplicationRecord
  belongs_to :creator
  belongs_to :owner
end
