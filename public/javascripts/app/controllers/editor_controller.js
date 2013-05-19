App.EditorController = Ember.Controller.extend({
  needs: ['preview'],
  markdown: function(){
    return this.get('section.content');
  }.property('section.content'),
  sectionObserver: function(){
    var editor     = this.get('editor');
    editor.setValue(this.get('section.content'));
    editor.navigateFileStart();
  }.observes('section'),
  setupAceEditor: function(){
    var controller = this;
    var editor     = ace.edit("markdown");
    editor.setTheme("ace/theme/tomorrow_night");
    editor.getSession().setUseWorker(false);  
    editor.getSession().setMode("ace/mode/markdown");
    editor.getSession().setTabSize(2);
    editor.getSession().setUseWrapMode(true);

    
    editor.getSession().on('change', function(e) {
      controller.set('section.content', editor.getValue());
    });    
    this.set('editor', editor);
  },
  loadSection: function(){
    var controller = this;
    App.Section.find(App.book_id, App.chapter_id, App.section_id).then(function(section){
      controller.set('section', section);
    });
  },
  viewDidLoad: function(){
    this.send('setupAceEditor');
    this.send('loadSection');
  },
  save: function(){
    this.get('section').save();
  },
});


App.EditorView = Ember.View.extend({
  tagName: 'div',
  classNames: 'markdown',
  elementId: 'markdown',
  didInsertElement: function(){
    var view = this;
    view.controller.send('viewDidLoad');
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
});