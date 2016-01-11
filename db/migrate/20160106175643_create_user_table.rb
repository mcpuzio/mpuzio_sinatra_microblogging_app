class CreateUserTable < ActiveRecord::Migration
  def change
 create_table :users do |t|
        t.string :firstname
        t.string :lastname
        t.string :password
        t.timestamps null: false
        t.string :email
end
  end
end
