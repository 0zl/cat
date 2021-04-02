package catgirl.game
{
   import net.spider.main;
   
   public class TempInventory
   {
       
      
      public function TempInventory()
      {
         super();
      }
      
      public static function GetTempItems() : String
      {
         return JSON.stringify(main.Game.world.myAvatar.tempitems);
      }
      
      public static function GetTempItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in main.Game.world.myAvatar.tempitems)
         {
            if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function ItemIsInTemp(param1:String, param2:String) : String
      {
         var _loc3_:Object = GetTempItemByName(param1);
         if(_loc3_ == null)
         {
            return main.FalseString;
         }
         return param2 == "*" ? main.TrueString : (_loc3_.iQty >= parseInt(param2) ? main.TrueString : main.FalseString);
      }
   }
}
