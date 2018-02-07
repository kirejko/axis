# frozen_string_literal: true

require 'rails_helper'

describe User do

  subject { build(:user) }

  describe 'General object validity' do
    it 'has a valid factory' do
      is_expected.to be_valid
    end
  end

  describe 'General properties' do
    it 'defines enum for role with values :admin, :user, :lead, :manager, :recruiter and :director' do
      is_expected.to define_enum_for(:role)
        .with(%i[admin user lead manager recruiter director])
    end

    it 'has unique database index on email' do
      is_expected.to have_db_index(:email).unique(true)
    end
  end

  describe 'Model validations' do
    it 'validates presence of email' do
      is_expected.to validate_presence_of(:email)
    end

    it 'validates email format' do
      is_expected.to     allow_value('name@example.com').for(:email)
      is_expected.to_not allow_value('name@example').for(:email)
      is_expected.to_not allow_value('name').for(:email)
    end
  end

  describe 'Associations' do
    it 'has one profile' do
      is_expected.to have_one(:profile).dependent(:destroy)
    end
  end

end
