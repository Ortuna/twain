describe('Section', function(){

  var section  = null;
  var content  = "----\n";
      content += "title: test title\n";
      content += "----\n";

  beforeEach(function(){
    section = App.Section.create({});
  }); 

  it('loads properly', function(){
    expect(section).not.toBeUndefined();
  });

  describe('#markdown', function(){

    it('computes markdown correctly when only markdown is present', function(){
      section.set('content', '#some-test');
      expect(section.get('markdown')).toEqual('#some-test');
    });

    it('computes markdown correctly when metada is present with markdown', function(){
      var contentWithMarkdown = content + "#more-markdown";
      section.set('content', contentWithMarkdown);
      expect(section.get('markdown')).toEqual('#more-markdown');
    });

    it('returns an empty string when markdown is not present', function(){
      section.set('content', content);
      expect(section.get('markdown')).toEqual('');
    });

  });

  describe('#metadata', function(){

    it('computes metadata correctly without markdown present', function(){
      section.set('content', content);
      expect(section.get('metadata')).toEqual("title: test title\n");
    });

   it('computes metadata correctly with markdown present', function(){
      var contentWithMarkdown = content + "#more-markdown";
      section.set('content', contentWithMarkdown);
      expect(section.get('metadata')).toEqual("title: test title\n");
    }); 

   it('returns an empty string when metadata is not present', function(){
      section.set('content', '#some-test');
      expect(section.get('metadata')).toEqual('');
   });

  });

});
