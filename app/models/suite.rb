class Suite < ApplicationRecord
  has_many :suite_tasks, dependent: :destroy
  has_many :suite_solutions, dependent: :destroy
  has_many :tasks, through: :suite_tasks
end
