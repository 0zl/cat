package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.main;
   
   public class houseentrance extends MovieClip
   {
      
      public static var houseEvent:Boolean = false;
       
      
      public function houseentrance()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         if(!main.Game)
         {
            return;
         }
         if(!main.Game.ui)
         {
            return;
         }
         if(!houseEvent)
         {
            main.Game.ui.mcInterface.mcMenu.btnHouse.addEventListener(MouseEvent.CLICK,onHouseClick,false,0,true);
            houseEvent = true;
         }
         else
         {
            if(main.Game.ui)
            {
               main.Game.ui.mcInterface.mcMenu.btnHouse.removeEventListener(MouseEvent.CLICK,onHouseClick);
            }
            houseEvent = false;
         }
      }
      
      public static function onHouseClick(e:MouseEvent) : void
      {
         if(main.Game.world.strMapName.toLowerCase() == "house")
         {
            main.Game.world.moveToCell("Enter","Spawn");
         }
      }
   }
}
