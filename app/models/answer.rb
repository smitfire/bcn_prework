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
class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  # =================Validations for Answer model======================================
  # ===================================================================================
  validates :user, :exercise, presence: true

  # =================Callbacks for Answer model======================================
  # ===================================================================================
  after_validation :set_file_path, on: [:create]

  before_update :answer_to_script, :spec_res_builder, :read_json_file, :html_to_json_spec, if: :answer_present?,
    unless: Proc.new { |answer| answer.status? }, on: [:update]

  after_update :update_status_and_json, if: :status_check?, on: [:update]

  after_commit :remove_generated_files, if: :status,
    unless: Proc.new { |answer| answer.spectml.nil? || answer.specson.nil? || answer.answer.nil? }

  def convert_status
    status ? "Completed" : "Pending"
  end

  def set_file_path
    @file_path = exercise.file_name + '_' + user.id.to_s
  end

  protected

    def answer_present?
      answer != nil && answer.length > 1
    end

    def spec_res_builder
      format_json = "--format j > app/views/answers/_specson/#{@file_path}.json"
      format_html ="--format h > app/views/answers/_spectml/_#{@file_path}.html.erb"
      req = "rspec --require ./spec/views/answers/#{@file_path} #{exercise.spec_test_path} "
      %x(#{req} #{format_json})
      %x(#{req} #{format_html})
    end

    def html_to_json_spec
      @html_spec = IO.read("app/views/answers/_spectml/_#{@file_path}.html.erb").to_json
    end

    def read_json_file
      @json_spec = JSON.parse(IO.read("app/views/answers/_specson/#{@file_path}.json"))
    end

    def status_check?
      @json_spec["examples"].select { |h| h["status"] != "passed"}.empty?
    end

    def answer_to_script
      IO.write("spec/views/answers/#{set_file_path}.rb", answer)
    end

    def update_status_and_json
      update_columns(status: status_check?, specson: @json_spec, spectml: @html_spec)
    end

    def remove_generated_files
      IO.delete("app/views/answers/_spectml/#{@file_path}.json")
      IO.delete("app/views/answers/_spectml/_#{@file_path}.html.erb")
      IO.delete("spec/views/answers/#{set_file_path}.rb")
    end

end
