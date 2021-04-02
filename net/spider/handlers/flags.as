package net.spider.handlers
{
   import flash.display.MovieClip;
   import net.spider.main;
   
   public class flags extends MovieClip
   {
       
      
      public function flags()
      {
         super();
      }
      
      public static function isOptions() : Boolean
      {
         return main.Game.ui.mcPopup.currentLabel == "Option";
      }
      
      public static function isInventory() : Boolean
      {
         return !main.Game.ui.mcPVPQueue.visible && main.Game.ui.mcPopup.currentLabel == "Inventory" && main.Game.ui.mcPopup.getChildByName("mcInventory");
      }
   }
}
