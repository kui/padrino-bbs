class RemoveUpdatedAtFromComment < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.remove :updated_at
    end
  end

  def self.down
    change_table :comments do |t|
      t.datetime :updated_at
    end
  end
end
