package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class transquest extends MovieClip
   {
       
      
      public function transquest()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var q_frame:* = undefined;
         if(main.Game.ui)
         {
            if(main.Game.ui.ModalStack.numChildren > 0)
            {
               q_frame = main.Game.ui.ModalStack.getChildAt(0);
               if(getQualifiedClassName(q_frame) == "QFrameMC")
               {
                  if(!optionHandler.bTransQuest && q_frame.alpha != 1)
                  {
                     q_frame.alpha = 1;
                     main.Game.ui.ModalStack.mouseEnabled = main.Game.ui.ModalStack.mouseChildren = true;
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var q_frame:* = undefined;
         if(!optionHandler.bTransQuest || !main.Game || !main.Game.ui || !main.Game.ui.ModalStack)
         {
            return;
         }
         if(main.Game.ui.ModalStack.numChildren > 0)
         {
            q_frame = main.Game.ui.ModalStack.getChildAt(0);
            if(getQualifiedClassName(q_frame) == "QFrameMC")
            {
               if(main.Game.world.myAvatar.dataLeaf.intState > 1 && q_frame.alpha > 0.5)
               {
                  q_frame.alpha -= 0.05;
                  main.Game.ui.ModalStack.mouseEnabled = main.Game.ui.ModalStack.mouseChildren = false;
               }
               else if(main.Game.world.myAvatar.dataLeaf.intState == 1 && q_frame.alpha != 1)
               {
                  q_frame.alpha = 1;
                  main.Game.ui.ModalStack.mouseEnabled = main.Game.ui.ModalStack.mouseChildren = true;
               }
            }
         }
      }
   }
}
