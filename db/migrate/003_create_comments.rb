class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :topic_id
      t.integer :account_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
