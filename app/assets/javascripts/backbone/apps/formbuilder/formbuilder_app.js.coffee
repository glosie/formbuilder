@FormBuilder.module "FormApp", (FormApp, App, Backbone, Marionette, $, _) ->

  class FormApp.Router extends Marionette.AppRouter
    appRoutes:
      "forms/:id/edit" : "edit"
      "forms"          : "list"

  API =
    list: ->
      new FormApp.List.Controller

    edit: (id, form) ->
      new FormApp.Edit.Controller
        id: id
        form: form

    newForm: (region) ->
      new FormApp.New.Controller
        region: region

  App.commands.setHandler "new:form", (region) ->
    API.newForm region

  App.vent.on "formbuilder:form:clicked form:created", (form) ->
    App.navigate Routes.edit_form_path(form.id)
    API.edit form.id, form

  App.vent.on "form:cancelled form:updated", (form) ->
    App.navigate Routes.forms_path()
    API.list()

  App.addInitializer ->
    new FormApp.Router
      controller: API