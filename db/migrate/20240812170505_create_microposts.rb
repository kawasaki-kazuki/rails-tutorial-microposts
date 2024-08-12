class CreateMicroposts < ActiveRecord::Migration[7.1]
  def change
    create_table :microposts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
      t.index %i[user_id created_at]
    end
  end
end
