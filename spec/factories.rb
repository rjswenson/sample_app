###-For ONE User to be created-###
#FactoryGirl.define do               #default when I call for a factorygirl creation
#  factory :user do                  #creates definition for User model object with below
#    name      "Robin Helluva"
#    email     "fake@email.com"
#    password  "snakesonplane"
#    password_confirmation "snakesonplane"
#  end
#end

###-For a SEQUENCE of Users to be created-###
FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Bobby Mr. #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  
    factory :admin do       #if FactoryGirl.create(:admin) called
      admin true
    end
  end

  factory :micropost do
    content "Generic micropost text here."
    user
  end
end
