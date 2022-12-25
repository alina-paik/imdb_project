class CreateMoviesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :title_image
      t.timestamps null: false
    end
  end
end
