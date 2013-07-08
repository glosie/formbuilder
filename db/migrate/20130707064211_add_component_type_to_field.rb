class AddComponentTypeToField < ActiveRecord::Migration
  def change
    add_column :fields, :component_type, :string
  end
end
