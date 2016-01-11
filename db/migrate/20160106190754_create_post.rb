class CreatePost < ActiveRecord::Migration
  def change
 
  create_table :posts do |t|
        t.string :body
        t.string :title
        t.integer :user_id
        t.timestamps null: false
       
end
  end
end
