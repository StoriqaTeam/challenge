class SuiteSolutionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_solution, only: [:welcome, :go]
  before_action :set_navbar

  def start
    if solutions.count == 1 && solutions.first.started
      redirect_to suite_solutions_go_path
      return
    end
    redirect_to suite_solutions_welcome_path
  end

  def welcome
  end

  def go
    unless @solution
      redirect_to suite_solutions_welcome_path
      return
    end
    @solution.update!({ started: true })
    @task_solution = @solution.active_task_solutions.first
    unless @task_solution
      redirect_to suite_solutions_finish_path
      return
    end
    @task_solution.update({ started_at: Time.now }) unless @task_solution.started_at
  end

  def finish
  end

  private

    def set_navbar
      @with_navbar = true
    end

    def set_solution
      if solutions.count > 1
        @error_message = "You have more than one test assigned. Pls contact test administrator."
      elsif solutions.count == 0
        @error_message = "No tests are assigned to you. Pls contact test administrator."
      else 
        @solution = solutions.first
      end
    end

    def solutions
      @solutions ||= current_user.suite_solutions.reject { |sol| sol.graded }
      @solutions
    end
end
