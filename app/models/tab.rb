class Tab < ApplicationRecord
  include Discard::Model

  belongs_to :context, polymorphic: true

  has_many :pdf_tabs, as: :tab_entity, polymorphic: true
  has_many :rich_text_tabs, as: :tab_entity, polymorphic: true

  before_create :set_order

  def set_order
    self.order = Tab.where(context_type: context_type, context_id: context_id).count
  end
end