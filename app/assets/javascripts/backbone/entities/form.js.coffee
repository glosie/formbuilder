@FormBuilder.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.FormComponent extends Entities.Model
    url: -> Routes.form_field_path(@get('form_id'), @get('id'))
    defaults:
      placeholder: "Placeholder Text"
      helptext: "help text"
      required: false
      options: ""

    initialize: ->
      window.g = @

    templateName: ->
      @get('component_type').replace(/\W/g,'').toLowerCase()

    getOptions: ->
      @attributes.options.value

    setOptions: (name, value) ->
      options = @get 'options'
      options[name].value = value
      @set 'options', options

  class Entities.FormFields extends Entities.Collection
    model: Entities.FormComponent

    comparator: (field) ->
      field.get 'order'

    addModel: (model, index) ->
      console.log "insert at: #{index}"
      @add model, {at: index}
      # set order to collection index
      @each (model, index) ->
        order = index
        model.set 'order', order

  class Entities.Form extends Entities.Model
    urlRoot: -> Routes.forms_path()

  class Entities.FormList extends Entities.Collection
    model: Entities.Form
    url: -> Routes.forms_path()

  API =
    getFormList: ->
      forms = new Entities.FormList
      forms.fetch
        reset: true
      forms

    getForm: (id) ->
      form = new Entities.Form
        id: id
      form.fetch()
      form

    newForm: ->
      new Entities.Form

    getFormFields: (form) ->
      new Entities.FormFields form.get 'fields_attributes'

    addFormField: (fields, field, index) ->
      fields.addModel(field, index)

  App.reqres.setHandler "form:entities", ->
    API.getFormList()

  App.reqres.setHandler "form:entity", (id) ->
    API.getForm id

  App.reqres.setHandler "new:form:entity", ->
    API.newForm()

  App.reqres.setHandler "form:fields:entities", (form) ->
    API.getFormFields form

  App.reqres.setHandler "form:fields:add", (collection, model, index) ->
    API.addFormField(collection, model, index)