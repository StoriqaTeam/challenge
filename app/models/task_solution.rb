class TaskSolution < ApplicationRecord
  has_many :task_solution_tests, dependent: :destroy
end
