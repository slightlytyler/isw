class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :guide
      t.string :name
      t.string :url
      t.datetime :published_at
      t.string :image
      t.text :content

      t.timestamps
    end
  end
end
