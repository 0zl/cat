package catgirl.game
{
   import net.spider.main;
   
   public class Inventory
   {
       
      
      public function Inventory()
      {
         super();
      }
      
      public static function GetInventoryItems() : String
      {
         return JSON.stringify(main.Game.world.myAvatar.items);
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in main.Game.world.myAvatar.items)
         {
            if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function GetItemByID(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in main.Game.world.myAvatar.items)
         {
            if(_loc2_.ItemID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function InventorySlots() : int
      {
         return main.Game.world.myAvatar.objData.iBagSlots;
      }
      
      public static function UsedInventorySlots() : int
      {
         return main.Game.world.myAvatar.items.length;
      }
   }
}
