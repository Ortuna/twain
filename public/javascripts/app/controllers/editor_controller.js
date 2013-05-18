App.EditorController = Ember.Controller.extend({
  markdown: '',
  setupAceEditor: function(){
    var editor = ace.edit("markdown");
    editor.setTheme("ace/theme/tomorrow_night");
    editor.getSession().setUseWorker(false);  
    editor.getSession().setMode("ace/mode/markdown");
    editor.getSession().setTabSize(2);
    editor.getSession().setUseWrapMode(true);

    controller = this;
    editor.getSession().on('change', function(e) {
      controller.set('markdown', editor.getValue());
    });    
    this.set('editor', editor);
  }
});


App.EditorView = Ember.View.extend({
  tagName: 'div',
  classNames: 'markdown',
  elementId: 'markdown',
  didInsertElement: function(){
    var view = this;
    view.controller.send('setupAceEditor');
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
})