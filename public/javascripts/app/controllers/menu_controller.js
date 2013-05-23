App.MenuController = Ember.Controller.extend({
  needs: ['editor', 'preview', 'browser'],
});

App.MenuView = Ember.View.extend({
  classNameBindings: [':menu', 'active'],  
  active: false,
  mouseEnter: function(event) {
    this.fadeAndActive(1, true);
  },
  mouseLeave: function(event) {
    this.fadeAndActive(0.3, false);
  },
  didInsertElement: function(){
    this.$().fadeTo(0, 0.3);
  },
  fadeAndActive: function(opacity, active) {
    this.$().stop();
    this.$().fadeTo(500, opacity);
    this.set('active', active);    
  }
});
