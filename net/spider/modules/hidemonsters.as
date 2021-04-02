package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class hidemonsters extends MovieClip
   {
       
      
      public function hidemonsters()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var mons:Array = null;
         var _m:* = undefined;
         if(!optionHandler.hideM)
         {
            if(!main.Game.world.strFrame)
            {
               return;
            }
            mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each(_m in mons)
            {
               if(_m)
               {
                  if(_m.pMC)
                  {
                     if(_m.pMC.getChildAt(1))
                     {
                        if(!_m.pMC.getChildAt(1).visible)
                        {
                           _m.pMC.getChildAt(1).visible = true;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var _m:* = undefined;
         if(!optionHandler.hideM || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         if(!main.Game.world.strFrame)
         {
            return;
         }
         var mons:Array = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
         for each(_m in mons)
         {
            if(_m)
            {
               if(_m.pMC)
               {
                  if(_m.pMC.getChildAt(1))
                  {
                     if(_m.pMC.getChildAt(1).visible)
                     {
                        trace("shadowed");
                        _m.pMC.getChildAt(1).visible = false;
                        _m.pMC.shadow.addEventListener(MouseEvent.CLICK,onClickHandler,false,0,true);
                        _m.pMC.shadow.mouseEnabled = true;
                        _m.pMC.shadow.buttonMode = true;
                     }
                  }
               }
            }
         }
      }
      
      public static function onClickHandler(e:MouseEvent) : void
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
