# check if path is active
isActive = (inverse = false) ->
  name = 'is'
  name = name + 'Not' if inverse
  name = name + 'Active'

  (view) ->
    unless view instanceof Spacebars.kw
      throw new Error "#{name} options must be key value pair such " +
        "as {{#{name} regex='route/path'}} or {{#{name} name='routeName'}}. " +
        "You passed: #{JSON.stringify view}"

    if view.hash.regex
      pattern =
        className: Match.Optional String
        regex: String
    else
      pattern =
        className: Match.Optional String
        name: String

    check view.hash, pattern

    FlowRouter.watchPathChange()
    controller = FlowRouter.current()
    return false unless controller

    if view.hash.regex
      {className, regex} = view.hash
      test = testExp controller.path, regex
    else
      {className, name} = view.hash
      test = controller.route?.name is name

    className ?= if inverse then 'disabled' else 'active'
    test = not test if inverse
    if test then className else false

testExp = (path, exp) ->
  re = new RegExp exp, 'i'
  re.test path

# check for subscription to be ready
isSubReady = (sub) ->
  return FlowRouter.subsReady(sub) if sub
  return FlowRouter.subsReady()

# return path
pathFor = (path, view) ->
  throw new Error('no path defined') unless path
  query = if view.hash.query then FlowRouter._qs.parse(view.hash.query) else {}
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

