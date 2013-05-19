App.Section = Ember.Object.extend({
  isSaving: false,
  markdown: function(){
    var code     = this.get('content');
    var markdown = code.match(/-{3,}\s([\s\S]*?)-{3,}\s([\s\S]*)/);
    if(markdown == null)
      return code;
    else
      return markdown[2];
  }.property('content'),
  metadata: function(){
    var code     = this.get('content');
    var markdown = code.match(/-{3,}\s([\s\S]*?)-{3,}\s([\s\S]*)/);
    if(markdown == null)
      return '';
    else
      return markdown[1];
  }.property('content'),
  save: function(){
    var model = this;
    var data = {
      section: {
        markdown: model.get('markdown'),
        metadata: model.get('metadata'),
      } 
    };
    console.debug(data);
    model.set('isSaving', true);
    $.post(model.get('save_path'), data, function(){
      model.set('isSaving', false);
    }).done(function(){ console.debug('worked!'); })
      .fail(function(){ console.debug('didnt work!'); })
  }
});

App.Section.reopenClass({
  find: function(book_id, chapter_id, section_id) {
    var url = "/api/v1/books/" + book_id + "/chapters/" + chapter_id + "/sections/" + section_id;
    return $.getJSON(url).then(function(section){
      section = section.section;
      section.save_path = url;
      delete section['markdown'];
      delete section['metadata'];
      return App.Section.create(section);
    });
  }
})
