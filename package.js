Package.describe({
  git: 'https://github.com/arillo/meteor-flow-router-helpers.git',
  name: 'arillo:flow-router-helpers',
  summary: 'Template helpers for meteorhacks:flow-router, isActivePath, isNotActivePath, pathFor, isSubReady',
  version: '0.1.1'
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
    'meteorhacks:flow-router@1.1.1'
  ]);

  api.addFiles('client/helpers.coffee', 'client');
});