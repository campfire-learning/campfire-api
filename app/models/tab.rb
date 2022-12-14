class Tab < ApplicationRecord
  include Discard::Model

  belongs_to :context, polymorphic: true

  before_create :set_order

  def set_order
    self.order = Tab.where(context_type: context_type, context_id: context_id).count
  end
end