# check if path is active
isActive = (inverse = false) ->
  name = 'is'
  name = name + 'Not' if inverse
  name = name + 'Active'

  (view) ->
    unless view instanceof Spacebars.kw
      throw new Error "#{name} options must be key value pair such " +
        "as {{#{name} regex='route/path'}}. You passed: " +
        "#{JSON.stringify view}"

    pattern =
      className: Match.Optional String
      regex: String

    check view.hash, pattern

    controller = FlowRouter.current()

    return false unless controller

    {className, regex} = view.hash

    className ?= if inverse then 'disabled' else 'active'

    test = testExp controller.path, regex

    test = not test if inverse

    if test then className else false

testExp = (path, exp) ->
  re = new RegExp exp, 'i'
  re.test path

# check for subscription to be ready
isSubReady = (sub) ->
  return FlowRouter.subsReady(sub) if sub
  return FlowRouter.subsReady()

deparam = (queryString) ->
  obj = {}
  pairs = queryString.split('&')
  for i of pairs
    `i = i`
    split = pairs[i].split('=')
    obj[decodeURIComponent(split[0])] = decodeURIComponent(split[1])
  obj

# return path
pathFor = (path, view) ->
  throw new Error('no path defined') unless path
  query = if view.hash.query then deparam(view.hash.query) else {}
  FlowRouter.path(path, view.hash, query)

urlFor = (path, view) ->
  relativePath = pathFor(path, view)
  Meteor.absoluteUrl(relativePath.substr(1))

helpers =
  isActivePath: isActive()
  isNotActivePath: isActive true
  isSubReady: isSubReady
  pathFor: pathFor
  urlFor: urlFor

Template.registerHelper name, func for own name, func of helpers

