

  // marked.setOptions({
  //   gfm: true,
  //   tables: true,
  //   breaks: true,
  //   pedantic: false,
  //   sanitize: false,
  //   smartLists: true,
  // });

  // editor.getSession().on('change', function(e) {
  //   updatePreview(editor.getValue());
  // });


  // var $markdown  = null;
  // var $preview = null;
  // var $gutter  = null;
  // var padding  = 0;

  // $(window).resize(function(){
  //   windowResized();
  // });

  // function windowResized(){
  //   var height  = $(window).height() - padding;
  //   updatePaneHeights(height);
  // }

  // function updatePaneHeights(height) {
  //   $preview.height(height);
  //   $markdown.height(height);
  //   $gutter.height(height);
  // }

  // function updatePreview(code){
  //   var markdown = code.match(/-{3,}\s([\s\S]*?)-{3,}\s([\s\S]*)/)
  //   if(markdown == null)
  //     markdown = code
  //   else
  //     markdown = markdown[2]

  //   $preview.html( marked(code) );
  // }

  // $(document).ready(function(){
  //   $markdown = $(".markdown");
  //   $preview  = $(".preview");
  //   $gutter   = $(".gutter");

  //   padding = $preview.css('padding').match(/\d+/)[0];

  //   updatePreview( editor.getValue() );
  //   windowResized();
   
  // });