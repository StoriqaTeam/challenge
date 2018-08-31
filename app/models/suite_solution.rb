class SuiteSolution < ApplicationRecord
  has_many :task_solutions, dependent: :destroy
  belongs_to :suite
end
