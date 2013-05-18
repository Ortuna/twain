App.PreviewController = Ember.Controller.extend({
  needs: ['editor'],
  markdown: '',
  markdownBinding: Ember.Binding.oneWay('controllers.editor.markdown'),
  previewHTML: function(){
    return marked(this.get('markdown'));
  }.property('markdown'),
  setupPreview: function(){
    marked.setOptions({
      gfm: true,
      tables: true,
      breaks: true,
      pedantic: false,
      sanitize: false,
      smartLists: true,
    });
  }
});

App.PreviewView = Ember.View.extend({
  tagName: 'div',
  classNames: ['preview'],
  didInsertElement: function(){
    var view = this;
    view.controller.send('setupPreview');
    $(window).resize(function(){
      view.fitToHeight();
    });
    view.fitToHeight();
  },  
  fitToHeight: function(){
    var element = this.$();
    var windowHeight = $(window).height();
    element.height(windowHeight);
  }
});