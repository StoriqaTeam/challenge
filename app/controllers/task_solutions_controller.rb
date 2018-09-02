class TaskSolutionsController < ApplicationController
  def run_tests
    puts params[:code]
  end
end
