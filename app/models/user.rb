class User < ActiveRecord::Base
  has_many :bucketlists
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def generate_auth_token
    payload = { user_id: id }
    AuthToken.encode(payload)
  end
end
