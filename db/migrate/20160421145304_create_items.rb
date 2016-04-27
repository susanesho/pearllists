class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string  :bucketlist_id
      t.boolean :done, default: false

      t.timestamps null: false
    end
  end
end
