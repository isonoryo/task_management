class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :content, presence: true
  # validates :limit, presence: true

  enum priority: { "低": 1, "中": 2, "高": 3 }
  enum status: { "未着手": 1, "着手中": 2, "完了": 3 }

  scope :search_title, ->(title) {
    where("title like ?", "%#{title}%")
    }

  scope :search_status, ->(status) {
    where(status: status)
    }
end
