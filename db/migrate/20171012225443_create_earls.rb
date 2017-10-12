class CreateEarls < ActiveRecord::Migration[5.1]
  def change
    create_table :earls do |t|
      t.string :full_url
      t.string :short_url
      t.integer :view_count

      t.timestamps
    end
  end
end
