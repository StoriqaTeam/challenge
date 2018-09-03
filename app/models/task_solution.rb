class TaskSolution < ApplicationRecord
  has_many :task_solution_results, dependent: :destroy
  belongs_to :suite_solution
  belongs_to :task

  def is_active
    return true unless started_at
    return false if solution
    return (Time.current - started_at).minutes <= task.time
  end

  def grade
    # already graded
    return unless task_solution_results.count == 0
    task_results = Runner.grade(self)
    task_results.each {|res| res.save}
  end
end
