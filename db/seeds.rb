# frozen_string_literal: true

# Admin user account
User.create(email: 'tech@amgrade.com', password: 'password', role: User::ROLES[:admin]) do |user|
  user.create_profile(
    first_name: 'Tech',
    last_name: 'Admin',
    gender: Profile::GENDERS[:male],
    position: 'Axis Admin'
  )
end

if Rails.env.development?
  # 25 random users
  25.times do
    # generate email and name
    fname = Hash[%i[first_name middle_name last_name].zip(Faker::Name.name_with_middle.split(/\s+/, 3))]
    email = Faker::Internet.unique.email(fname.values.join('.'))
    position = ['Backend Developer', 'Frontend Developer', 'iOS Developer', 'Android Developer'].sample

    # create user
    User.create(email: email, password: 'password', role: User::ROLES[:user]) do |user|
      # create associated profile
      user.create_profile(fname.merge(
                            gender: Profile::GENDERS.values[rand(Profile::GENDERS.values.size)],
                            position: position,
                            skype: fname.values.join('.'),
                            gmail: "#{fname.values.join('.')}@gmail.com"
      ))
    end
  end
end
