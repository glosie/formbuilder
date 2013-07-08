@FormBuilder.module "FormApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Form extends App.Views.ItemView
    template: "formbuilder/new/new_form"
    form:
      buttons:
        placement: "left"