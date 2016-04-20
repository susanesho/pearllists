class CreateBucketlists < ActiveRecord::Migration
  def change
    create_table :bucketlists do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
