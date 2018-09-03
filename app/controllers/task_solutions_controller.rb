class TaskSolutionsController < ApplicationController
  before_action :set_task_solution, only: [:update, :run_tests]

  def run_tests
    language = @task_solution.task.language
    program = @task_solution.task.runtime + "\n" + params[:code]
    runner = Runner.from_lang(language)
    output = runner.run(program)
    render json: {output: output}
  end

  def update
    respond_to do |format|
      if @task_solution.update(task_solution_params.merge({ submitted: true }))
        format.html { redirect_to suite_solutions_go_url, notice: 'Task was successfully submitted.' }
        format.json { render :show, status: :ok, location: @task_solution }
      else
        format.html { render :edit }
        format.json { render json: @task_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task_solution
    @task_solution = TaskSolution.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_solution_params
    params.require(:task_solution).permit(:solution, :tests)
  end

end
