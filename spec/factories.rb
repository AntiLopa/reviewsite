FactoryGirl.define do
  factory :user do
    name      "nir ben ezri"
    email     "nir@example.com"
    password  "nirnir"
    password_confirmation "nirnir"
    priv      "simple"
  end
end