package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class untargetself extends MovieClip
   {
       
      
      public function untargetself()
      {
         super();
      }
      
      public static function onTimerUpdate() : void
      {
         if(!optionHandler.selfTarget || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         if(main.Game.world.myAvatar.target)
         {
            if(main.Game.world.myAvatar.target.isMyAvatar)
            {
               main.Game.world.cancelTarget();
            }
         }
      }
   }
}
