class AddOrderToField < ActiveRecord::Migration
  def change
    add_column :fields, :order, :integer
  end
end
