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
        where("name LIKE ?", "%#{q}%")
      end
    end
  )

  scope(
    :paginate, lambda do |params|
      set_limit = 20
      set_offset = 0

      if params.key?(:limit)
        limit_params = params[:limit].to_i
        set_limit = limit_params if limit_params <= 100
      end

      if params.key?(:page)
        set_offset = (params[:page].to_i - 1) * set_limit
      end

      limit(set_limit).offset(set_offset)
    end
  )
end
