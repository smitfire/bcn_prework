class User < ActiveRecord::Base
  has_many :useranswers
  has_many :exercises, through: :useranswers
end
