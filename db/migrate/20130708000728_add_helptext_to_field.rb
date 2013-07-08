class AddHelptextToField < ActiveRecord::Migration
  def change
    add_column :fields, :helptext, :string
  end
end
