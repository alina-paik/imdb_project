class CreateCategoriesMoviesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_movies do |t|
      t.references :movie, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
    end
    add_index :categories, :name, unique: true
  end
end
