package catgirl.game
{
   import net.spider.main;
   
   public class House
   {
       
      
      public function House()
      {
         super();
      }
      
      public static function GetHouseItems() : String
      {
         return JSON.stringify(main.Game.world.myAvatar.houseitems);
      }
      
      public static function HouseSlots() : int
      {
         return main.Game.world.myAvatar.objData.iHouseSlots;
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         if(main.Game.world.myAvatar.houseitems != null && main.Game.world.myAvatar.houseitems.length > 0)
         {
            for each(_loc2_ in main.Game.world.myAvatar.houseitems)
            {
               if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
   }
}
