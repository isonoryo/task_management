class User < ApplicationRecord
  has_many :tasks, dependent: :destroy

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }

  before_destroy do
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin?

  end

  # before_update do #この記述で管理者１人の場合は管理者に関する変更が出来なくなる？
  #   throw(:abort) if User.where(admin: true).count <= 1
  # end

end
