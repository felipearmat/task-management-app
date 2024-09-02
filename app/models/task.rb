class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :title, exclusion: { in: [''] }

  validates :due_date, presence: true

  def complete!
    update(completed: true)
  end
end
