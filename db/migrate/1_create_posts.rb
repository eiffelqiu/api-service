class CreatePosts < ActiveRecord::Migration
  
  def change
    create_table :posts do |t|
      t.string :usrname
      t.text :message
      t.string :app
      t.string :ip
      t.timestamps
    end
  end
  
end