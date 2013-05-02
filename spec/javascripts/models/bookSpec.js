//http://stackoverflow.com/questions/12386913/ember-data-fixture-adapter
describe('Book', function(){

  beforeEach(function(){
    /* Setup localstorage adapter */
    window.App.store = DS.Store.create({
      revision: 12,
      adapter: DS.FixtureAdapter.create()
    });
    app = window.App;
  });

  afterEach(function(){

  });

  function clearDB(){
    localStorage.clear();
  }

  it('has the Book variable', function(){
    expect(app.Book).toBeDefined();
  });

  it('gets a list of books', function(){
    window.App.Book.FIXTURES = [
      {id: 'xyz', base_path: 'sample_book'},
      {id: 'abc', base_path: 'sample_book2'}
    ];

    books = null;
    runs(function(){
      books = App.store.findAll(App.Book);
    }, 'finding books');

    waitsFor(function(){
      console.debug(books);
      return books.content.length == 2;
    }, 'books to be returned', 100);
  });

});
