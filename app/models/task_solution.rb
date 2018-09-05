class TaskSolution < ApplicationRecord
  has_many :task_solution_results, dependent: :destroy
  belongs_to :suite_solution
  belongs_to :task

  def is_active
    return true unless started_at
    return false if self.submitted
    return (Time.current - started_at) / 60 <= task.time
  end

  def grade
    # already graded
    return unless task_solution_results.count == 0
    task_results = Runner.grade(self)
    task_results.each {|res| res.save}
  end

  def score
    successes = task_solution_results.select(&:passed).count
    total = task.number_of_tests
    return 0 unless total
    return 0 if total == 0
    (successes.to_f / total.to_f * 100).to_i
  end
end
