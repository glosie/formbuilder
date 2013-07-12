do (Marionette) ->
  _.extend Marionette.Renderer,

    lookups: ["backbone/apps/", "backbone/components/"]

    render: (template, data) ->
      path = @getTemplate(template)
      throw "Template #{template} not found!" unless path
      path(data)

    getTemplate: (template) ->
      template = template.split("/")
      template.splice(-1, 0, "templates")
      path = template.join("/")
      for lookup in @lookups
        return JST[lookup + path] if JST[lookup + path]