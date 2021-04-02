package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class dischatscroll extends MovieClip
   {
       
      
      public function dischatscroll()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         if(optionHandler.bDisChatScroll)
         {
            main.Game.addEventListener(MouseEvent.MOUSE_WHEEL,onDisableWheel,false,0,true);
         }
         else
         {
            main.Game.removeEventListener(MouseEvent.MOUSE_WHEEL,onDisableWheel);
         }
      }
      
      public static function onDisableWheel(e:MouseEvent) : void
      {
         e.stopPropagation();
      }
   }
}
