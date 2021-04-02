package catgirl.game
{
   import net.spider.main;
   
   public class Shops
   {
      
      public static var LoadedShops:Array = [];
       
      
      public function Shops()
      {
         super();
      }
      
      public static function OnShopLoaded(param1:Object) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.Location = param1.Location;
         _loc2_.sName = param1.sName;
         _loc2_.ShopID = param1.ShopID;
         _loc2_.items = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.items.length)
         {
            _loc2_.items.push(param1.items[_loc3_]);
            _loc3_++;
         }
         LoadedShops.push(_loc2_);
      }
      
      public static function ResetShopInfo() : void
      {
         main.Game.world.shopinfo = null;
      }
      
      public static function IsShopLoaded() : String
      {
         return main.Game.world.shopinfo != null && main.Game.world.shopinfo.items != null && main.Game.world.shopinfo.items.length > 0 ? main.TrueString : main.FalseString;
      }
      
      public static function BuyItem(param1:String) : void
      {
         var _loc2_:Object = GetShopItem(param1.toLowerCase());
         if(_loc2_ != null)
         {
            main.Game.world.sendBuyItemRequest(_loc2_);
         }
      }
      
      public static function GetShopItem(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < main.Game.world.shopinfo.items.length)
         {
            _loc3_ = main.Game.world.shopinfo.items[_loc2_];
            if(_loc3_.sName.toLowerCase() == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public static function GetShops() : String
      {
         return JSON.stringify(LoadedShops);
      }
      
      public static function Load(param1:String) : void
      {
         main.Game.world.sendLoadShopRequest(parseInt(param1));
      }
      
      public static function LoadHairShop(param1:String) : void
      {
         main.Game.world.sendLoadHairShopRequest(parseInt(param1));
      }
      
      public static function LoadArmorCustomizer() : void
      {
         main.Game.openArmorCustomize();
      }
      
      public static function SellItem(param1:String) : void
      {
         var _loc2_:Object = Inventory.GetItemByName(param1);
         main.Game.world.sendSellItemRequest(_loc2_);
      }
   }
}
