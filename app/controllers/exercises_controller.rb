class ExercisesController < ApplicationController
  def index
  end
  
  def new
    @exercise = User.find(current_user.id).exercises.new
  end
  
  def create
    
  end
end