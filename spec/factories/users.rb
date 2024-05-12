FactoryBot.define do
  factory :user do
   sequence(:email) {|n| "name+#{n}@gmail.com"}
   password {"password"}
  end
end
