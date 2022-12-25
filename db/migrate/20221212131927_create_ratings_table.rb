class CreateRatingsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
      t.integer :grade, null: false, default: 0
    end
    add_index :ratings, [:user_id, :movie_id], unique: true
  end
end
