package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class dismonanim extends MovieClip
   {
       
      
      public function dismonanim()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var monsterMC:* = undefined;
         if(!optionHandler.disMonAnim)
         {
            for(monsterMC in main.Game.world.monsters)
            {
               if(!(!main.Game.world.monsters[monsterMC].dataLeaf && main.Game.world.monsters[monsterMC].dataLeaf.strFrame != main.Game.world.strFrame))
               {
                  if(main.Game.world.monsters[monsterMC].pMC)
                  {
                     if(main.Game.world.monsters[monsterMC].dataLeaf.intState > 0)
                     {
                        try
                        {
                           main.Game.world.monsters[monsterMC].pMC.gotoAndPlay(0);
                           movieClipPlayAll(main.Game.world.monsters[monsterMC].pMC as MovieClip);
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
      
      public static function onFrameUpdate() : void
      {
         var monsterMC:* = undefined;
         if(!optionHandler.disMonAnim || !main.Game.sfc.isConnected || !main.Game.world.monsters)
         {
            return;
         }
         for(monsterMC in main.Game.world.monsters)
         {
            if(!(!main.Game.world.monsters[monsterMC].dataLeaf && main.Game.world.monsters[monsterMC].dataLeaf.strFrame != main.Game.world.strFrame))
            {
               if(main.Game.world.monsters[monsterMC].pMC)
               {
                  if(main.Game.world.monsters[monsterMC].dataLeaf.intState > 0)
                  {
                     try
                     {
                        main.Game.world.monsters[monsterMC].pMC.getChildAt(1).gotoAndStop("Idle");
                        movieClipStopAll(main.Game.world.monsters[monsterMC].pMC.getChildAt(1) as MovieClip);
                     }
                     catch(exception:*)
                     {
                     }
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
               if(getQualifiedClassName(container.getChildAt(i) as MovieClip).indexOf("Display") <= -1)
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
      }
      
      public static function movieClipPlayAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               if(getQualifiedClassName(container.getChildAt(i) as MovieClip).indexOf("Display") <= -1)
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
}
