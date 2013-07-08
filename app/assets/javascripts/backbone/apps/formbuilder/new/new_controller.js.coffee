@FormBuilder.module "FormApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base

    initialize: ->
      form = App.request "new:form:entity"

      @listenTo form, "created", ->
        App.vent.trigger "form:created", form

      newView = @getNewView form
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (form) ->
      new New.Form
        model: form