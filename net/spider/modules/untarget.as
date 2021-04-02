package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class untarget extends MovieClip
   {
       
      
      public function untarget()
      {
         super();
      }
      
      public static function onTimerUpdate() : void
      {
         if(!optionHandler.untargetMon || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         if(main.Game.world.myAvatar.target)
         {
            if(main.Game.world.myAvatar.target.dataLeaf.intState == 0)
            {
               main.Game.world.cancelTarget();
            }
         }
      }
   }
}
