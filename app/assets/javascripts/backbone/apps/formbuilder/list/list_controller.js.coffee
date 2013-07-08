@FormBuilder.module "FormApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      forms = App.request "form:entities"

      App.execute "when:fetched", forms, =>
        @layout = @getLayoutView()

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @listRegion forms

        @show @layout

    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    panelRegion: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:form:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    newRegion: ->
      App.execute "new:form", @layout.newRegion

    listRegion: (forms) ->
      listView = @getFormListView forms

      @listenTo listView, "childview:formlist:form:clicked", (child, args) ->
        App.vent.trigger "formbuilder:form:clicked", args.model

      @listenTo listView, "childview:formlist:delete:clicked", (child, args) ->
        model = args.model
        # if confirm "Delete #{model.get("name")}?" then model.destroy() else false
        model.destroy()

      @layout.listRegion.show listView

    getFormListView: (forms) ->
      new List.FormList
        collection: forms

    getPanelView: ->
      new List.Panel

    getTitleView: ->
      new List.Title

    getLayoutView: ->
      new List.Layout