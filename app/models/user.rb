class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end
end
