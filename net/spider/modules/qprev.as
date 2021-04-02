package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   import net.spider.draw.dRender;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class qprev extends MovieClip
   {
      
      public static var frame;
      
      public static var itemUI;
       
      
      public function qprev()
      {
         super();
      }
      
      public static function onFrameUpdate() : void
      {
         if(!optionHandler.qPrev || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(main.Game.ui.ModalStack.numChildren)
         {
            frame = main.Game.ui.ModalStack.getChildAt(0);
            if(getQualifiedClassName(frame) == "QFrameMC")
            {
               if(frame.cnt.core && frame.qData && frame.qData.reward)
               {
                  if(frame.cnt.core.rewardsStatic)
                  {
                     establishRender(frame.cnt.core.rewardsStatic);
                  }
                  if(frame.cnt.core.rewardsRoll)
                  {
                     establishRender(frame.cnt.core.rewardsRoll);
                  }
                  if(frame.cnt.core.rewardsChoice)
                  {
                     establishRender(frame.cnt.core.rewardsChoice);
                  }
                  if(frame.cnt.core.rewardsRandom)
                  {
                     establishRender(frame.cnt.core.rewardsRandom);
                  }
               }
            }
         }
      }
      
      public static function establishRender(core:*) : void
      {
         var s:* = undefined;
         var j:* = undefined;
         var k:* = undefined;
         for(var i:* = 1; i < core.numChildren; i++)
         {
            itemUI = core.getChildAt(i);
            if(!itemUI.hasEventListener(MouseEvent.CLICK))
            {
               loop1:
               for each(s in frame.qData.reward)
               {
                  if(s["ItemID"] == itemUI.ItemID)
                  {
                     for each(j in frame.qData.oRewards)
                     {
                        for each(k in j)
                        {
                           if(k.ItemID == s["ItemID"])
                           {
                              itemUI.addEventListener(MouseEvent.CLICK,onQuestItemRender(k),false,0,true);
                              break loop1;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function onQuestItemRender(item:Object) : Function
      {
         return function(e:MouseEvent):void
         {
            if(main.Game.ui.getChildByName("renderPreview"))
            {
               main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
            }
            var dRenderObj:* = new dRender(item);
            dRenderObj.name = "renderPreview";
            main.Game.ui.addChild(dRenderObj);
         };
      }
   }
}
