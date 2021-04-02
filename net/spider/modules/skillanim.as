package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class skillanim extends MovieClip
   {
       
      
      public function skillanim()
      {
         super();
      }
      
      public static function onTimerUpdate() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.disableSkillAnim || !main.Game.sfc.isConnected || !main.Game.world.myAvatar || !main.Game.world.myAvatar.pMC.spFX)
         {
            return;
         }
         if(main.Game.world.avatars.length < 2 && !optionHandler.filterChecks["chkSelfOnly"])
         {
            main.Game.world.myAvatar.pMC.spFX.strl = "";
         }
         else
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(optionHandler.filterChecks["chkSelfOnly"])
               {
                  if(main.Game.world.avatars[playerMC].isMyAvatar)
                  {
                     continue;
                  }
               }
               if(main.Game.world.avatars[playerMC].pMC)
               {
                  main.Game.world.avatars[playerMC].pMC.spFX.strl = "";
               }
            }
         }
      }
   }
}
