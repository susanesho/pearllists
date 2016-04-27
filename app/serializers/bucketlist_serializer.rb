class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :date_created, :date_modified, :created_by

  def date_created
    object.created_at.strftime("%Y-%m-%d")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d")
  end

  def created_by
    object.user.id
  end

end
