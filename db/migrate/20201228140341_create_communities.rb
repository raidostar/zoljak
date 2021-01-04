class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.string :title
      t.text :content
      t.string :writer
      t.integer :hitcount
      t.datetime :date

      t.timestamps
    end
  end
end
