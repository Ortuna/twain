App.DrawerController = Ember.Controller.extend({
  needs: ['editor'],
  visible: false,
  show: function(){
    this.toggleProperty('visible');
  }
});

App.DrawerView = Ember.View.extend({
  tagName: 'div',
  classNames: ['drawer'],
  didInsertElement: function(){
    var view = this;
    $(window).resize(function(){
      view.fitToHeight();
    });
    view.fitToHeight();
  },
  fitToHeight: function(){
    var element = this.$();
    var windowHeight = $(window).height();
    element.height(windowHeight);
  },
  animateOpen: function(){
    if(!this.$()) { return; }
    this.$().stop();
    var visible  = this.get('controller.visible');
    var duration = 250;
    var easing   = 'swing';
    
    if(visible)
      this.$().animate({ width: '300px'}, duration, easing);
    else
     this.$().animate({ width: '0px'}, duration, easing);
  }.observes('controller.visible'),
});