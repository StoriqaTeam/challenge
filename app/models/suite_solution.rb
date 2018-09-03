class SuiteSolution < ApplicationRecord
  has_many :task_solutions, dependent: :destroy
  belongs_to :suite

  after_save :create_task_solutions

  def active_task_solutions
    task_solutions.select(&:is_active)
  end

  def grade
    task_solutions.each {|task_solution| task_solution.grade}
    graded = true
    save!
  end

  private
    def create_task_solutions
      task_ids = task_solutions.map { |solution| solution.task_id }
      suite_task_ids = suite.tasks.map { |task| task.id }
      to_create_ids = suite_task_ids - task_ids
      ActiveRecord::Base.transaction do
        to_create_ids.each do |task_id|
          task = Task.find(task_id)
          TaskSolution.create({
            task_id: task_id,
            suite_solution_id: id,
            solution: task.initial,
            tests: task.initial_tests,
          })
        end
      end
    end
end
