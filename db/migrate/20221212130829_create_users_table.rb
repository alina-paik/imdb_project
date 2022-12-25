class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ''
      t.string :email, null: false, default: ''
      t.string :password, null: false, default: ''
      t.boolean :admin, default: false
      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end
