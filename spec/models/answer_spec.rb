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

require 'rails_helper'

RSpec.describe Answer, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
