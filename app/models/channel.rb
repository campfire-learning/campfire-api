class Channel < ApplicationRecord
    include Discard::Model
  
    belongs_to :context, polymorphic: true
    enum context_type: { course: 'course', club: 'club', group: 'group' }
    
  end
  