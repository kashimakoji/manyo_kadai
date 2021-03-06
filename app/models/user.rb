class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }
  validates :email, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :password, length: { minimum: 1 }

  has_many :tasks, dependent: :destroy

  before_destroy :destroy_stopped
  # after_update :update_stopped
  before_update :update_stopped

  private
  def destroy_stopped
    throw(:abort) if User.where(admin:true).count == 1 && self.admin?
  end

  def update_stopped
    # errors.add :base, '管理者は１人以上必要です'
    errors.add :admin
    # errors[:base] << '管理者は１人以上必要ですベンダー'
    throw(:abort) if User.where(admin:true).count == 1 && User.where(admin:true).first.id == self.id && self.admin == false

    # if User.where(admin: true).length == 0
    #   raise ActiveRecord::Rollback
      # self.admin = true
      # self.save
      # errors.add :base, "sfdsaf"
    # end
  end

end
