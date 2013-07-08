@FormBuilder.module "FooterApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: ->
      footerView = @getFooterView()
      @show footerView

    getFooterView: ->
      new Show.Footer