class CreateMessages < ActiveRecord::Migration
  
  def change
    create_table :messages do |t|
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
  
end