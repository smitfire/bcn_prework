# == Schema Information
#
# Table name: users
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  email                 :string(255)
#  password_digest       :string(255)
#  password_confirmation :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

FactoryGirl.define do
  factory :user do
    
  end

end
