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
  before_update :answer_to_script, :spec_res_builder, :read_json_file, :html_to_json_spec, if: :answer_present?,
    unless: Proc.new { |answer| answer.status? }, on: [:update]
  around_update :update_status_and_json, if: :status_check?,
    unless: Proc.new { |answer| answer.status? }, on: [:update]
  after_commit :remove_generated_files, if: :status_check?,
    unless: Proc.new { |answer| answer.spectml.nil? || answer.specson.nil? || answer.answer.nil? }, on: [:update]

  # ===========================Answer Model Methods====================================
  # ===================================================================================
  def convert_status
    status ? "Completed" : "Pending"
  end

  def set_file_path
    exercise.file_name + '_' + user.id.to_s
  end

  def parse_nil(json)
    JSON.parse(json) if json && json.length >= 2
  end

  protected

    def answer_present?
      answer != nil && answer.length > 1
    end

    def spec_res_builder
      format_json = "--format j > app/views/answers/_specson/#{set_file_path}.json"
      format_html ="--format h > app/views/answers/_spectml/_#{set_file_path}.html.erb"
      req = "rspec --require ./spec/views/answers/#{set_file_path} #{exercise.spec_test_path} "
      %x(#{req} #{format_json})
      %x(#{req} #{format_html})
    end

    def html_to_json_spec
      status ? spectml : IO.read("app/views/answers/_spectml/_#{set_file_path}.html.erb")
    end

    def read_json_file
      status ? specson : parse_nil(IO.read("app/views/answers/_specson/#{set_file_path}.json"))
    end


    def status_check?
      read_json_file["examples"].select { |h| h["status"] != "passed"}.empty?
    end

    def answer_to_script
      IO.write("spec/views/answers/#{set_file_path}.rb", answer)
    end

    def update_status_and_json
      update(status: status_check?, specson: read_json_file, spectml: html_to_json_spec, answer: answer)
    end

    def remove_generated_files
      File.delete("app/views/answers/_specson/#{set_file_path}.json")
      File.delete("app/views/answers/_spectml/_#{set_file_path}.html.erb")
      File.delete("spec/views/answers/#{set_file_path}.rb")
    end

end
