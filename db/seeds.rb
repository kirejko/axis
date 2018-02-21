# frozen_string_literal: true

# Clean-up departments
Department.destroy_all

# Seed default departments. However departments can be managed.
puts '=> Creating default departments'
{
  backend_development:    'Consists of PHP, Ruby and Python developers. They do all the invisible magick.',
  frontend_development:   'JavaScript Ninjas. They tend to do all the beauty and interactive things.',
  mobile_development:     'Wanna get a cool app on your gadget? Easy bro!',
  quality_assurance:      'These guys will not let you fail. They will hunt every single line of your code.',
  project_management:     'Those who keep the order of things ... and cakes to developers :)',
  business_development:   'They would sell a breath to you, even when you can breath yourself',
  servers_administration: 'Well, when they play Warcraft all the day long, you can be sure everything is fine',
  rescruitment:           'HRs... they are merciless headhunters. But they bring smiles to all of us every day',
  financial:              'Where is my paychek?! Better do not anger them, or your paycheck will go to /dev/null :)'
}.each_entry do |name, description|
  Department.create(name: name.to_s.titleize, description: description)
  puts "-> Department '#{name}' created with descritpion '#{description}'"
end

# Clean-up users table
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
  birthday:   '1980-09-03'
)
puts '=> Tech Admin user created'
puts '-' * 60
puts '| Use "tech@amgrade.com" with "password" to log in with it |'
puts '-' * 60

# Below are seeders for local development only
return unless Rails.env.development?

ActiveRecord::Base.transaction do
  # 25 ramdom fake users
  position = ['Laravel/Rails Developer', 'React Developer', 'HTML Coder', 'iOS Developer', 'Android Developer', 'Recruiter']
  25.times do
    fl_name  = [Faker::Name.first_name, Faker::Name.first_name]
    username = fl_name.join('.')

    trial_at = Faker::Date.between([*1..5].sample.years.ago, Date.today)

    profile  = {
      first_name: fl_name[0],
      last_name:  fl_name[1],
      gender:     Profile::GENDERS.values[rand(Profile::GENDERS.values.size)],
      position:   position.sample,
      gmail:      "#{username}@gmail.com",
      skype:      "live:#{username}",
      phone1:     Faker::PhoneNumber.phone_number,
      birthday:   Faker::Date.birthday,
      trial_at:   trial_at,
      hired_at:   trial_at + [*1..3].sample.months
    }

    user = User.create(
      email:         Faker::Internet.safe_email(username),
      password:      'password',
      role:          User::ROLES[:user],
      department_id: Department.limit(1).order('RANDOM()').first.id
    )
    user.create_profile(profile)

    puts "-> User account '#{user.email}' created"
  end
end
