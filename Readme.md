# Helpers for [FlowRouter](https://github.com/kadirahq/flow-router/)

***THIS PROJECT IS DEPRECATING*** and not mantained anymore. If you are interested in mainting it just send us an e-mail.

Template helpers for kadira:flow-router

- subsReady
- isSubReady (deprecated)
- pathFor
- urlFor
- param
- queryParam
- currentRouteName
- currentRouteOption

Content blocks

- linkTo

See [zimme:active-route](https://github.com/zimme/meteor-active-route) for using the following helpers

- isActiveRoute
- isActivePath
- isNotActiveRoute
- isNotActivePath

On the server it exports FlowRouterHelpers, with:

- urlFor
- pathFor

### Install
```sh
meteor add arillo:flow-router-helpers
```

### Demo
[https://flowrouterhelpers.meteor.com](https://flowrouterhelpers.meteor.com)

### Examples
[https://github.com/arillo/meteor-flow-router-helpers-example](https://github.com/arillo/meteor-flow-router-helpers-example)

### Usage subsReady

If you call subsReady without parameters it will check for all flow-router subscriptions to be ready. (It will not take into account the template level subscriptions you define)

If you pass parameters it will just check for this specific flow-router subscriptions to be ready. The parameters would be the subscription names you used when registering them on FlowRouter, like:

```js
FlowRouter.route('/posts', {
    subscriptions: function(params, queryParams) {
        this.register('posts', Meteor.subscribe('posts'));
        this.register('items', Meteor.subscribe('items'));
    }
});
```

```handlebars
{{#if subsReady 'items' 'posts'}}
  <ul>
  {{#each items}}
    <li>{{title}}</li>
  {{/each}}
  </ul>
  <ul>
  {{#each posts}}
    <li>{{title}}</li>
  {{/each}}
  </ul>
{{/if}}
```


### Usage isSubReady (deprecated)

Checks whether your subscription is ready. If you don't pass a subscription name it will check for all subscriptions.

```handlebars
{{#if isSubReady 'items'}}
  <ul>
  {{#each items}}
    <li>{{title}}</li>
  {{/each}}
  </ul>
{{/if}}
```

### Usage pathFor

Used to build a path to your route. First parameter can be either the path definition or, since version 1.2.0 of flow-router, the name you assigned the route. After that you can pass the params needed to construct the path. Query parameters can be passed with the query parameter.

__Notice:__ To deparameterize the query string we are currently using the not yet official accessor for the query lib in page.js via FlowRouter._qs

```handlebars
<a href="{{pathFor '/post/:id' id=_id}}">Link to post</a>
<a href="{{pathFor 'postRouteName' id=_id}}">Link to post</a>
<a href="{{pathFor '/post/:id/comments/:cid' id=_id cid=comment._id}}">Link to comment in post</a>
<a href="{{pathFor '/post/:id/comments/:cid' id=_id cid=comment._id query='back=yes&more=true'}}">Link to comment in post with query params</a>
```

Server side it can be used like this:
```FlowRouterHelpers.pathFor('/post/:id',{ id:'12345' })```


### Usage urlFor

Same as pathFor, returns absolute URL.

```handlebars
{{urlFor '/post/:id' id=_id}}
```

### Usage linkTo

Custom content block for creating a link

```handlebars
{{#linkTo '/posts/'}}
  Go to posts
{{/linkTo}}
```

will return ```<a href="/posts/">Go to posts</a>```

### Usage param

Returns the value for a url parameter

```handlebars
<div>ID of this post is <em>{{param 'id'}}</em></div>
```

### Usage queryParam

Returns the value for a query parameter

```handlebars
<input placeholder="Search" value="{{queryParam 'query'}}">
```

### Usage currentRouteName

Returns the name of the current route

```handlebars
<div class={{currentRouteName}}>
  ...
</div>
```
### Usage currentRouteOption

This adds support to get options from flow router

```javascript
FlowRouter.route("name", {
  name: "yourRouteName",
  action() {
    BlazeLayout.render("layoutTemplate", {main: "main"});
  },
  coolOption: "coolOptionValue"
});
```

```handlebars
<div class={{currentRouteOption 'customRouteOption'}}>
  ...
</div>
```

## Changelog:
    0.5.2 - Add currentRouteOption
    0.5.0 - Add linkTo custom content block. Allow use of pathFor & urlFor on the server
    0.4.6 - Add hashbang option to pathFor
    0.4.4 - added currentRouteName helper
    0.4.3 - added param helper
    0.4.0 - updated to use kadira:flow-router
    0.3.0 - changed isSubReady in favor of subsReady
