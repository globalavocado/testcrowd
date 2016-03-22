FactoryGirl.define do

  factory :user1, class: User do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'user1@example.com'
    password 'password123'
    password_confirmation 'password123'
    admin false
  end

  factory :user2, class: User do 
    email 'user2@example.com'
    password 'password246'
    password_confirmation 'password246'
    admin false
  end

  factory :admin1, class: User do
    email 'admin1@example.com'
    password 'password678'
    password_confirmation 'password678'
    admin true
  end

  factory :admin2, class: User do
    email 'admin2@example.com'
    password 'password789'
    password_confirmation 'password789'
    admin true
  end

end