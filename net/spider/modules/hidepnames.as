package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class hidepnames extends MovieClip
   {
      
      static var mouseOverAvatar;
       
      
      public function hidepnames()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.hideP)
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(main.Game.world.avatars[playerMC].pMC)
               {
                  main.Game.world.avatars[playerMC].pMC.pname.visible = true;
                  main.Game.world.avatars[playerMC].pMC.pname.ti.visible = true;
                  main.Game.world.avatars[playerMC].pMC.pname.tg.visible = true;
               }
            }
         }
      }
      
      public static function onMouseAvatarOver(e:*) : void
      {
         mouseOverAvatar = e.currentTarget.parent.pname.ti.text;
      }
      
      public static function onMouseAvatarOut(e:*) : void
      {
         mouseOverAvatar = "";
      }
      
      public static function onFrameUpdate() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.hidePNames || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            if(main.Game.world.avatars[playerMC].objData)
            {
               if(optionHandler.filterChecks["chkGuild"])
               {
                  if(main.Game.world.avatars[playerMC].pMC.pname.tg.visible && mouseOverAvatar != main.Game.world.avatars[playerMC].pMC.pname.ti.text)
                  {
                     main.Game.world.avatars[playerMC].pMC.pname.tg.visible = false;
                  }
                  else if(!main.Game.world.avatars[playerMC].pMC.pname.tg.visible && main.Game.world.avatars[playerMC].pMC.pname.ti.text == mouseOverAvatar)
                  {
                     main.Game.world.avatars[playerMC].pMC.pname.tg.visible = true;
                  }
               }
               else if(main.Game.world.avatars[playerMC].pMC.pname.visible && mouseOverAvatar != main.Game.world.avatars[playerMC].pMC.pname.ti.text)
               {
                  main.Game.world.avatars[playerMC].pMC.pname.visible = false;
               }
               else if(!main.Game.world.avatars[playerMC].pMC.pname.visible && main.Game.world.avatars[playerMC].pMC.pname.ti.text == mouseOverAvatar)
               {
                  main.Game.world.avatars[playerMC].pMC.pname.visible = true;
               }
               if(!main.Game.world.avatars[playerMC].dataLeaf.hasMouseOverEvent)
               {
                  try
                  {
                     main.Game.world.avatars[playerMC].pMC.mcChar.addEventListener(MouseEvent.ROLL_OVER,onMouseAvatarOver,false,0,true);
                     main.Game.world.avatars[playerMC].pMC.mcChar.addEventListener(MouseEvent.ROLL_OUT,onMouseAvatarOut,false,0,true);
                     main.Game.world.avatars[playerMC].dataLeaf.hasMouseOverEvent = true;
                  }
                  catch(exception:*)
                  {
                  }
               }
            }
         }
      }
   }
}
