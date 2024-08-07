class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
      t.index :email, unique: true # メールアドレスが他と異なる一意なものとなるようにさせる
    end
  end
end
