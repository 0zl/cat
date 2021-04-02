package catgirl.game
{
   import flash.utils.ByteArray;
   import net.spider.main;
   
   public class Quests
   {
       
      
      public function Quests()
      {
         super();
      }
      
      public static function IsInProgress(param1:String) : String
      {
         return !!main.Game.world.isQuestInProgress(parseInt(param1)) ? main.TrueString : main.FalseString;
      }
      
      public static function Complete(param1:String, param2:String = "-1", param3:String = "False") : void
      {
         main.Game.world.tryQuestComplete(parseInt(param1),parseInt(param2),param3 == "True");
      }
      
      public static function Accept(param1:String) : void
      {
         main.Game.world.acceptQuest(parseInt(param1));
      }
      
      public static function Load(param1:String) : void
      {
         main.Game.world.showQuests([param1],"q");
      }
      
      public static function LoadMultiple(param1:String) : void
      {
         main.Game.world.showQuests(param1.split(","),"q");
      }
      
      public static function GetQuests(param1:String) : void
      {
         main.Game.world.getQuests(param1.split(","));
      }
      
      public static function IsAvailable(param1:String) : String
      {
         return GetQuestValidationString(parseInt(param1)) == "" ? main.TrueString : main.FalseString;
      }
      
      public static function CanComplete(param1:String) : String
      {
         var _loc2_:String = GetQuestValidationString(parseInt(param1));
         if(_loc2_ != "")
         {
            main.Game.chatF.pushMsg("warning","Can\'t turn in quest(" + param1 + "), message : " + _loc2_,"SERVER","",0);
         }
         return main.Game.world.canTurnInQuest(parseInt(param1)) && _loc2_ == "" ? main.TrueString : main.FalseString;
      }
      
      private static function CloneObject(param1:Object) : Object
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function GetQuestTree() : String
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:* = undefined;
         var _loc9_:Object = null;
         var _loc10_:* = undefined;
         var _loc11_:Object = null;
         var _loc12_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in main.Game.world.questTree)
         {
            _loc3_ = CloneObject(_loc2_);
            _loc4_ = [];
            _loc5_ = [];
            if(_loc2_.turnin != null && _loc2_.oItems != null)
            {
               for each(_loc6_ in _loc2_.turnin)
               {
                  _loc7_ = new Object();
                  _loc8_ = _loc2_.oItems[_loc6_.ItemID];
                  _loc7_.sName = _loc8_.sName;
                  _loc7_.ItemID = _loc8_.ItemID;
                  _loc7_.iQty = _loc6_.iQty;
                  _loc7_.bTemp = _loc8_.bTemp;
                  _loc4_.push(_loc7_);
               }
            }
            _loc3_.RequiredItems = _loc4_;
            if(_loc2_.reward != null && _loc2_.oRewards != null)
            {
               for each(_loc9_ in _loc2_.reward)
               {
                  for each(_loc10_ in _loc2_.oRewards)
                  {
                     for each(_loc11_ in _loc10_)
                     {
                        if(_loc11_.ItemID != null && _loc11_.ItemID == _loc9_.ItemID)
                        {
                           _loc12_ = new Object();
                           _loc12_.sName = _loc11_.sName;
                           _loc12_.ItemID = _loc9_.ItemID;
                           _loc12_.iQty = _loc9_.iQty;
                           _loc12_.DropChance = String(_loc9_.iRate) + "%";
                           _loc5_.push(_loc12_);
                        }
                     }
                  }
               }
            }
            _loc3_.Rewards = _loc5_;
            _loc1_.push(_loc3_);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function HasRequiredItemsForQuest(param1:Object) : Boolean
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         if(param1.reqd != null && param1.reqd.length > 0)
         {
            for each(_loc2_ in param1.reqd)
            {
               _loc3_ = _loc2_.ItemID;
               _loc4_ = int(_loc2_.iQty);
               _loc5_ = main.Game.world.invTree[_loc3_];
               if(_loc5_ == null || _loc5_.iQty < _loc4_)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public static function GetQuestValidationString(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc2_:Object = main.Game.world.questTree[param1];
         if(_loc2_.sField != null && main.Game.world.getAchievement(_loc2_.sField,_loc2_.iIndex) != 0)
         {
            if(_loc2_.sField == "im0")
            {
               return "Monthly Quests are only available once per month.";
            }
            return "Daily Quests are only available once per day.";
         }
         if(_loc2_.bUpg == 1 && !main.Game.world.myAvatar.isUpgraded())
         {
            return "Upgrade is required for this quest!";
         }
         if(_loc2_.iSlot >= 0 && main.Game.world.getQuestValue(_loc2_.iSlot) < _loc2_.iValue - 1)
         {
            return "Quest has not been unlocked!";
         }
         if(_loc2_.iLvl > main.Game.world.myAvatar.objData.intLevel)
         {
            return "Unlocks at Level " + _loc2_.iLvl + ".";
         }
         if(_loc2_.iClass > 0 && main.Game.world.myAvatar.getCPByID(_loc2_.iClass) < _loc2_.iReqCP)
         {
            _loc3_ = main.Game.getRankFromPoints(_loc2_.iReqCP);
            _loc4_ = _loc2_.iReqCP - main.Game.arrRanks[_loc3_ - 1];
            if(_loc4_ > 0)
            {
               return "Requires " + _loc4_ + " Class Points on " + _loc2_.sClass + ", Rank " + _loc3_ + ".";
            }
            return "Requires " + _loc2_.sClass + ", Rank " + _loc3_ + ".";
         }
         if(_loc2_.FactionID > 1 && main.Game.world.myAvatar.getRep(_loc2_.FactionID) < _loc2_.iReqRep)
         {
            _loc3_ = main.Game.getRankFromPoints(_loc2_.iReqRep);
            _loc5_ = _loc2_.iReqRep - main.Game.arrRanks[_loc3_ - 1];
            if(_loc5_ > 0)
            {
               return "Requires " + _loc5_ + " Reputation for " + _loc2_.sFaction + ", Rank " + _loc3_ + ".";
            }
            return "Requires " + _loc2_.sFaction + ", Rank " + _loc3_ + ".";
         }
         if(_loc2_.reqd != null && !HasRequiredItemsForQuest(_loc2_))
         {
            _loc6_ = "Required Item(s): ";
            for each(_loc7_ in _loc2_.reqd)
            {
               _loc8_ = _loc7_.ItemID;
               _loc9_ = int(_loc7_.iQty);
               _loc10_ = main.Game.world.invTree[_loc8_];
               if(_loc10_.sES == "ar")
               {
                  _loc3_ = main.Game.getRankFromPoints(_loc9_);
                  _loc4_ = _loc9_ - main.Game.arrRanks[_loc3_ - 1];
                  if(_loc4_ > 0)
                  {
                     _loc6_ = _loc6_ + _loc4_ + " Class Points on ";
                  }
                  _loc6_ = _loc6_ + _loc10_.sName + ", Rank " + _loc3_;
               }
               else
               {
                  _loc6_ += _loc10_.sName;
                  if(_loc9_ > 1)
                  {
                     _loc6_ = _loc6_ + "x" + _loc9_;
                  }
               }
               _loc6_ += ", ";
            }
            return _loc6_.substr(0,_loc6_.length - 2) + ".";
         }
         return "";
      }
   }
}
