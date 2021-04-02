package catgirl.game
{
   import net.spider.main;
   
   public class Bank
   {
       
      
      public function Bank()
      {
         super();
      }
      
      public static function GetBankItems() : String
      {
         return JSON.stringify(main.Game.world.bankinfo.items);
      }
      
      public static function BankSlots() : int
      {
         return main.Game.world.myAvatar.objData.iBankSlots;
      }
      
      public static function UsedBankSlots() : int
      {
         return main.Game.world.myAvatar.iBankCount;
      }
      
      public static function TransferToBank(param1:String) : void
      {
         var _loc2_:Object = Inventory.GetItemByName(param1);
         if(_loc2_ != null)
         {
            main.Game.world.sendBankFromInvRequest(_loc2_);
         }
      }
      
      public static function TransferToInventory(param1:String) : void
      {
         var _loc2_:Object = GetItemByName(param1);
         if(_loc2_ != null)
         {
            main.Game.world.sendBankToInvRequest(_loc2_);
         }
      }
      
      public static function BankSwap(param1:String, param2:String) : void
      {
         var _loc3_:Object = Inventory.GetItemByName(param1);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:Object = GetItemByName(param2);
         if(_loc4_ == null)
         {
            return;
         }
         main.Game.world.sendBankSwapInvRequest(_loc4_,_loc3_);
      }
      
      public static function GetItemByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         if(main.Game.world.bankinfo.items != null && main.Game.world.bankinfo.items.length > 0)
         {
            for each(_loc2_ in main.Game.world.bankinfo.items)
            {
               if(_loc2_.sName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public static function Show() : void
      {
         main.Game.world.toggleBank();
      }
      
      public static function LoadBankItems() : void
      {
         main.Game.sfc.sendXtMessage("zm","loadBank",["Sword","Axe","Dagger","Gun","Bow","Mace","Polearm","Staff","Wand","Class","Armor","Helm","Cape","Pet","Amulet","Necklace","Note","Resource","Item","Quest Item","ServerUse","House","Wall Item","Floor Item","Enhancement"],"str",main.Game.world.curRoom);
      }
   }
}
