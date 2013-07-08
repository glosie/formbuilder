@FormBuilder.module "FormApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options) ->
      { form, id } = options
      form or= App.request "form:entity", id
      palette = App.request "palette:entities"

      App.execute "when:fetched", form, =>
        @layout = @getLayoutView form

        @listenTo @layout, "show", =>
          @titleRegion form
          @formRegion form, palette
          @paletteRegion palette

        @listenTo @layout, "form:save", ->
          form.save()
          App.vent.trigger "form:updated"

        @listenTo @layout, "form:cancel", ->
          App.vent.trigger "form:cancelled"

        @show @layout

    titleRegion: (form) ->
      titleView = @getTitleView form
      @layout.titleRegion.show titleView

    formRegion: (form, palette) ->
      fields = App.request "form:fields:entities", form
      formView = @getFormView form, fields

      @listenTo formView, "form:component:add", (cid, index) ->
        index = 0 if fields.length == 0  ## empty collection fix
        model = palette.get(cid).toJSON()
        model.order = index
        App.request "form:fields:add", fields, model, index
        form.set 'fields_attributes', fields.toJSON()
        @show @layout

      @listenTo formView, "form:component:sort", (model, index) ->
        fields.remove(model)
        App.request "form:fields:add", fields, model, index
        form.set 'fields_attributes', fields.toJSON()
        @show @layout

      @listenTo formView, "childview:form:field:delete", (child, args) ->
        model = args.model
        fields.remove(model)
        model.destroy()
        form.set 'fields_attributes', fields.toJSON()

      @layout.formRegion.show formView

    paletteRegion: (palette) ->
      paletteView = @getPaletteView palette
      @layout.paletteRegion.show paletteView

    getTitleView: (form) ->
      new Edit.Title
        model: form

    getFormView: (form, fields) ->
      new Edit.Form
        model: form
        collection: fields

    getPaletteView: (palette) ->
      new Edit.Palette
        collection: palette

    getLayoutView: (form) ->
      new Edit.Layout
          model: form
