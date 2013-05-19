//http://stackoverflow.com/questions/12386913/ember-data-fixture-adapter
describe('Section', function(){
  it('loads properly', function(){
    var section = App.Section.create({});
    expect(section).not.toBeUndefined();
  });

});
