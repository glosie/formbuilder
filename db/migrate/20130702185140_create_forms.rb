class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name

      t.timestamps
    end
  end
end
