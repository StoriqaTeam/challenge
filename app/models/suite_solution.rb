class SuiteSolution < ApplicationRecord
  has_many :task_solutions, dependent: :destroy
  belongs_to :suite

  after_save :create_task_solutions

  def active_task_solutions
    task_solutions.select(&:is_active).sort_by do |task_solution|
      task_solution_priority(task_solution)
    end
  end

  def score
    score = task_solutions.map(&:score).sum
    count = task_solutions.count
    return nil if count == 0 || !graded
    (score.to_f / count.to_f).to_i
  end

  def grade
    ActiveRecord::Base.transaction do
      task_solutions.each {|task_solution| task_solution.grade}
      self.graded = true
      save!
    end
  end

  private
    def task_solution_priority(task_solution)
      SuiteTask.where(task_id: task_solution.task.id, suite_id: suite.id).first&.priority
    end

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
