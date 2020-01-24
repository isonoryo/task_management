class Task < ApplicationRecord
  belongs_to :user, optional: true
  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label

  validates :title, presence: true
  validates :content, presence: true
  # validates :limit, presence: true

  enum priority: { "低": 1, "中": 2, "高": 3 }
  enum status: { "未着手": 1, "着手中": 2, "完了": 3 }

  scope :created_at, -> {order(created_at: :desc)}
  scope :limit_at, -> {order(limit: :desc)}
  scope :priority_at, -> {order(priority: :desc)}

  scope :search_title, ->(title) {
    where("title like ?", "%#{title}%")
    }

  scope :search_status, ->(status) {
    where(status: status)
    }
end
