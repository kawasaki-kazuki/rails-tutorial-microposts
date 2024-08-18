class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps

      t.index %i[follower_id followed_id], unique: true
    end
  end
end
