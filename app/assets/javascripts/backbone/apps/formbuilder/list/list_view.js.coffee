@FormBuilder.module "FormApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "formbuilder/list/list_layout"

    regions:
      titleRegion: "#title-region"
      panelRegion: "#panel-region"
      newRegion:    "#new-region"
      listRegion: "#list-region"

  class List.Title extends App.Views.ItemView
    template: "formbuilder/list/_title"

  class List.Panel extends App.Views.ItemView
    template: "formbuilder/list/_panel"

    triggers:
      "click #new-form" : "new:form:button:clicked"

  class List.Form extends App.Views.ItemView
    template: "formbuilder/list/_form"
    tagName: "li"
    className: "form"

    triggers:
      "click .form-delete i"  : "formlist:delete:clicked"
      "click"                 : "formlist:form:clicked"

  class List.Empty extends App.Views.ItemView
    template: "formbuilder/list/_empty"
    tagName: "li"

  class List.FormList extends App.Views.CompositeView
    template: "formbuilder/list/_form_list"
    itemView: List.Form
    emptyView: List.Empty
    itemViewContainer: "ul"
