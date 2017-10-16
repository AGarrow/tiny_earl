class AddUniqueIndexes < ActiveRecord::Migration[5.1]
  def change
  	add_index :earls, :short_url, unique: true
  	add_index :earls, :full_url, unique: true
  end
end
