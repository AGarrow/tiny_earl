class AddIndexToEarl < ActiveRecord::Migration[5.1]
  def change
    add_index :earls, :short_url
    add_index :earls, :full_url
  end
end
