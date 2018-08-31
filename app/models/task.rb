class Task < ApplicationRecord
  has_many :suite_tasks, dependent: :destroy
end
