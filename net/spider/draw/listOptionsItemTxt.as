package net.spider.draw
{
   import fl.controls.TextInput;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.spider.main;
   
   public class listOptionsItemTxt extends MovieClip
   {
       
      
      public var txtSearch:TextInput;
      
      public var txtName:TextField;
      
      public var btnActive:SimpleButton;
      
      public var sDesc:String;
      
      public function listOptionsItemTxt(sDesc:String)
      {
         super();
         this.sDesc = sDesc;
         this.btnActive.addEventListener(MouseEvent.CLICK,this.onActive,false,0,true);
         this.txtSearch.addEventListener(Event.CHANGE,this.onSearch,false,0,true);
      }
      
      public function onSearch(e:Event) : void
      {
         this.txtSearch.textField.setTextFormat(new TextFormat("Arial",16,16777215),this.txtSearch.textField.caretIndex - 1);
      }
      
      public function onActive(e:MouseEvent) : void
      {
         if(this.txtSearch.text.length < 1)
         {
            return;
         }
         var mcCharPage:charPage = new charPage(this.txtSearch.text);
         main.Game.ui.addChild(mcCharPage);
      }
   }
}
