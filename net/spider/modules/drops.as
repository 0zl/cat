package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class drops extends MovieClip
   {
      
      static var incr:int = 0;
       
      
      public function drops()
      {
         super();
      }
      
      public static function customDropsEnabled() : Boolean
      {
         return optionHandler.cDrops || optionHandler.sbpcDrops;
      }
      
      public static function getDropUI() : *
      {
         return !!customDropsEnabled() ? main.Game.ui.getChildByName("dsUI") : main.Game.ui.dropStack;
      }
      
      public static function onExtensionResponseHandler(e:*) : void
      {
         var dID:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var itemA:MovieClip = null;
         var itemB:MovieClip = null;
         var i:* = undefined;
         if(!optionHandler.draggable)
         {
            return;
         }
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "dropItem":
                  if(customDropsEnabled())
                  {
                     return;
                  }
                  if(main.Game.ui.dropStack.numChildren <= 2)
                  {
                     return;
                  }
                  i = main.Game.ui.dropStack.numChildren - 2;
                  while(i > -1)
                  {
                     itemA = main.Game.ui.dropStack.getChildAt(i) as MovieClip;
                     itemB = main.Game.ui.dropStack.getChildAt(i + 1) as MovieClip;
                     itemA.fY = itemA.y = itemB.fY - (itemB.fHeight + 8);
                     itemB.fX = (main.Game.ui.dropStack.getChildAt(0) as MovieClip).fX;
                     itemB.x = (main.Game.ui.dropStack.getChildAt(0) as MovieClip).x;
                     i--;
                  }
                  break;
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var mcDrop:* = undefined;
         if(!optionHandler.draggable || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(!main.Game.ui)
         {
            return;
         }
         try
         {
            if(getDropUI().numChildren < 1)
            {
               return;
            }
         }
         catch(exception:*)
         {
            return;
         }
         for(var i:int = 0; i < getDropUI().numChildren; i++)
         {
            try
            {
               mcDrop = getDropUI().getChildAt(i) as MovieClip;
               if(!mcDrop.hasEventListener(MouseEvent.MOUSE_DOWN))
               {
                  mcDrop.addEventListener(MouseEvent.MOUSE_DOWN,drops.startDrag,false,0,true);
                  mcDrop.addEventListener(MouseEvent.MOUSE_UP,drops.stopDrag,false,0,true);
               }
            }
            catch(exception:*)
            {
               trace("Error handling drops: " + exception);
               continue;
            }
         }
      }
      
      private static function startDrag(e:MouseEvent) : void
      {
         e.currentTarget.startDrag();
      }
      
      private static function stopDrag(e:MouseEvent) : void
      {
         e.currentTarget.stopDrag();
      }
   }
}
