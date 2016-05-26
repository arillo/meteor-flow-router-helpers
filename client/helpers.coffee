# check for subscriptions to be ready
subsReady = (subs...) ->
  return FlowRouter.subsReady() if subs.length is 1
  subs = subs.slice(0, subs.length - 1)
  _.reduce subs, (memo, sub) ->
    memo and FlowRouter.subsReady(sub)
  , true

# return path
pathFor = (path, view = {hash:{}}) ->
  throw new Error('no path defined') unless path
  # set if run on server
  view = hash: view unless view.hash
  if path.hash?.route?
    view = path
    path = view.hash.route
    delete view.hash.route
  query = if view.hash.query then FlowRouter._qs.parse(view.hash.query) else {}
  hashBang = if view.hash.hash then view.hash.hash else ''
  FlowRouter.path(path, view.hash, query) + (if hashBang then "##{hashBang}" else '')

# return absolute url
urlFor = (path, view) ->
  relativePath = pathFor(path, view)
  Meteor.absoluteUrl(relativePath.substr(1))

# get parameter
param = (name) ->
  FlowRouter.getParam(name);

# get query parameter
queryParam = (key) ->
  FlowRouter.getQueryParam(key);

# get current route name
currentRouteName = () ->
  FlowRouter.getRouteName()

# get current route options
currentRouteOption = (optionName) ->
  FlowRouter.current().route.options[optionName]

# deprecated
isSubReady = (sub) ->
  return FlowRouter.subsReady(sub) if sub
  return FlowRouter.subsReady()

helpers =
  subsReady: subsReady
  pathFor: pathFor
  urlFor: urlFor
  param: param
  queryParam: queryParam
  currentRouteName: currentRouteName
  isSubReady: isSubReady
  currentRouteOption: currentRouteOption

if Meteor.isClient
  Template.registerHelper name, func for own name, func of helpers
  
if Meteor.isServer
  FlowRouterHelpers = 
    pathFor: pathFor
    urlFor: urlFor
