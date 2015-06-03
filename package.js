Package.describe({
  git: 'https://github.com/arillo/meteor-flow-router-helpers.git',
  name: 'arillo:flow-router-helpers',
  summary: 'Template helpers for meteorhacks:flow-router, pathFor, urlFor, isSubReady and zimme:active-route helpers',
  version: '0.2.0'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');

  api.use([
    'check',
    'coffeescript',
    'templating',
    'underscore'
  ]);

  api.use([
    'meteorhacks:flow-router@1.8.0',
    'zimme:active-route@2.0.0'
  ], ['client', 'server']);

  api.imply('zimme:active-route', ['client', 'server']);

  api.addFiles('client/helpers.coffee', 'client');
});