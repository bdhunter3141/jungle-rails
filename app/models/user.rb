class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  before_validation :downcase_field

  private

  def downcase_field
    self[:email].downcase! if self[:email].present?
  end
end
