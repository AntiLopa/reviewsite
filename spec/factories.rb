FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
    sequence(:email) { |n| "Person_#{n}@example.com"}
    password  "nirnir"
    password_confirmation "nirnir"

    factory :admin do
      admin true
    end
  end
end