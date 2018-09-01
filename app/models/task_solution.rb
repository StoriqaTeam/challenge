class TaskSolution < ApplicationRecord
  has_many :task_solution_tests, dependent: :destroy
  belongs_to :suite_solution
  belongs_to :task

  def is_active
    return true unless started_at
    return (Time.current - started_at).minutes <= task.time
  end
end
