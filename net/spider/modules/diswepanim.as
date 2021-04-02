package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class diswepanim extends MovieClip
   {
       
      
      public function diswepanim()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.disWepAnim)
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(main.Game.world.avatars[playerMC].objData)
               {
                  if(main.Game.world.avatars[playerMC].pMC)
                  {
                     try
                     {
                        main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndPlay(0);
                        (main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndPlay(0);
                        movieClipPlayAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
                        movieClipPlayAll(main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip);
                     }
                     catch(exception:*)
                     {
                     }
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.disWepAnim || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            if(main.Game.world.avatars[playerMC].objData)
            {
               if(optionHandler.filterChecks["chkDisWepAnim"])
               {
                  if(main.Game.world.avatars[playerMC].isMyAvatar)
                  {
                     continue;
                  }
               }
               if(main.Game.world.avatars[playerMC].pMC.isLoaded && main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon)
               {
                  try
                  {
                     main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon.gotoAndStop(0);
                     (main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndStop(0);
                     movieClipStopAll(main.Game.world.avatars[playerMC].pMC.mcChar.weapon.mcWeapon);
                     movieClipStopAll(main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.getChildAt(0) as MovieClip);
                  }
                  catch(exception:*)
                  {
                  }
               }
            }
         }
      }
      
      public static function movieClipStopAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               try
               {
                  (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                  movieClipStopAll(container.getChildAt(i) as MovieClip);
               }
               catch(exception:*)
               {
               }
            }
         }
      }
      
      public static function movieClipPlayAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               try
               {
                  (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                  movieClipPlayAll(container.getChildAt(i) as MovieClip);
               }
               catch(exception:*)
               {
               }
            }
         }
      }
   }
}
