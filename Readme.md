# Helpers for [FlowRouter](https://github.com/kadirahq/flow-router/)

Template helpers for meteorhacks:flow-router

- subsReady
- isSubReady (deprecated)
- pathFor
- urlFor
- queryParam

See [zimme:active-route](https://github.com/zimme/meteor-active-route) for using the following helpers

- isActiveRoute
- isActivePath
- isNotActiveRoute
- isNotActivePath


### Install
```sh
meteor add arillo:flow-router-helpers
```


### Usage subsReady

Checks whether your subscriptions are ready. You can pass multiple subscription names. If you don't pass a subscription name it will check for all subscriptions to be ready.

```html
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

```html
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

```html
<a href="{{pathFor '/post/:id' id=_id}}">Link to post</a>
<a href="{{pathFor 'postRouteName' id=_id}}">Link to post</a>
<a href="{{pathFor '/post/:id/comments/:cid' id=_id cid=comment._id}}">Link to comment in post</a>
<a href="{{pathFor '/post/:id/comments/:cid' id=_id cid=comment._id query='back=yes&more=true'}}">Link to comment in post with query params</a>
```

### Usage urlFor

Same as pathFor, returns absolute URL.

```
{{urlFor '/post/:id' id=_id}}
```

### Usage queryParam

Returns the value for a query parameter

```
<input placeholder="Search" value="{{queryParam 'query'}}">
```

## Changelog:
    
    0.4.0 - updated to use kadira:flow-router
    0.3.0 - changed isSubReady in favor of subsReady
