describe('Ember application', function(){

  beforeEach(function(){
    app = window.App;
  });

  it('has the application variable', function(){
    expect(app).toBeDefined();
  });

  it('has a app name and version', function(){
    expect(app.version).toBeDefined();
    expect(app.name).toEqual('Mark');
  });

});
