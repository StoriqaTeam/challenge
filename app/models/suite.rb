class Suite < ApplicationRecord
  has_many :suite_tasks, dependent: :destroy
end
