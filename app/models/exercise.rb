# == Schema Information
#
# Table name: exercises
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Exercise < ActiveRecord::Base
  has_many :answers
  has_many :users, through: :answers
  # =================Validations for Exercise model======================================
  # ===================================================================================
  # validates :answers, inclusion: { in: [true, false] }
  validates :description, :title, presence: true, allow_blank: false

  # =================Callbacks for Exercise model======================================
  # ===================================================================================
  after_create :file_name, :set_spec_test_path, on: :create

  # protected
    def file_name
      title.downcase.gsub(/\s/, '_')
    end

    def set_spec_test_path
      update_attributes(spec_test_path: "spec/views/answers/#{file_name}_spec.rb")
    end
end
