# check for subscription to be ready
isSubReady = (sub) ->
  return FlowRouter.subsReady(sub) if sub
  return FlowRouter.subsReady()

# return path
pathFor = (path, view) ->
  throw new Error('no path defined') unless path
  query = if view.hash.query then FlowRouter._qs.parse(view.hash.query) else {}
  FlowRouter.path(path, view.hash, query)

# return absolute url
urlFor = (path, view) ->
  relativePath = pathFor(path, view)
  Meteor.absoluteUrl(relativePath.substr(1))

helpers =
  isSubReady: isSubReady
  pathFor: pathFor
  urlFor: urlFor

Template.registerHelper name, func for own name, func of helpers