class AddDefaultBooleans < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :public, :boolean, default: false
    change_column :events, :published, :boolean, default: false
  end
end
