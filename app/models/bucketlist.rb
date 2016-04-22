class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :name, presence: true, uniqueness: true

  def user_bucket?(user)
   self.user == user
  end

  scope(
    :search, lambda do |q|
      unless q.nil?
        where("name LIKE ?", "%#{q}%" )
      end
    end
  )
end
