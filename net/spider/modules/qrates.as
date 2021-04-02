package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class qrates extends MovieClip
   {
      
      public static var doneOnce:Boolean = false;
       
      
      public function qrates()
      {
         super();
      }
      
      public static function onFrameUpdate() : void
      {
         var frame:* = undefined;
         var i:Number = NaN;
         var rItem:* = undefined;
         var s:* = undefined;
         if(!optionHandler.qRates || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(main.Game.ui.ModalStack.numChildren)
         {
            frame = main.Game.ui.ModalStack.getChildAt(0);
            if(getQualifiedClassName(frame) == "QFrameMC")
            {
               if(frame.cnt.core)
               {
                  if(!frame.cnt.core.rewardsRoll)
                  {
                     return;
                  }
                  for(i = 1; i < frame.cnt.core.rewardsRoll.numChildren; i++)
                  {
                     rItem = frame.cnt.core.rewardsRoll.getChildAt(i);
                     if(rItem.strType.text.indexOf("%") < 0)
                     {
                        for each(s in frame.qData.reward)
                        {
                           if(s["ItemID"] == rItem.ItemID)
                           {
                              if(rItem.strQ.visible)
                              {
                                 if(s["iQty"].toString() != rItem.strQ.text.substring(1))
                                 {
                                    continue;
                                 }
                              }
                              rItem.strType.text += " (" + s["iRate"] + "%)";
                              rItem.strType.width = 100;
                              rItem.strRate.visible = false;
                              break;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
