class ExercisesController < ApplicationController
  before_action :authorize, only: [:show, :index]

  def index

  end

  def show
    @exercise = Exercise.find(params[:id])
    @answer = @exercise.answers.where(user_id: current_user.id).first
  end

  private
    def authorize
      current_user ? (@exercises = Exercise.all) : (redirect_to root_path, alert: "You are not logged in")
    end
end
