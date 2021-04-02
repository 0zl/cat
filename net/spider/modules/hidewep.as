package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class hidewep extends MovieClip
   {
       
      
      public function hidewep()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.bHideWep)
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(main.Game.world.avatars[playerMC].pMC)
               {
                  if(!main.Game.world.avatars[playerMC].pMC.mcChar.weapon.visible)
                  {
                     main.Game.world.avatars[playerMC].pMC.mcChar.weapon.visible = true;
                     if(main.Game.world.avatars[playerMC].pMC.pAV.getItemByEquipSlot("Weapon").sType == "Dagger")
                     {
                        main.Game.world.avatars[playerMC].pMC.mcChar.weaponOff.visible = true;
                     }
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var playerMC:* = undefined;
         var target_mc:* = undefined;
         if(!optionHandler.bHideWep || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            target_mc = main.Game.world.avatars[playerMC];
            if(optionHandler.filterChecks["chkHideOtherWep"] || !optionHandler.filterChecks["chkHideOtherWep"] && target_mc.isMyAvatar)
            {
               if(target_mc.pMC)
               {
                  if(target_mc.pMC.mcChar.weapon.visible && target_mc.dataLeaf.intState < 2)
                  {
                     target_mc.pMC.mcChar.weapon.visible = false;
                     target_mc.pMC.mcChar.weaponOff.visible = false;
                  }
                  else if(!target_mc.pMC.mcChar.weapon.visible && target_mc.dataLeaf.intState > 1)
                  {
                     target_mc.pMC.mcChar.weapon.visible = true;
                     if(target_mc.pMC.pAV.getItemByEquipSlot("Weapon").sType == "Dagger")
                     {
                        target_mc.pMC.mcChar.weaponOff.visible = true;
                     }
                  }
               }
            }
         }
      }
   }
}
