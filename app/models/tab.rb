class Tab < ApplicationRecord
  include Discard::Model

  belongs_to :context, polymorphic: true
  enum context_type: { course: 'course', club: 'club' }

  belongs_to :tab_context, polymorphic: true
  enum tab_context_type: { rich_text_tab: 'rich_text_tab', pdf_tab: 'pdf_tab'}

  before_create :set_order

  def set_order
    self.order = Tab.where(context_type: context_type, context_id: context_id).count
  end
end