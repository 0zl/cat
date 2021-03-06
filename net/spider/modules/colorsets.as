package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.draw.colorSets;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class colorsets extends MovieClip
   {
      
      private static var performOnceFlag:Boolean;
      
      private static var performOnceFlag2:Boolean;
      
      private static var _menu:colorSets;
       
      
      public function colorsets()
      {
         super();
      }
      
      public static function onFrameUpdate() : void
      {
         if(!optionHandler.bColorSets || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(main.Game.ui.mcPopup.getChildByName("mcCustomizeArmor") && !performOnceFlag)
         {
            if(!main.Game.ui.mcPopup.mcCustomizeArmor.getChildByName("colorSets"))
            {
               _menu = new colorSets();
               _menu.mode = "mcCustomizeArmor";
               _menu.name = "colorSets";
               _menu.y += main.Game.ui.mcPopup.mcCustomizeArmor.height + 12;
               _menu.onUpdate();
               main.Game.ui.mcPopup.mcCustomizeArmor.addChild(_menu);
               main.Game.ui.mcPopup.mcCustomizeArmor.setChildIndex(_menu,0);
            }
            performOnceFlag = true;
         }
         else if(performOnceFlag && !main.Game.ui.mcPopup.getChildByName("mcCustomizeArmor"))
         {
            performOnceFlag = false;
         }
         if(main.Game.ui.mcPopup.getChildByName("mcCustomize") && !performOnceFlag2)
         {
            if(!main.Game.ui.mcPopup.mcCustomize.getChildByName("colorSets"))
            {
               _menu = new colorSets();
               _menu.mode = "mcCustomize";
               _menu.name = "colorSets";
               _menu.y += main.Game.ui.mcPopup.mcCustomize.height + 12;
               _menu.onUpdate();
               main.Game.ui.mcPopup.mcCustomize.addChild(_menu);
               main.Game.ui.mcPopup.mcCustomize.setChildIndex(_menu,0);
            }
            performOnceFlag2 = true;
         }
         else if(performOnceFlag2 && !main.Game.ui.mcPopup.getChildByName("mcCustomize"))
         {
            performOnceFlag2 = false;
         }
      }
   }
}
