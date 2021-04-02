package catgirl.game
{
   import flash.filters.GlowFilter;
   import net.spider.main;
   
   public class Player
   {
       
      
      public function Player()
      {
         super();
      }
      
      public static function IsLoggedIn() : String
      {
         return main.Game != null && main.Game.sfc != null && main.Game.sfc.isConnected == true ? main.TrueString : main.FalseString;
      }
      
      public static function Cell() : String
      {
         return "\"" + main.Game.world.strFrame + "\"";
      }
      
      public static function GetFactions() : String
      {
         return JSON.stringify(main.Game.world.myAvatar.factions);
      }
      
      public static function Pad() : String
      {
         return "\"" + main.Game.world.strPad + "\"";
      }
      
      public static function State() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intState;
      }
      
      public static function Health() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intHP;
      }
      
      public static function HealthMax() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intHPMax;
      }
      
      public static function Mana() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intMP;
      }
      
      public static function ManaMax() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intMPMax;
      }
      
      public static function Map() : String
      {
         return "\"" + main.Game.world.strMapName + "\"";
      }
      
      public static function Level() : int
      {
         return main.Game.world.myAvatar.dataLeaf.intLevel;
      }
      
      public static function IsMember() : Boolean
      {
         return main.Game.world.myAvatar.objData.iUpgDays >= 0;
      }
      
      public static function Gold() : int
      {
         return main.Game.world.myAvatar.objData.intGold;
      }
      
      public static function HasTarget() : String
      {
         return main.Game.world.myAvatar.target != null && main.Game.world.myAvatar.target.dataLeaf.intHP > 0 ? main.TrueString : main.FalseString;
      }
      
      public static function IsAfk() : String
      {
         return !!main.Game.world.myAvatar.dataLeaf.afk ? main.TrueString : main.FalseString;
      }
      
      public static function AllSkillsAvailable() : int
      {
         return Math.max(Math.max(skillReady(main.Game.world.actions.active[1]),skillReady(main.Game.world.actions.active[2])),Math.max(skillReady(main.Game.world.actions.active[3]),skillReady(main.Game.world.actions.active[4])));
      }
      
      public static function SkillAvailable(param1:String) : int
      {
         return skillReady(main.Game.world.actions.active[parseInt(param1)]);
      }
      
      private static function skillReady(param1:*) : int
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = new Date().getTime();
         var _loc3_:Number = 1 - Math.min(Math.max(main.Game.world.myAvatar.dataLeaf.sta.$tha,-1),0.5);
         if(param1.OldCD != null)
         {
            _loc4_ = Math.round(param1.OldCD * _loc3_);
            delete param1.OldCD;
         }
         else
         {
            _loc4_ = Math.round(param1.cd * _loc3_);
         }
         var _loc5_:Number = main.Game.world.GCD - (_loc2_ - main.Game.world.GCDTS);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         var _loc6_:Number = _loc4_ - (_loc2_ - param1.ts);
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         return Math.max(_loc5_,_loc6_);
      }
      
      public static function Position() : String
      {
         return JSON.stringify([main.Game.world.myAvatar.pMC.x,main.Game.world.myAvatar.pMC.y]);
      }
      
      public static function WalkToPoint(param1:String, param2:String) : void
      {
         var _loc3_:int = parseInt(param1);
         var _loc4_:int = parseInt(param2);
         main.Game.world.myAvatar.pMC.walkTo(_loc3_,_loc4_,main.Game.world.WALKSPEED);
         main.Game.world.moveRequest({
            "mc":main.Game.world.myAvatar.pMC,
            "tx":_loc3_,
            "ty":_loc4_,
            "sp":main.Game.world.WALKSPEED
         });
      }
      
      public static function CancelTarget() : void
      {
         if(main.Game.world.myAvatar.target != null)
         {
            main.Game.world.cancelTarget();
         }
      }
      
      public static function CancelTargetSelf() : void
      {
         var target:* = main.Game.world.myAvatar.target;
         if(target && target == main.Game.world.myAvatar)
         {
            main.Game.world.cancelTarget();
         }
      }
      
      public static function MuteToggle(param1:Boolean) : void
      {
         if(param1)
         {
            main.Game.chatF.unmuteMe();
         }
         else
         {
            main.Game.chatF.muteMe(300000);
         }
      }
      
      public static function AttackMonster(param1:String) : void
      {
         var name:String = param1;
         var monster:Object = World.GetMonsterByName(name);
         if(monster != null)
         {
            try
            {
               main.Game.world.setTarget(monster);
               main.Game.world.approachTarget();
               return;
            }
            catch(e:*)
            {
               return;
            }
         }
         else
         {
            return;
         }
      }
      
      public static function Jump(param1:String, param2:String = "Spawn") : void
      {
         main.Game.world.moveToCell(param1,param2);
      }
      
      public static function Rest() : void
      {
         main.Game.world.rest();
      }
      
      public static function Join(param1:String, param2:String = "Enter", param3:String = "Spawn") : void
      {
         main.Game.world.gotoTown(param1,param2,param3);
      }
      
      public static function Equip(param1:String) : void
      {
         main.Game.world.sendEquipItemRequest({"ItemID":parseInt(param1)});
      }
      
      public static function EquipPotion(param1:String, param2:String, param3:String, param4:String) : void
      {
         main.Game.world.equipUseableItem({
            "ItemID":parseInt(param1),
            "sDesc":param2,
            "sFile":param3,
            "sName":param4
         });
      }
      
      public static function Buff() : void
      {
         main.Game.world.myAvatar.dataLeaf.sta.$tha = 0.5;
         main.Game.world.myAvatar.objData.intMP = 100;
         main.Game.world.myAvatar.dataLeaf.intMP = 100;
         main.Game.world.myAvatar.objData.intLevel = 100;
         main.Game.world.actions.active[0].mp = 0;
         main.Game.world.actions.active[1].mp = 0;
         main.Game.world.actions.active[2].mp = 0;
         main.Game.world.actions.active[3].mp = 0;
         main.Game.world.actions.active[4].mp = 0;
         main.Game.world.actions.active[5].mp = 0;
      }
      
      public static function GoTo(param1:String) : void
      {
         main.Game.world.goto(param1);
      }
      
      public static function UseBoost(param1:String) : void
      {
         var _loc2_:Object = Inventory.GetItemByID(parseInt(param1));
         if(_loc2_ != null)
         {
            main.Game.world.sendUseItemRequest(_loc2_);
         }
      }
      
      public static function UseSkill(param1:String) : void
      {
         var _loc2_:* = undefined;
         if(main.Game.world.myAvatar.target == main.Game.world.myAvatar)
         {
            main.Game.world.myAvatar.target = null;
            return;
         }
         var _loc3_:Object = main.Game.world.actions.active[parseInt(param1)];
         if(_loc3_.tgt == "s" || _loc3_.tgt == "f")
         {
            _loc2_ = main.Game.world.myAvatar.target;
            main.Game.world.myAvatar.target = main.Game.world.myAvatar;
         }
         if(main.Game.world.myAvatar.target != null && main.Game.world.myAvatar.target.dataLeaf.intHP > 0)
         {
            main.Game.world.approachTarget();
            if(skillReady(_loc3_) == 0)
            {
               if(main.Game.world.myAvatar.dataLeaf.intMP >= _loc3_.mp)
               {
                  if(_loc3_.isOK && !_loc3_.lock)
                  {
                     main.Game.world.testAction(_loc3_);
                  }
               }
            }
         }
         if(_loc3_.tgt == "s" || _loc3_.tgt == "f")
         {
            main.Game.world.myAvatar.target = _loc2_;
         }
      }
      
      public static function GetMapItem(param1:String) : void
      {
         main.Game.world.getMapItem(parseInt(param1));
      }
      
      public static function Logout() : void
      {
         main.Game.logout();
      }
      
      public static function HasActiveBoost(param1:String) : String
      {
         param1 = param1.toLowerCase();
         if(param1.indexOf("gold") > -1)
         {
            return main.Game.world.myAvatar.objData.iBoostG > 0 ? main.TrueString : main.FalseString;
         }
         if(param1.indexOf("xp") > -1)
         {
            return main.Game.world.myAvatar.objData.iBoostXP > 0 ? main.TrueString : main.FalseString;
         }
         if(param1.indexOf("rep") > -1)
         {
            return main.Game.world.myAvatar.objData.iBoostRep > 0 ? main.TrueString : main.FalseString;
         }
         if(param1.indexOf("class") > -1)
         {
            return main.Game.world.myAvatar.objData.iBoostCP > 0 ? main.TrueString : main.FalseString;
         }
         return main.TrueString;
      }
      
      public static function Class() : String
      {
         return "\"" + main.Game.world.myAvatar.objData.strClassName.toUpperCase() + "\"";
      }
      
      public static function UserID() : int
      {
         return main.Game.world.myAvatar.uid;
      }
      
      public static function CharID() : int
      {
         return main.Game.world.myAvatar.objData.CharID;
      }
      
      public static function Gender() : String
      {
         return "\"" + main.Game.world.myAvatar.objData.strGender.toUpperCase() + "\"";
      }
      
      public static function PlayerData() : Object
      {
         return main.Game.world.myAvatar.objData;
      }
      
      public static function SetEquip(param1:String, param2:Object) : void
      {
         if(main.Game.world.myAvatar.pMC.pAV.objData.eqp.Weapon == null)
         {
            return;
         }
         var slot:* = param1;
         var equip:* = param2;
         if(param1 == "Off")
         {
            main.Game.world.myAvatar.pMC.pAV.objData.eqp.Weapon.sLink = equip.sLink;
            main.Game.world.myAvatar.pMC.loadWeaponOff(equip.sFile,equip.sLink);
            main.Game.world.myAvatar.pMC.pAV.getItemByEquipSlot("Weapon").sType = "Dagger";
         }
         else
         {
            main.Game.world.myAvatar.objData.eqp[slot] = equip;
            main.Game.world.myAvatar.loadMovieAtES(slot,equip.sFile,equip.sLink);
         }
      }
      
      public static function GetEquip(id:int) : String
      {
         return JSON.stringify(main.Game.world.avatars[id].objData.eqp);
      }
      
      public static function ChangeName(param1:String) : void
      {
         main.Game.world.myAvatar.pMC.pname.ti.text = param1.toUpperCase();
         main.Game.ui.mcPortrait.strName.text = param1.toUpperCase();
         main.Game.world.myAvatar.objData.strUsername = param1.toUpperCase();
         main.Game.world.myAvatar.pMC.pAV.objData.strUsername = param1.toUpperCase();
      }
      
      public static function ChangeGuild(param1:String) : void
      {
         if(main.Game.world.myAvatar.objData.guild != null)
         {
            main.Game.world.myAvatar.pMC.pname.tg.text = param1.toUpperCase();
            main.Game.world.myAvatar.objData.guild.Name = param1.toUpperCase();
            main.Game.world.myAvatar.pMC.pAV.objData.guild.Name = param1.toUpperCase();
         }
      }
      
      public static function ChangeAccessLevel(param1:String) : void
      {
         if(param1 == "Non Member")
         {
            main.Game.world.myAvatar.pMC.pname.ti.textColor = 16777215;
            main.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            main.Game.world.myAvatar.objData.iUpgDays = -1;
            main.Game.world.myAvatar.objData.iUpg = 0;
            main.Game.chatF.pushMsg("Grimoire","Access : Non Member","SERVER","",0);
         }
         else if(param1 == "Member")
         {
            main.Game.world.myAvatar.pMC.pname.ti.textColor = 9229823;
            main.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            main.Game.world.myAvatar.objData.iUpgDays = 30;
            main.Game.world.myAvatar.objData.iUpg = 1;
            main.Game.chatF.pushMsg("Grimoire","Access : Member","SERVER","",0);
         }
         else if(param1 == "Moderator")
         {
            main.Game.world.myAvatar.pMC.pname.ti.textColor = 16698168;
            main.Game.world.myAvatar.pMC.pname.filters = [new GlowFilter(0,1,3,3,64,1)];
            main.Game.world.myAvatar.objData.intAccessLevel = 60;
            main.Game.chatF.pushMsg("Grimoire","Access : Moderator","SERVER","",0);
         }
      }
   }
}
