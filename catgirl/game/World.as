package catgirl.game
{
   import net.spider.main;
   
   public class World
   {
       
      
      public function World()
      {
         super();
      }
      
      public static function MapLoadComplete() : String
      {
         if(!main.Game.world.mapLoadInProgress)
         {
            try
            {
               return main.Game.getChildAt(main.Game.numChildren - 1) != main.Game.mcConnDetail ? main.TrueString : main.FalseString;
            }
            catch(e:*)
            {
               return main.FalseString;
            }
         }
         else
         {
            return main.FalseString;
         }
      }
      
      public static function PlayersInMap() : String
      {
         return JSON.stringify(main.Game.world.areaUsers);
      }
      
      public static function IsActionAvailable(param1:String) : String
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         _loc2_ = main.Game.world.lock[param1];
         _loc3_ = new Date();
         _loc4_ = _loc3_.getTime();
         _loc5_ = _loc4_ - _loc2_.ts;
         return _loc5_ < _loc2_.cd ? main.FalseString : main.TrueString;
      }
      
      public static function GetMonstersInCell() : String
      {
         var _loc3_:* = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
         var _loc2_:Array = [];
         for(_loc3_ in _loc1_)
         {
            _loc4_ = _loc1_[_loc3_];
            _loc5_ = new Object();
            _loc5_.sRace = _loc4_.objData.sRace;
            _loc5_.strMonName = _loc4_.objData.strMonName;
            _loc5_.MonID = _loc4_.dataLeaf.MonID;
            _loc5_.iLvl = _loc4_.dataLeaf.iLvl;
            _loc5_.intState = _loc4_.dataLeaf.intState;
            _loc5_.intHP = _loc4_.dataLeaf.intHP;
            _loc5_.intHPMax = _loc4_.dataLeaf.intHPMax;
            _loc2_.push(_loc5_);
         }
         return JSON.stringify(_loc2_);
      }
      
      public static function GetVisibleMonstersInCell() : String
      {
         var _loc3_:* = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc1_:Array = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
         var _loc2_:Array = [];
         for(_loc3_ in _loc1_)
         {
            _loc4_ = _loc1_[_loc3_];
            if(!(_loc4_.pMC == null || !_loc4_.pMC.visible || _loc4_.dataLeaf.intState <= 0))
            {
               _loc5_ = new Object();
               _loc5_.sRace = _loc4_.objData.sRace;
               _loc5_.strMonName = _loc4_.objData.strMonName;
               _loc5_.MonID = _loc4_.dataLeaf.MonID;
               _loc5_.iLvl = _loc4_.dataLeaf.iLvl;
               _loc5_.intState = _loc4_.dataLeaf.intState;
               _loc5_.intHP = _loc4_.dataLeaf.intHP;
               _loc5_.intHPMax = _loc4_.dataLeaf.intHPMax;
               _loc2_.push(_loc5_);
            }
         }
         return JSON.stringify(_loc2_);
      }
      
      public static function SetSpawnPoint() : void
      {
         main.Game.world.setSpawnPoint(main.Game.world.strFrame,main.Game.world.strPad);
      }
      
      public static function IsMonsterAvailable(param1:String) : String
      {
         return GetMonsterByName(param1) != null ? main.TrueString : main.FalseString;
      }
      
      public static function GetSkillName(param1:String) : String
      {
         var _loc2_:int = parseInt(param1);
         return "\"" + main.Game.world.actions.active[_loc2_].nam + "\"";
      }
      
      public static function GetMonsterByName(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         for each(_loc2_ in main.Game.world.getMonstersByCell(main.Game.world.strFrame))
         {
            _loc3_ = _loc2_.pMC.pname.ti.text.toLowerCase();
            if((_loc3_.indexOf(param1.toLowerCase()) > -1 || param1 == "*") && _loc2_.dataLeaf.intState > 0)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function GetCells() : String
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in main.Game.world.map.currentScene.labels)
         {
            _loc1_.push(_loc2_.name);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function GetItemTree() : String
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for(_loc2_ in main.Game.world.invTree)
         {
            _loc1_.push(main.Game.world.invTree[_loc2_]);
         }
         return JSON.stringify(_loc1_);
      }
      
      public static function RoomId() : String
      {
         return main.Game.world.curRoom.toString();
      }
      
      public static function RoomNumber() : String
      {
         return main.Game.world.strAreaName.split("-")[1];
      }
      
      public static function Players() : String
      {
         return JSON.stringify(main.Game.world.uoTree);
      }
   }
}
