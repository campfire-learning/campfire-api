FactoryBot.define do
  factory :like do
    user_id { 1 }
    likable_id { 1 }
    likable_type { "MyString" }
  end
end
