package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class bettermounts extends MovieClip
   {
      
      public static var isMountEquipped:Boolean = false;
      
      public static var mnt_id:Number = 0;
      
      private static var mapFlag:Boolean = false;
       
      
      public function bettermounts()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var sES:String = null;
         var mnt:MovieClip = null;
         var mnt_i:* = undefined;
         var avt_eqp:* = undefined;
         if(optionHandler.bBetterMounts)
         {
            if(main.Game.world.myAvatar.pMC.artLoaded())
            {
               if(main.Game.world.myAvatar.objData.eqp.co.sFile == "ResAttire.swf" || main.Game.world.myAvatar.objData.eqp.co.sFile == "ResSportyWear.swf")
               {
                  return;
               }
               mnt = main.Game.world.myAvatar.pMC.mcChar.robe.getChildAt(0);
               for(mnt_i = 0; mnt_i < mnt.currentLabels.length; mnt_i++)
               {
                  trace(mnt.currentLabels[mnt_i].name);
                  if(mnt.currentLabels[mnt_i].name.indexOf("Walk") == 0)
                  {
                     trace("[DEBUG] IS MOUNT!");
                     isMountEquipped = true;
                     sES = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
                     mnt_id = !!main.Game.world.myAvatar.objData.eqp[sES] ? Number(main.Game.world.myAvatar.objData.eqp[sES].ItemID) : Number(main.Game.world.myAvatar.objData.eqp["ar"].ItemID);
                  }
               }
            }
         }
         else
         {
            if(isMountEquipped && main.Game.world.myAvatar.objData.eqp[sES].hasOwnProperty("relsFile"))
            {
               sES = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
               avt_eqp = main.Game.world.myAvatar.objData.eqp[sES];
               avt_eqp.sFile = avt_eqp.relsFile;
               avt_eqp.sLink = avt_eqp.relsLink;
               main.Game.world.myAvatar.loadMovieAtES(sES,avt_eqp.sFile,avt_eqp.sLink);
               delete avt_eqp.relsFile;
               delete avt_eqp.relsLink;
            }
            isMountEquipped = false;
            mnt_id = 0;
            if(mapFlag)
            {
               main.Game.world.map.removeEventListener(MouseEvent.CLICK,onWalkClick);
            }
            mapFlag = false;
         }
      }
      
      public static function onExtensionResponseHandler(e:*) : void
      {
         var dID:* = undefined;
         var avt:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var t_timer:Timer = null;
         if(!optionHandler.bBetterMounts)
         {
            return;
         }
         if(!main.Game || !main.Game.ui)
         {
            isMountEquipped = false;
            mnt_id = 0;
            return;
         }
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "initUserData":
               case "unequipItem":
               case "equipItem":
                  avt = main.Game.world.getAvatarByUserID(resObj.uid);
                  if(avt != null)
                  {
                     if(avt.isMyAvatar)
                     {
                        if("sES" in resObj || "strES" in resObj)
                        {
                           if(resObj.sES == "ar" || resObj.strES == "ar" || (resObj.sES == "co" || resObj.strES == "co"))
                           {
                              if("ItemID" in resObj)
                              {
                                 mnt_id = resObj.ItemID;
                              }
                              t_timer = new Timer(0);
                              t_timer.addEventListener(TimerEvent.TIMER,onMountArmorCheck,false,0,true);
                              t_timer.start();
                           }
                        }
                     }
                  }
            }
         }
      }
      
      public static function onTimerUpdate() : void
      {
         var avt_eqp:* = undefined;
         var mntAnimStr:String = null;
         if(!optionHandler.bBetterMounts || !main.Game.sfc.isConnected)
         {
            mapFlag = false;
            return;
         }
         if(!main.Game.world)
         {
            return;
         }
         if(!main.Game.world.myAvatar)
         {
            return;
         }
         if(!main.Game.world.mapLoadInProgress && !mapFlag)
         {
            main.Game.world.map.addEventListener(MouseEvent.CLICK,onWalkClick,false,0,true);
            mapFlag = true;
         }
         else if(main.Game.world.mapLoadInProgress && mapFlag)
         {
            mapFlag = false;
         }
         var sES:String = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
         if(isMountEquipped && main.Game.world.myAvatar.dataLeaf.intState != 1 && main.Game.world.myAvatar.objData.eqp[sES].hasOwnProperty("relsFile"))
         {
            avt_eqp = main.Game.world.myAvatar.objData.eqp[sES];
            avt_eqp.sFile = avt_eqp.relsFile;
            avt_eqp.sLink = avt_eqp.relsLink;
            main.Game.world.myAvatar.loadMovieAtES(sES,avt_eqp.sFile,avt_eqp.sLink);
            delete avt_eqp.relsFile;
            delete avt_eqp.relsLink;
            isMountEquipped = false;
            mnt_id = 0;
         }
         if(isMountEquipped)
         {
            mntAnimStr = "mountWalk";
            if(mnt_id == 47481)
            {
               mntAnimStr = "horseWalk";
            }
            if(optionHandler.filterChecks["chkBasicRiderAnim"])
            {
               mntAnimStr = "mountWalk";
            }
            if(optionHandler.filterChecks["chkHorseRiderAnim"])
            {
               mntAnimStr = "horseWalk";
            }
            if(main.Game.world.myAvatar.pMC.mcChar.onMove && main.Game.world.myAvatar.pMC.mcChar.currentLabel != mntAnimStr)
            {
               main.Game.world.myAvatar.pMC.mcChar.gotoAndPlay(mntAnimStr);
            }
         }
         else if(main.Game.world.myAvatar.pMC.mcChar.onMove && main.Game.world.myAvatar.pMC.mcChar.currentLabel != "Walk")
         {
            main.Game.world.myAvatar.pMC.mcChar.gotoAndPlay("Walk");
         }
      }
      
      public static function onWalkClick(e:*) : void
      {
         if(!isMountEquipped || main.Game.world.bPvP)
         {
            return;
         }
         if(e.target.hasOwnProperty("cntLinkage"))
         {
            return;
         }
         var aura:Object = null;
         var p:Point = null;
         var mvPT:* = undefined;
         var cLeaf:Object = main.Game.world.myAvatar.dataLeaf;
         for each(aura in cLeaf.auras)
         {
            try
            {
               if(aura.cat != null)
               {
                  if(aura.cat == "stun")
                  {
                     return;
                  }
                  if(aura.cat == "stone")
                  {
                     return;
                  }
                  if(aura.cat == "disabled")
                  {
                     return;
                  }
               }
            }
            catch(e:Error)
            {
               trace("world.onWalkClick > " + e);
               continue;
            }
         }
         p = new Point(e.currentTarget.mouseX,e.currentTarget.mouseY);
         if(e.currentTarget.mouseX >= 0 && e.currentTarget.mouseX <= 960 && e.currentTarget.mouseY >= 0 && e.currentTarget.mouseY <= 500)
         {
            p = main.Game.world.CHARS.globalToLocal(p);
            p.x = Math.round(p.x);
            p.y = Math.round(p.y);
            mvPT = main.Game.world.myAvatar.pMC.simulateTo(p.x,p.y,main.Game.world.WALKSPEED * 1.6);
            if(mvPT != null)
            {
               main.Game.world.myAvatar.pMC.walkTo(mvPT.x,mvPT.y,main.Game.world.WALKSPEED * 1.6);
            }
         }
      }
      
      public static function onMountArmorCheck(e:TimerEvent) : void
      {
         var mnt:MovieClip = null;
         var i:* = undefined;
         if(main.Game.world.myAvatar.pMC.artLoaded())
         {
            if(main.Game.world.myAvatar.objData.eqp.co.sFile == "ResAttire.swf" || main.Game.world.myAvatar.objData.eqp.co.sFile == "ResSportyWear.swf")
            {
               return;
            }
            mnt = main.Game.world.myAvatar.pMC.mcChar.robe.getChildAt(0);
            for(i = 0; i < mnt.currentLabels.length; i++)
            {
               trace(mnt.currentLabels[i].name);
               if(mnt.currentLabels[i].name.indexOf("Walk") == 0)
               {
                  trace("[DEBUG] IS MOUNT!");
                  isMountEquipped = true;
                  e.target.reset();
                  e.target.removeEventListener(TimerEvent.TIMER,onMountArmorCheck);
                  return;
               }
            }
            trace("[DEBUG] Not Mount");
            isMountEquipped = false;
            mnt_id = 0;
            e.target.reset();
            e.target.removeEventListener(TimerEvent.TIMER,onMountArmorCheck);
            return;
         }
      }
   }
}
