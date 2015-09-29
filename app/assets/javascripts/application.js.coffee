#
# json3, jquery and jquery_ujs have to come first
#
#= require json3
#= require jquery
#= require jquery.turbolinks
#= require jquery_ujs
#= require lodash-compat

#
# turbolinks
#
#= require turbolinks

#
# all other javascript
#
#= require bootstrap-sprockets
#= require jquery.jsonp
#= require jquery.sparkline
#= require jquery-tablesorter/jquery.metadata
#= require jquery-tablesorter/jquery.tablesorter
#= require jquery-ui/slider
#= require jquery.ui.touch-punch
#= require bootstrap-simple-select
#= require bootstrap-switch
#= require bootstrap-tour
#= require ractive/ractive
#= require ractive/ractive-events-keys
#= require trunker

#= require_directory .
#= require_tree ./components
#= require_tree ./decorators
#= require_tree ./users
#= require_tree ./utils
#= require_tree ./views
#= require_tree ./controllers

#= require ./polyfills/Array_reduce

Turbolinks?.enableProgressBar()

$(document).ready ->
  $("[data-decorator]").each (index, el) ->
    unless $(el).data("decorator-processed")
      decorator_class = $(el)
        .data("decorator")
        .split(".")
        .reduce(((memo, path_element) -> memo[path_element]), window)

      new decorator_class
        data: $(el).data("decorator-options")
        el: el

      $(el).data("deocrator-processed", true)

$(document).ready ->
  $("[data-same-height-as]").each (index, el) ->
    unless $(el).data("processed")
      resize_handler = ->
        if (reference_el = $($(el).data("same-height-as"))).length > 0
          $(el).css("height", reference_el.height())

      $(window).on "resize", resize_handler
      resize_handler()
      $(el).data("processed", true)

# fire up all components
$(document).ready ->
  $("[data-ractive-class]").each (index, placeholder) ->
    ractive_class = $(placeholder)
      .data("ractive-class")
      .split(".")
      .reduce(((memo, path_element) -> memo[path_element]), window)

    container = $(placeholder).parent()

    new ractive_class
      append: $(container).find(placeholder) # insert before placeholder
      data: $(placeholder).data("ractive-options")
      el: container
      partials:
        content: $(placeholder).text()

  $("[data-ractive-component]").each (index, placeholder) ->
    component_name = $(placeholder).data("ractive-component")
    container = $(placeholder).parent()

    new app.components[component_name]
      append: $(container).find(placeholder) # insert before placeholder
      data: $(placeholder).data("ractive-options")
      el: container
      template: $(placeholder).text()
    .on "ready", =>
      $(placeholder).remove()
