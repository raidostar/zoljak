class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :school, :string
    add_column :users, :major, :string
    add_column :users, :schoolyear, :integer
  end
  def down
    remove_column :users, :name
    remove_column :users, :phone_number
    remove_column :users, :school
    remove_column :users, :major
    remove_column :users, :schoolyear
  end
end
