App = Ember.Application.create({
  rootElement: '.container .content'
});

App.Store = DS.Store.extend({
  revision: 12,
});