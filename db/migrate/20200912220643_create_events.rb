class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :theme
      t.string :short_desc
      t.text :full_desc
      t.boolean :published, :default => 1
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
