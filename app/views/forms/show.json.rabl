object @form

extends "forms/_base"

child :fields => :fields_attributes do
  attributes *Field.column_names
end