App.BrowserController = Ember.Controller.extend({
  needs: ['editor'],
  visible: false,
  show: function(){
    this.toggleProperty('visible');
  }
});

App.BrowserView = Ember.View.extend({
  tagName: 'div',
  classNames: ['browser'],
  didInsertElement: function(){
    var view = this;
    $(window).resize(function(){ view.centerView(); });
    view.centerView();
  },
  centerView: function(){
    var $element = this.$();
    var windowHeight = $(window).height();
    var windowWidth  = $(window).width();

    var elementHeight = $element.height();
    var elementWidth  = $element.width();
    
    $element.css('top',   (windowHeight/2) - (elementHeight/2) + 'px');
    $element.css('left',  (windowWidth/2)  - (elementWidth/2)  + 'px');
    
  },
  // animateOpen: function(){
  //   if(!this.$()) { return; }
  //   this.$().stop();
  //   var visible  = this.get('controller.visible');
  //   var duration = 250;
  //   var easing   = 'swing';
    
  //   if(visible)
  //     this.$().animate({ width: '250px'}, duration, easing);
  //   else
  //    this.$().animate({ width: '0px'}, duration, easing);
  // }.observes('controller.visible'),
});
