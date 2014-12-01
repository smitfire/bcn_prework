class Exercise < ActiveRecord::Base
  has_many :useranswers
  has_many :users, through: :useranswers
end
