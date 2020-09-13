class AddPlaceToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :place, :string
  end
end
