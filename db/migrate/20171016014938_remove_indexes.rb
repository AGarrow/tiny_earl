class RemoveIndexes < ActiveRecord::Migration[5.1]
  def change
  	remove_index :earls, :short_url
  	remove_index :earls, :full_url
  end
end
