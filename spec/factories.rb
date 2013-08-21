FactoryGirl.define do
  factory :user do                #creates definition for User model object with below
    name      "Robin Helluva"
    email     "fake@email.com"
    password  "snakesonplane"
    password_confirmation "snakesonplane"
  end
end
