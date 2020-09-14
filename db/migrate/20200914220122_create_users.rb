class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :city
      t.string :profile
      t.text :about
      t.boolean :public

      t.timestamps
    end
  end
end
