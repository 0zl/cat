package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class disquesttracker extends MovieClip
   {
       
      
      public function disquesttracker()
      {
         super();
      }
      
      public static function onTimerUpdate() : void
      {
         if(!optionHandler.bDisQuestTracker || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(main.Game.ui.mcQTracker.visible)
         {
            main.Game.ui.mcQTracker.visible = false;
         }
      }
   }
}
