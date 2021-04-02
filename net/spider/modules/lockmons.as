package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class lockmons extends MovieClip
   {
       
      
      public function lockmons()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var mons:Array = null;
         var _m:* = undefined;
         if(!optionHandler.lockm)
         {
            mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each(_m in mons)
            {
               if(_m)
               {
                  if(_m.pMC)
                  {
                     if(_m.pMC.noMove)
                     {
                        _m.pMC.noMove = false;
                     }
                  }
               }
            }
         }
      }
      
      public static function onTimerUpdate() : void
      {
         var _m:* = undefined;
         if(!optionHandler.lockm || !main.Game.sfc.isConnected || !main.Game.world.strFrame)
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
                  if(!_m.pMC.noMove)
                  {
                     _m.pMC.noMove = true;
                  }
               }
            }
         }
      }
   }
}
