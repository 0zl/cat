package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextFieldType;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   import net.spider.modules.hidemonsters;
   
   public class cMenu extends MovieClip
   {
       
      
      public var cnt:MovieClip;
      
      var world:MovieClip;
      
      var fData:Object = null;
      
      var isOpen:Boolean = false;
      
      var fMode:String;
      
      var mc:MovieClip;
      
      var rootClass:MovieClip;
      
      var iHi:Number = -1;
      
      var iSel:Number = -1;
      
      var iCT:ColorTransform;
      
      private var toPM:String;
      
      public function cMenu()
      {
         super();
         this.mc = MovieClip(this);
         this.rootClass = MovieClip(main.Game);
         this.mc.cnt.iproto.visible = false;
         this.mc.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOn);
         this.mc.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         this.fData = {};
         this.fData.params = {};
         this.fData.user = ["Char Page","Is Staff?","Hide Helm","Hide Cape","Hide Weapon","Hide Player","Disable Wep Anim","Whisper","Add Friend","Go To","Invite","Report","Delete Friend","Ignore","Close"];
         this.fData.party = ["Char Page","Whisper","Add Friend","Go To","Remove","Summon","Promote","Report","Delete Friend","Ignore","Close"];
         this.fData.self = ["Char Page","Reputation","Leave Party","Close"];
         this.fData.pvpqueue = ["Leave Queue","Close"];
         this.fData.offline = ["Delete Friend","Close"];
         this.fData.ignored = ["Unignore","Close"];
         this.fData.mons = ["Freeze Monster","Hide Monster","Close"];
         this.fData.cl = [];
         this.fData.clc = [];
      }
      
      public function fOpenWith(_arg1:*, _arg2:*) : *
      {
         var _local7:* = undefined;
         var _local8:* = undefined;
         var _local9:* = undefined;
         var _local3:int = 0;
         this.isOpen = true;
         this.fMode = _arg1.toLowerCase();
         this.fData.params = _arg2;
         this.mc.cnt.mHi.visible = false;
         this.iCT = this.mc.cnt.mHi.transform.colorTransform;
         this.iCT.color = 13434675;
         this.mc.cnt.mHi.transform.colorTransform = this.iCT;
         _local3 = 0;
         while(_local3 < this.fData.user.length)
         {
            _local7 = this.mc.cnt.getChildByName("i" + _local3);
            if(_local7 != null)
            {
               _local7.removeEventListener(MouseEvent.CLICK,this.itemClick);
               _local7.removeEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver);
               this.mc.cnt.removeChild(_local7);
            }
            _local3++;
         }
         var _local4:* = 0;
         delete this.fData.cl;
         delete this.fData.clc;
         var _local5:* = this.fData.params.strUsername.toLowerCase();
         var _local6:* = this.rootClass.world.uoTree[_local5];
         this.fData.cl = this.rootClass.copyObj(this.fData[this.fMode]);
         this.fData.clc = [];
         _local3 = 0;
         while(_local3 < this.fData.cl.length)
         {
            if(this.fData.cl[_local3] == "Add Friend" && this.rootClass.world.myAvatar.isFriend(this.fData.params.ID))
            {
               this.fData.cl.splice(_local3,1);
               _local3--;
            }
            if(this.fData.cl[_local3] == "Delete Friend" && !this.rootClass.world.myAvatar.isFriend(this.fData.params.ID))
            {
               this.fData.cl.splice(_local3,1);
               _local3--;
            }
            _local3++;
         }
         _local3 = 0;
         while(_local3 < this.fData.cl.length)
         {
            if(this.fData.cl[_local3] == "Ignore" && this.rootClass.chatF.isIgnored(_local5))
            {
               this.fData.cl[_local3] = "Unignore";
            }
            if(this.fData.cl[_local3] == "Hide Helm" && !this.rootClass.world.getAvatarByUserName(_local5).pMC.mcChar.head.helm.visible)
            {
               this.fData.cl[_local3] = "Show Helm";
            }
            if(this.fData.cl[_local3] == "Hide Cape" && !this.rootClass.world.getAvatarByUserName(_local5).pMC.mcChar.cape.visible)
            {
               this.fData.cl[_local3] = "Show Cape";
            }
            if(this.fData.cl[_local3] == "Hide Player" && !this.rootClass.world.getAvatarByUserName(_local5).pMC.mcChar.visible)
            {
               this.fData.cl[_local3] = "Show Player";
            }
            if(this.fData.cl[_local3] == "Hide Weapon" && !this.rootClass.world.getAvatarByUserName(_local5).pMC.mcChar.weapon.visible)
            {
               this.fData.cl[_local3] = "Show Weapon";
            }
            if(this.fData.cl[_local3] == "Freeze Monster" && this.fData.params.target.noMove)
            {
               this.fData.cl[_local3] = "UnFreeze Monster";
            }
            if(this.fData.cl[_local3] == "Hide Monster" && !this.fData.params.target.getChildAt(1).visible)
            {
               this.fData.cl[_local3] = "Show Monster";
            }
            _local8 = this.mc.cnt.addChild(new cProto());
            _local8.name = "i" + _local3;
            _local8.y = this.mc.cnt.iproto.y + _local3 * 14;
            this.iCT = _local8.transform.colorTransform;
            _local9 = true;
            switch(this.fData.cl[_local3].toLowerCase())
            {
               case "add friend":
                  if(this.rootClass.world.getAvatarByUserName(_local5) != null && this.rootClass.world.getAvatarByUserName(_local5).objData != null && (this.rootClass.world.getAvatarByUserName(_local5).isStaff() && !this.rootClass.world.myAvatar.isStaff()))
                  {
                     _local9 = false;
                  }
                  break;
               case "go to":
                  break;
               case "ignore":
               case "unignore":
                  if(_local5 == this.rootClass.sfc.myUserName)
                  {
                     _local9 = false;
                  }
                  break;
               case "invite":
                  break;
               case "leave party":
                  if(this.rootClass.world.partyMembers.length == 0)
                  {
                     _local9 = false;
                  }
                  break;
               case "remove":
                  if(this.rootClass.world.partyOwner.toLowerCase() != this.rootClass.sfc.myUserName)
                  {
                     this.fData.cl[_local3] = "Leave Party";
                  }
                  break;
               case "private: on":
               case "private: off":
               case "promote":
                  if(this.rootClass.world.partyOwner != this.rootClass.world.myAvatar.objData.strUsername)
                  {
                     _local9 = false;
                  }
                  break;
               case "inspect":
                  if(_local6 == null || _local6.strFrame != this.rootClass.world.strFrame)
                  {
                     _local9 = false;
                  }
                  break;
            }
            if(_local9)
            {
               this.iCT.color = 10066329;
               _local8.addEventListener(MouseEvent.CLICK,this.itemClick,false,0,true);
               _local8.buttonMode = true;
            }
            else
            {
               this.iCT.color = 6710886;
            }
            _local8.addEventListener(MouseEvent.MOUSE_OVER,this.itemMouseOver,false,0,true);
            this.fData.clc.push(this.iCT.color);
            _local8.ti.text = this.fData.cl[_local3];
            if(_local8.ti.textWidth > _local4)
            {
               _local4 = _local8.ti.textWidth;
            }
            _local8.transform.colorTransform = this.iCT;
            _local8.ti.width = _local8.ti.textWidth + 5;
            _local8.hit.width = _local8.ti.x + _local8.ti.textWidth + 2;
            _local3++;
         }
         this.mc.cnt.bg.height = this.mc.cnt.getChildByName(String("i" + (this.fData.cl.length - 1))).y + 26;
         this.mc.cnt.bg.width = _local4 + 20;
         this.mc.x = MovieClip(parent).mouseX - 5;
         this.mc.y = MovieClip(parent).mouseY - 5;
         if(this.mc.x + this.mc.cnt.bg.width > 960)
         {
            this.mc.x = MovieClip(parent).mouseX - this.mc.cnt.bg.width;
         }
         if(this.mc.y + this.mc.cnt.bg.height > 500)
         {
            this.mc.y = 500 - this.mc.cnt.bg.height;
         }
         this.mc.gotoAndPlay("in");
      }
      
      public function fClose() : *
      {
         this.isOpen = false;
         if(this.mc.currentFrame != 1)
         {
            if(this.mc.currentFrame == 10)
            {
               this.mc.gotoAndPlay("out");
            }
            else
            {
               this.mc.gotoAndStop("hold");
            }
         }
      }
      
      private function itemMouseOver(_arg1:MouseEvent) : *
      {
         var _local4:* = undefined;
         var _local3:int = 0;
         var _local2:* = MovieClip(_arg1.currentTarget);
         this.iHi = int(_local2.name.substr(1));
         _local3 = 0;
         while(_local3 < this.fData.cl.length)
         {
            _local4 = this.mc.cnt.getChildByName("i" + _local3);
            this.iCT = _local4.transform.colorTransform;
            if(_local3 == this.iHi)
            {
               if(_local2.hasEventListener(MouseEvent.CLICK))
               {
                  this.iCT.color = 16777215;
                  this.cnt.mHi.visible = true;
                  this.cnt.mHi.y = _local4.y + 3;
               }
               else
               {
                  this.cnt.mHi.visible = false;
               }
            }
            else
            {
               this.iCT.color = this.fData.clc[_local3];
            }
            _local4.transform.colorTransform = this.iCT;
            _local3++;
         }
      }
      
      private function itemClick(_arg1:MouseEvent) : *
      {
         var _local3:String = null;
         var _local5:String = null;
         var _local6:int = 0;
         var playerMC:* = undefined;
         var _local4:String = null;
         var mcCharPage:charPage = null;
         var _local2:* = MovieClip(_arg1.currentTarget);
         this.iSel = int(_local2.name.substr(1));
         this.iCT = this.mc.cnt.mHi.transform.colorTransform;
         this.iCT.color = 16763955;
         this.mc.cnt.mHi.transform.colorTransform = this.iCT;
         this.fClose();
         _local3 = this.fData.cl[this.iSel];
         _local4 = this.fData.params.strUsername;
         switch(_local3.toLowerCase())
         {
            case "freeze monster":
               this.fData.params.target.noMove = true;
               break;
            case "unfreeze monster":
               this.fData.params.target.noMove = false;
               break;
            case "hide helm":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.head.helm.visible = false;
               playerMC.pMC.mcChar.head.hair.visible = true;
               playerMC.pMC.mcChar.backhair.visible = playerMC.pMC.bBackHair;
               break;
            case "show helm":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.head.helm.visible = true;
               playerMC.pMC.mcChar.head.hair.visible = false;
               playerMC.pMC.mcChar.backhair.visible = false;
               break;
            case "hide cape":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.cape.visible = false;
               break;
            case "show cape":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.cape.visible = true;
               break;
            case "hide monster":
               this.fData.params.target.getChildAt(1).visible = false;
               this.fData.params.target.shadow.addEventListener(MouseEvent.CLICK,hidemonsters.onClickHandler,false,0,true);
               this.fData.params.target.shadow.mouseEnabled = true;
               this.fData.params.target.shadow.buttonMode = true;
               break;
            case "show monster":
               this.fData.params.target.getChildAt(1).visible = true;
               this.fData.params.target.shadow.removeEventListener(MouseEvent.CLICK,hidemonsters.onClickHandler);
               this.fData.params.target.shadow.mouseEnabled = false;
               this.fData.params.target.shadow.buttonMode = false;
               break;
            case "char page":
               this.rootClass.mixer.playSound("Click");
               mcCharPage = new charPage(_local4);
               main.Game.ui.addChild(mcCharPage);
               break;
            case "is staff?":
               this.rootClass.world.isModerator(_local4);
               break;
            case "show weapon":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.weapon.visible = true;
               if(playerMC.pMC.pAV.getItemByEquipSlot("Weapon").sType == "Dagger")
               {
                  playerMC.pMC.mcChar.weaponOff.visible = true;
               }
               break;
            case "show player":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.visible = true;
               playerMC.pMC.pname.visible = true;
               playerMC.pMC.shadow.visible = true;
               break;
            case "hide weapon":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.weapon.visible = false;
               playerMC.pMC.mcChar.weaponOff.visible = false;
               break;
            case "hide player":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.visible = false;
               if(!optionHandler.filterChecks["chkName"])
               {
                  playerMC.pMC.pname.visible = false;
               }
               if(optionHandler.filterChecks["chkShadow"])
               {
                  playerMC.pMC.shadow.addEventListener(MouseEvent.CLICK,this.onClickHandler,false,0,true);
                  playerMC.pMC.shadow.mouseEnabled = true;
                  playerMC.pMC.shadow.buttonMode = true;
               }
               else
               {
                  playerMC.pMC.shadow.visible = false;
               }
               break;
            case "disable wep anim":
               playerMC = this.rootClass.world.getAvatarByUserName(_local4);
               playerMC.pMC.mcChar.weapon.mcWeapon.gotoAndStop(0);
               (playerMC.pMC.mcChar.weaponOff.getChildAt(0) as MovieClip).gotoAndStop(0);
               this.movieClipStopAll(playerMC.pMC.mcChar.weapon.mcWeapon);
               this.movieClipStopAll(playerMC.pMC.mcChar.weaponOff.getChildAt(0) as MovieClip);
               break;
            case "reputation":
               this.rootClass.mixer.playSound("Click");
               this.rootClass.showFactionInterface();
               break;
            case "whisper":
               this.toPM = _local4;
               this.rootClass.chatF.chn.cur = this.rootClass.chatF.chn.whisper;
               this.updateMsg();
               break;
            case "ignore":
               this.rootClass.chatF.ignore(_local4);
               this.rootClass.chatF.pushMsg("server","You are now ignoring user " + _local4 + ".","SERVER","",0);
               break;
            case "unignore":
               this.rootClass.chatF.unignore(_local4);
               this.rootClass.chatF.pushMsg("server","User " + _local4 + " is no longer being ignored.","SERVER","",0);
               break;
            case "report":
               this.rootClass.ui.mcPopup.fOpen("Report",{"unm":_local4});
               break;
            case "close":
               if(this.fMode == "user" || this.fMode == "party")
               {
                  this.rootClass.world.cancelTarget();
               }
               break;
            case "add friend":
               if(this.rootClass.world.myAvatar.friends.length >= 100)
               {
                  this.rootClass.chatF.pushMsg("server","You are too popular! (40 friends max)","SERVER","",0);
               }
               else
               {
                  this.rootClass.world.requestFriend(_local4);
               }
               break;
            case "delete friend":
               this.rootClass.world.deleteFriend(this.fData.params.ID,_local4);
               break;
            case "go to":
               this.rootClass.world.goto(_local4);
               break;
            case "invite":
               this.rootClass.world.partyInvite(_local4);
               break;
            case "remove":
               this.rootClass.world.partyKick(_local4);
               break;
            case "leave party":
               this.rootClass.world.partyLeave();
               break;
            case "private: on":
            case "private: off":
               _local5 = _local3.toLowerCase().split(": ")[0];
               _local6 = _local3.toLowerCase().split(": ")[1] == "on" ? 1 : 0;
               this.rootClass.world.partyUpdate(_local5,_local6);
               break;
            case "promote":
               this.rootClass.world.partyPromote(_local4);
               break;
            case "summon":
               this.rootClass.world.partySummon(_local4);
               break;
            case "leave queue":
               this.rootClass.world.requestPVPQueue("none");
         }
      }
      
      private function onClickHandler(e:MouseEvent) : void
      {
         var tAvt:* = undefined;
         tAvt = e.currentTarget.parent.pAV;
         if(e.shiftKey)
         {
            this.rootClass.world.onWalkClick();
         }
         else if(!e.ctrlKey)
         {
            if(tAvt != this.rootClass.world.myAvatar && this.rootClass.world.bPvP && tAvt.dataLeaf.pvpTeam != this.rootClass.world.myAvatar.dataLeaf.pvpTeam && tAvt == this.rootClass.world.myAvatar.target)
            {
               this.rootClass.world.approachTarget();
            }
            else if(tAvt != this.rootClass.world.myAvatar.target)
            {
               this.rootClass.world.setTarget(tAvt);
            }
         }
      }
      
      function movieClipStopAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               (container.getChildAt(i) as MovieClip).gotoAndStop(0);
               this.movieClipStopAll(container.getChildAt(i) as MovieClip);
            }
         }
      }
      
      private function updateMsg() : void
      {
         this.rootClass.chatF.pmI = 0;
         this.rootClass.chatF.myMsgsI = 0;
         this.rootClass.ui.mcInterface.tebg.addEventListener(MouseEvent.CLICK,this.chat_focus);
         this.rootClass.ui.mcInterface.te.visible = true;
         this.rootClass.ui.mcInterface.te.type = TextFieldType.INPUT;
         this.rootClass.stage.focus = null;
         this.rootClass.stage.focus = this.rootClass.ui.mcInterface.te;
         this.rootClass.chatF.formatMsgEntry(this.toPM);
         this.rootClass.chatF.updateMsgEntry();
      }
      
      private function chat_focus(e:MouseEvent) : void
      {
         if(this.rootClass.stage.focus != this.rootClass.ui.mcInterface.te)
         {
            this.updateMsg();
         }
      }
      
      private function mouseOn(_arg1:MouseEvent) : *
      {
         this.cnt.gotoAndStop("hold");
      }
      
      private function mouseOut(_arg1:MouseEvent) : *
      {
         this.cnt.gotoAndPlay("out");
      }
   }
}
