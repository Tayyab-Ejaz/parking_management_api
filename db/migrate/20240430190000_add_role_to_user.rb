class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :integer, default: 0
  end
end
