class TaskSolution < ApplicationRecord
  has_many :task_solution_tests, dependent: :destroy
  belongs_to :suite_solution
  belongs_to :task
end
