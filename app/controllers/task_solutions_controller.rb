class TaskSolutionsController < ApplicationController
  def run_tests
    task_solution_id = params[:id]
    task_solution = TaskSolution.find(task_solution_id)
    language = task_solution.task.language
    program = task_solution.task.runtime + "\n" + params[:code]
    runner = ::Runner.from_lang(language)
    output = runner.run(program)
    render json: {output: output}
  end
end
