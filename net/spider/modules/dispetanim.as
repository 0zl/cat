package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class dispetanim extends MovieClip
   {
       
      
      public function dispetanim()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.bDisPetAnim)
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(main.Game.world.avatars[playerMC].objData)
               {
                  if(main.Game.world.avatars[playerMC].petMC)
                  {
                     try
                     {
                        main.Game.world.avatars[playerMC].petMC.mcChar.gotoAndStop(0);
                        movieClipStopAll(main.Game.world.avatars[playerMC].petMC.mcChar);
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
         if(!optionHandler.bDisPetAnim || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            if(main.Game.world.avatars[playerMC].objData)
            {
               if(optionHandler.filterChecks["chkDisPetAnim"])
               {
                  if(main.Game.world.avatars[playerMC].isMyAvatar)
                  {
                     continue;
                  }
               }
               if(main.Game.world.avatars[playerMC].petMC && main.Game.world.avatars[playerMC].petMC.mcChar)
               {
                  try
                  {
                     main.Game.world.avatars[playerMC].petMC.mcChar.gotoAndStop(0);
                     movieClipStopAll(main.Game.world.avatars[playerMC].petMC.mcChar);
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
