99.times do |i|
    User.create!(name: Faker::Name.name,
                email: "user.#{i}@mysampleapp.com",
                password: "12345678",
                password_confirmation: "12345678")
  end
  User.create!(name: "hoanguyen",
              email: "hoanguyen@mysampleapp.com",
              password: "12345678",
              password_confirmation: "12345678",
              admin: true)
