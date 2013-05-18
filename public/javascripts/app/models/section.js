App.Section = Ember.Object.extend({});

App.Section.reopenClass({
  find: function(book_id, chapter_id, section_id) {
    var url = "/api/v1/books/" + book_id + "/chapters/" + chapter_id + "/sections/" + section_id;
    return $.getJSON(url).then(function(section){
      section = section.section;
      return App.Section.create(section);
    });
  }  
});