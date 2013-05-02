App = Ember.Application.create();

/* Basic info for setup */
App.name = 'Mark';
App.version = .1;


/* App store setup */
App.store = DS.Store.create({
  revision: 12,
  adapter: DS.RESTAdapter.create()
});
