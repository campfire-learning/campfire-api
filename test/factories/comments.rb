FactoryBot.define do
  factory :comment do
    comment_text { "MyString" }
    creator_id { 1 }
    context_type { "MyString" }
    context_id { 1 }
  end
end
