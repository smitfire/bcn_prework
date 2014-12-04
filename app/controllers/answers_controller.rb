class AnswersController < ApplicationController
  before_action :fetch_answer, only: [:show, :update, :show_spec]
  before_action :update_answer, only: :update
  before_action :fetch_exercises, :authorize, only: :index

  def index

  end

  def show
  end

  def show_spec
    render layout: false
  end

  def update
    redirect_to answer_path(@answer.id)
  end

  private
    def answer_params
      params.require(:answer).permit(:answer, :user_id, :exercise_id)
    end

    def authorize
      current_user ? (@answers = current_user.answers) : (redirect_to root_path, alert: "You are not logged in")
    end

    def fetch_exercises
      @exercises = Exercise.all
    end

    def fetch_answer
      @answer = Answer.find(params[:id])
    end

    def update_answer
      @answer.update(answer_params)
    end
end
