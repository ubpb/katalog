#= require utils/deep_locate
#= require jsonpath
#= require polyfills/Array_find

(((window.app ?= {}).components ?= {}).TermsFacet ?= {}).Term = Ractive.extend
  #
  # ractive
  #
  computed:
    deselect_term_path: ->
      unfacetted_search_request = _.cloneDeep @parent.get("search_request")

      for match_query_parent in JSONPath({json: unfacetted_search_request, path: "$..match^^^"})
        _.remove match_query_parent, (query) =>
          query["match"]?[@facet_name()] == @undecorated_term()["term"]

      @searches_path(search_request: unfacetted_search_request)

    include_term_path: ->
      new_search_request = _.cloneDeep(@parent.get("search_request"))
      @add_facet_query(new_search_request, @parent.get("facet"), @get("term"))
      @searches_path(search_request: new_search_request)

    remove_term_path: ->
      new_search_request = _.cloneDeep(@parent.get("search_request"))
      @remove_facet_query(new_search_request, @parent.get("facet"), @get("term"))
      @searches_path(search_request: new_search_request)

    selected_by_search_request: ->
      facet_queries = @parent.get("search_request.facet_queries") || []
      !!(facet_queries.find (element) =>
        element["field"] == @parent.get("facet.field") && element["query"] == @get("term")
      )

  template: "{{>content}}"

  #
  # custom
  #
  add_facet_query: (search_request, facet, value, options = {}) ->
    facet_query = {
      field: facet["field"],
      query: value,
      type: "match"
    }

    if options["exclude"] == true
      facet_query["exclude"] = true

    (search_request.facet_queries ?= []).push(facet_query)

  remove_facet_query: (search_request, facet, value, options = {}) ->
    new_facet_queries = _.reject(search_request.facet_queries, (element) =>
      element["field"] == @parent.get("facet.field") && element["query"] == @get("term")
    )

    search_request.facet_queries = if new_facet_queries.length == 0 then undefined else new_facet_queries

  searches_path: (options = {}) ->
    @parent.searches_path(options)