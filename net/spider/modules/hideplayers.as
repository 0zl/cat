package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class hideplayers extends MovieClip
   {
       
      
      public function hideplayers()
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
               if(!main.Game.world.avatars[playerMC].isMyAvatar && main.Game.world.avatars[playerMC].pMC)
               {
                  if(!main.Game.world.avatars[playerMC].pMC.mcChar.visible)
                  {
                     main.Game.world.avatars[playerMC].pMC.mcChar.visible = true;
                     main.Game.world.avatars[playerMC].pMC.pname.visible = true;
                     main.Game.world.avatars[playerMC].pMC.shadow.visible = true;
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.hideP || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            if(!main.Game.world.avatars[playerMC].isMyAvatar && main.Game.world.avatars[playerMC].pMC)
            {
               if(main.Game.world.avatars[playerMC].pMC.mcChar.visible)
               {
                  main.Game.world.avatars[playerMC].pMC.mcChar.visible = false;
                  if(!optionHandler.filterChecks["chkName"])
                  {
                     main.Game.world.avatars[playerMC].pMC.pname.visible = false;
                  }
                  if(optionHandler.filterChecks["chkShadow"])
                  {
                     trace("shadowed");
                     main.Game.world.avatars[playerMC].pMC.shadow.addEventListener(MouseEvent.CLICK,onClickHandler,false,0,true);
                     main.Game.world.avatars[playerMC].pMC.shadow.mouseEnabled = true;
                     main.Game.world.avatars[playerMC].pMC.shadow.buttonMode = true;
                  }
                  else
                  {
                     main.Game.world.avatars[playerMC].pMC.shadow.visible = false;
                  }
               }
            }
         }
      }
      
      private static function onClickHandler(e:MouseEvent) : void
      {
         var tAvt:* = undefined;
         tAvt = e.currentTarget.parent.pAV;
         if(e.shiftKey)
         {
            main.Game.world.onWalkClick();
         }
         else if(!e.ctrlKey)
         {
            if(tAvt != main.Game.world.myAvatar && main.Game.world.bPvP && tAvt.dataLeaf.pvpTeam != main.Game.world.myAvatar.dataLeaf.pvpTeam && tAvt == main.Game.world.myAvatar.target)
            {
               main.Game.world.approachTarget();
            }
            else if(tAvt != main.Game.world.myAvatar.target)
            {
               main.Game.world.setTarget(tAvt);
            }
         }
      }
   }
}
