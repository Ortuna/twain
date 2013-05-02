App.Book = DS.Model.extend({
  primaryKey: 'base_path',
  base_path: DS.attr('string')
});
