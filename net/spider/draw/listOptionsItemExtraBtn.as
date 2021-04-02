package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.spider.handlers.optionHandler;
   
   public class listOptionsItemExtraBtn extends MovieClip
   {
       
      
      public var txtName:TextField;
      
      public var btnActive:SimpleButton;
      
      public var sDesc:String;
      
      public function listOptionsItemExtraBtn(sDesc:String)
      {
         super();
         this.sDesc = sDesc;
         this.btnActive.addEventListener(MouseEvent.CLICK,this.onActive,false,0,true);
      }
      
      public function onActive(e:MouseEvent) : void
      {
         optionHandler.cmd(this.txtName.text);
      }
   }
}
