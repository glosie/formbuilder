@FormBuilder.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Palette extends Entities.Collection
    model: Entities.FormComponent

  API =
    getPalette: ->
      new Entities.Palette [
        { name: "Text Input", component_type: "textinput", icon: "icon-font" }
        { name: "Paragraph Box", component_type: "textarea", icon: "icon-edit" }
        { name: "Email Address", component_type: "email", icon: "icon-envelope", placeholder: "email@address.com" }
        { name: "Section Heading", component_type: "legend", icon: "icon-info" }
        { name: "Single Selection", component_type: "select", icon: "icon-collapse", options: "Option 1\nOption 2\nOption 3" }
        { name: "Multiple Selection", component_type: "multipleselect", icon: "icon-reorder", options: "Option 1\nOption 2\nOption 3" }
        { name: "Checkbox", component_type: "checkbox", icon: "icon-check", options: "Checkbox 1\nCheckbox 2\nCheckbox 3" }
        { name: "Radio Buttons", component_type: "radio", icon: "icon-circle-blank", options: "Option 1\nOption 2\nOption 3" }
      ]

  App.reqres.setHandler "palette:entities", ->
    API.getPalette()