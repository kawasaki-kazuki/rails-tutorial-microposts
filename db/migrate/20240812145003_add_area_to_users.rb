class AddAreaToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :area, :string
  end
end
