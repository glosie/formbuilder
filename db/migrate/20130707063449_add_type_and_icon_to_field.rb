class AddTypeAndIconToField < ActiveRecord::Migration
  def change
    add_column :fields, :type, :string
    add_column :fields, :icon, :string
    add_column :fields, :options, :string
  end
end
