# frozen_string_literal: true

require 'rails_helper'

describe Profile, type: :model do

  subject { build(:profile) }

  describe 'General object validity' do
    it 'has a valid factory' do
      is_expected.to be_valid
    end
  end

  describe 'General properties' do
    it 'defines enum for gender with :male and :female values' do
      is_expected.to define_enum_for(:gender).with(%i[male female])
    end
  end

  describe 'Model validations' do
    it 'validates presence of first and last name' do
      is_expected.to validate_presence_of(:first_name)
      is_expected.to validate_presence_of(:last_name)
    end

    it 'validates length to be 2..32 for first and last name' do
      is_expected.to validate_length_of(:first_name).is_at_least(2).is_at_most(32)
      is_expected.to validate_length_of(:last_name).is_at_least(2).is_at_most(32)
    end
  end

  describe 'Associations' do
    it 'belongs to a single user' do
      is_expected.to belong_to(:user).touch
    end
  end

end
