class CreateMsgs < ActiveRecord::Migration
  
  def self.up
    create_table :msgs do |t|
      t.string :name
      t.text :body
      t.string :email
      t.string :sns
      t.string :uuid
      t.integer :model, :default => 0      
      t.string :app
      t.string :ip
      t.timestamps
    end
  end

  def self.down
    drop_table :msgs
  end  
  
end