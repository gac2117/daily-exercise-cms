class ChangeColumnDate < ActiveRecord::Migration[4.2]
  def change
    change_column :exercises, :date, :date
  end
end
