class AddRequiredToField < ActiveRecord::Migration
  def change
    add_column :fields, :required, :boolean
  end
end
