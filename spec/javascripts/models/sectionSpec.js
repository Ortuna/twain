//http://stackoverflow.com/questions/12386913/ember-data-fixture-adapter
describe('Section', function(){
  it('works', function(){
    var section = App.Section.create({});
    expect(section).not.toBeUndefined();
  });
});
