var Choosy = {
  externalopenlink: function(){
  	try{window.location = 'x-choosy://prompt.all/'+gContextMenu.linkURL;}catch(e){dump("Choosy Launch Failed: "+e)}
  },
  setup: function(){
    Choosy.menu = document.getElementById("contentAreaContextMenu");
    try { 
      Choosy.menu.addEventListener("popupshowing", setupLink, false);
    } catch(e) { dump("Choosy Setup Failed: " + e);}
  },
  setupLink:function(){
    gContextMenu.showItem( "context-externalopenlink", gContextMenu.onSaveableLink || ( gContextMenu.inDirList && gContextMenu.onLink ) );
  }
};

window.addEventListener("load", Choosy.setup, false);
