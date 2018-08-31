class SuiteSolutionsController < ApplicationController
  before_action :authenticate_user!

  def start
    if solutions.count == 1 && solutions.first.started
      redirect_to suite_solutions_go_path
      return
    end
    redirect_to suite_solutions_welcome_path
  end

  def welcome
    if solutions.count > 1
      @error_message = "You have more than one test assigned. Pls contact test administrator."
    elsif solutions.count == 0
      @error_message = "No tests are assigned to you. Pls contact test administrator."
    else 
      @solution = solutions.first
    end
  end

  def go
    @solution = solutions.first
    @solution.update!({ started: true })
  end

  private
    def solutions
      @solutions ||= current_user.suite_solutions.reject { |sol| sol.graded }
      @solutions
    end
end
