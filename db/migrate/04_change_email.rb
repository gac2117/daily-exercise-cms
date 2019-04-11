class ChangeEmail < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :email, :text
    add_column :users, :name, :string
  end
end
