class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
  end
  def show
    if current_user
      @exercise = Exercise.find(params[:id])
      @answer = @exercise.answers.where(user_id: current_user.id).first
    else
      redirect_to root_path
    end
  end
end
