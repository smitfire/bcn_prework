# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  exercise_id :integer
#  answer      :string(255)
#  answer_test :json
#  status      :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :answer do
    
  end

end
