# frozen_string_literal: true

return unless Rails.env.development?

User.destroy_all

# Admin user account
tech_admin = User.create(email: 'tech@amgrade.com', password: 'password', role: User::ROLES[:admin])
tech_admin.create_profile(
  first_name: 'Admin',
  last_name:  'Tech',
  gender:     Profile::GENDERS[:male],
  position:   'Axis Admin',
  gmail:      'docs.amgrade@gmail.com',
  skype:      'tech.amgrade',
  phone1:     '+38(068)2862186',
  birthday:   '1980-09-03',
  trial_at:   '2018-01-01'
)
puts '=> Tech Admin user created'

# 25 ramdom fake users
position = ['Backend Developer', 'Frontend Developer', 'iOS Developer', 'Android Developer', 'Recruiter']
25.times do
  fl_name  = [Faker::Name.first_name, Faker::Name.first_name]
  username = fl_name.join('.')
  profile  = {
    first_name: fl_name[0],
    last_name:  fl_name[1],
    gender:     Profile::GENDERS.values[rand(Profile::GENDERS.values.size)],
    position:   position.sample,
    gmail:      "#{username}@gmail.com",
    skype:      "live:#{username}",
    phone1:     Faker::PhoneNumber.phone_number,
    birthday:   Faker::Date.birthday,
    trial_at:   Date.today
  }

  user = User.create(email: Faker::Internet.safe_email(username), password: 'password', role: User::ROLES[:user])
  user.create_profile(profile)

  puts "=> User '#{user.email}' created"
end
