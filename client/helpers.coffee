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

helpers =
  isActivePath: isActive
  isNotActivePath: isActive true

Template.registerHelper name, func for own name, func of helpers

UI.registerHelper "pathFor", (path, options) ->
  throw new Meteor.Error('no path defined') unless path
  unless options and options instanceof Spacebars.kw
    throw new Error "#{name} options must be key value pair such " +
      "as {{#{name} regex='route/path'}}. You passed: " +
      "#{JSON.stringify view}"
  FlowRouter.path(path, options.hash)

UI.registerHelper "isSubReady", (sub) ->
  return FlowRouter.subsReady(sub) if sub
  return FlowRouter.subsReady()