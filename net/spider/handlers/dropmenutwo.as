package net.spider.handlers
{
   import com.adobe.utils.StringUtil;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import net.spider.draw.dAttached;
   import net.spider.draw.dEntry;
   import net.spider.main;
   
   public class dropmenutwo extends MovieClip
   {
       
      
      public var menuBar:MovieClip;
      
      public var menu:MovieClip;
      
      public var txtQty:TextField;
      
      private var bAttachedOpen:Boolean = false;
      
      private var mcAttached:dAttached;
      
      private var achvmnt_timer:Timer;
      
      var itemWasAdded:Boolean;
      
      var itemCount:Object;
      
      var invTree:Vector.<Object>;
      
      public function dropmenutwo()
      {
         super();
         this.itemCount = {};
         this.invTree = new Vector.<Object>();
         this.menu.visible = false;
         this.txtQty.mouseEnabled = false;
         this.menuBar.addEventListener(MouseEvent.CLICK,this.onToggleMenu);
         this.menuBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onHold,false);
         this.menuBar.addEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease,false);
         var pos:Boolean = main.sharedObject.data.dmtPos;
         if(pos)
         {
            this.x = main.sharedObject.data.dmtPos.x;
            this.y = main.sharedObject.data.dmtPos.y;
         }
         else
         {
            this.x = 383;
            this.y = 461;
         }
         this.visible = false;
         main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler,false,0,true);
         main._stage.addEventListener(Event.ENTER_FRAME,this.onDropFrame,false,0,true);
         this.createUIStack();
         this.onChangeReset(optionHandler.filterChecks["chkAttachMenu"]);
      }
      
      public function onChangeReset(mode:Boolean) : void
      {
         this.bAttachedOpen = false;
         if(mode)
         {
            this.mcAttached = new dAttached();
            this.mcAttached.name = "mcAttached";
            main.Game.ui.mcInterface.addChild(this.mcAttached);
            main.Game.ui.mcInterface.setChildIndex(main.Game.ui.mcInterface.getChildByName("mcAttached"),0);
            this.mcAttached.x = 352;
            this.mcAttached.y = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(-530) : Number(-19);
            this.mcAttached.visible = true;
            this.mcAttached.inner_menu.height = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(42.8) : Number(157.7);
            this.mcAttached.inner_menu.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverAttached,false,0,true);
            this.mcAttached.inner_menu.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutAttached,false,0,true);
            this.mcAttached.inner_menu.addEventListener(MouseEvent.CLICK,this.onToggleAttached,false,0,true);
            this.visible = false;
         }
         else if(this.mcAttached)
         {
            while(this.mcAttached.numChildren > 1)
            {
               this.mcAttached.removeChildAt(1);
            }
            this.mcAttached.inner_menu.removeEventListener(MouseEvent.CLICK,this.onToggleAttached);
            this.mcAttached.inner_menu.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverAttached);
            this.mcAttached.inner_menu.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutAttached);
            main.Game.ui.mcInterface.removeChild(main.Game.ui.mcInterface.getChildByName("mcAttached"));
            this.mcAttached = null;
            this.visible = true;
         }
      }
      
      public function onRollOverAttached(e:MouseEvent) : void
      {
         if(this.bAttachedOpen)
         {
            return;
         }
         this.mcAttached.y = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(-521) : Number(-28);
      }
      
      public function onRollOutAttached(e:MouseEvent) : void
      {
         if(this.bAttachedOpen)
         {
            return;
         }
         this.mcAttached.y = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(-530) : Number(-19);
      }
      
      public function onToggleAttached(e:MouseEvent) : void
      {
         this.bAttachedOpen = !this.bAttachedOpen;
         if(!this.bAttachedOpen)
         {
            while(this.mcAttached.numChildren > 1)
            {
               this.mcAttached.removeChildAt(1);
            }
            this.mcAttached.inner_menu.height = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(42.8) : Number(157.7);
            this.mcAttached.inner_menu.y = 0;
            this.mcAttached.y = !!optionHandler.filterChecks["chkInvertDrop"] ? Number(-530) : Number(-19);
         }
         else
         {
            this.reDraw();
         }
      }
      
      public function createUIStack() : void
      {
         var dsUI:MovieClip = null;
         if(!main.Game.ui.getChildByName("dsUI"))
         {
            dsUI = new MovieClip();
            dsUI.name = "dsUI";
            main.Game.ui.addChild(dsUI);
            dsUI.x = main.Game.ui.dropStack.x;
            dsUI.y = main.Game.ui.dropStack.y;
         }
      }
      
      public function resetPos() : void
      {
         this.x = 383;
         this.y = 461;
         main.sharedObject.data.dmtPos = {
            "x":this.x,
            "y":this.y
         };
         main.sharedObject.flush();
      }
      
      public function onShow() : void
      {
         if(this.mcAttached)
         {
            this.mcAttached.inner_menu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
         else
         {
            this.visible = !this.visible;
         }
      }
      
      private function onHold(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMouseRelease(e:MouseEvent) : void
      {
         this.stopDrag();
         main.sharedObject.data.dmtPos = {
            "x":this.x,
            "y":this.y
         };
         main.sharedObject.flush();
      }
      
      public function onUpdate() : *
      {
         this.itemCount = {};
         this.invTree.length = 0;
         this.reDraw();
      }
      
      public function onBtNo(e:*) : void
      {
         var val:* = undefined;
         var i:int = 0;
         var nutext:String = null;
         for(val in this.invTree)
         {
            if(this.invTree[val].ItemID == e.ItemID)
            {
               this.itemCount[this.invTree[val].dID] = null;
               this.invTree.splice(val,1);
            }
         }
         for(i = 0; i < main.Game.ui.dropStack.numChildren; i++)
         {
            if(main.Game.ui.dropStack.getChildAt(i))
            {
               if(e.iStk == 1)
               {
                  if(main.Game.ui.dropStack.getChildAt(i).cnt && main.Game.ui.dropStack.getChildAt(i).cnt.strName)
                  {
                     if(main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == e.sName)
                     {
                        main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                     }
                  }
               }
               else
               {
                  nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                  nutext = nutext.substring(0,nutext.lastIndexOf(" x"));
                  if(nutext == e.sName)
                  {
                     main.Game.ui.dropStack.getChildAt(i).cnt.nbtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  }
               }
            }
         }
         this.reDraw();
      }
      
      public function onToggleMenu(e:MouseEvent) : void
      {
         this.menu.visible = !this.menu.visible;
         if(this.menu.visible)
         {
            this.reDraw();
         }
      }
      
      public function cleanup() : void
      {
         main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
         main._stage.removeEventListener(Event.ENTER_FRAME,this.onDropFrame);
         main.Game.ui.dropStack.visible = true;
         main.Game.ui.removeChild(main.Game.ui.getChildByName("dsUI"));
         if(this.achvmnt_timer && this.achvmnt_timer.running)
         {
            this.achvmnt_timer.reset();
            this.achvmnt_timer.removeEventListener(TimerEvent.TIMER,this.onAchvmntCooldown);
         }
         this.achvmnt_timer = null;
      }
      
      private function onAchvmntCooldown(e:TimerEvent) : void
      {
         var i:uint = 0;
         var dropObj:* = undefined;
         if(main.Game.ui.dropStack.numChildren > 0)
         {
            for(i = 0; i < main.Game.ui.dropStack.numChildren; i++)
            {
               dropObj = main.Game.ui.dropStack.getChildAt(i);
               if(getQualifiedClassName(dropObj) == "mcAchievement")
               {
                  return;
               }
            }
         }
         e.target.reset();
         e.target.removeEventListener(TimerEvent.TIMER,this.onAchvmntCooldown);
         this.achvmnt_timer = null;
      }
      
      public function onDropFrame(e:*) : void
      {
         var dropObj:* = undefined;
         var achievementClass:Class = null;
         var achvmnt_ui:* = undefined;
         if(!main.Game.sfc.isConnected)
         {
            main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
            main._stage.removeEventListener(Event.ENTER_FRAME,this.onDropFrame);
            this.itemCount = {};
            this.invTree.length = 0;
            if(this.achvmnt_timer && this.achvmnt_timer.running)
            {
               this.achvmnt_timer.reset();
               this.achvmnt_timer.removeEventListener(TimerEvent.TIMER,this.onAchvmntCooldown);
            }
            this.achvmnt_timer = null;
            return;
         }
         main.Game.ui.dropStack.visible = false;
         if(main.Game.ui.dropStack.numChildren < 1)
         {
            return;
         }
         if(this.achvmnt_timer && this.achvmnt_timer.running)
         {
            return;
         }
         for(var i:uint = 0; i < main.Game.ui.dropStack.numChildren; i++)
         {
            dropObj = main.Game.ui.dropStack.getChildAt(i);
            if(getQualifiedClassName(dropObj) == "mcAchievement")
            {
               achievementClass = main.Game.world.getClass("mcAchievement") as Class;
               achvmnt_ui = main.Game.ui.getChildByName("dsUI").addChild(new achievementClass()) as MovieClip;
               achvmnt_ui.cnt.tBody.text = dropObj.cnt.tBody.text;
               achvmnt_ui.cnt.tPts.text = dropObj.cnt.tPts.text;
               achvmnt_ui.fWidth = 348;
               achvmnt_ui.fHeight = 90;
               achvmnt_ui.fX = achvmnt_ui.x = -(achvmnt_ui.fWidth / 2);
               achvmnt_ui.fY = achvmnt_ui.y = -(achvmnt_ui.fHeight + 8);
               this.cleanDSUI();
               this.achvmnt_timer = new Timer(7000);
               this.achvmnt_timer.addEventListener(TimerEvent.TIMER,this.onAchvmntCooldown);
               this.achvmnt_timer.start();
               break;
            }
         }
      }
      
      public function isBlacklisted(item:String) : Boolean
      {
         var blacklisted:* = undefined;
         for each(blacklisted in optionHandler.blackListed)
         {
            if(item.indexOf(" X") != -1)
            {
               item = item.substring(0,item.lastIndexOf(" X"));
            }
            if(StringUtil.trim(item) == StringUtil.trim(blacklisted.label))
            {
               return true;
            }
         }
         return false;
      }
      
      public function cleanDSUI() : void
      {
         var notifObj:MovieClip = null;
         var notifObj2:MovieClip = null;
         var notifCtr:* = main.Game.ui.getChildByName("dsUI").numChildren;
         notifCtr -= 2;
         while(notifCtr > -1)
         {
            notifObj = main.Game.ui.getChildByName("dsUI").getChildAt(notifCtr) as MovieClip;
            notifObj2 = main.Game.ui.getChildByName("dsUI").getChildAt(notifCtr + 1) as MovieClip;
            notifObj.fY = notifObj.y = notifObj2.fY - (notifObj2.fHeight + 8);
            notifCtr--;
         }
      }
      
      public function showQuestpopup(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc3_:MovieClip = null;
         var _loc4_:* = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var questPopupClass:Class = main.Game.world.getClass("mcQuestpopup") as Class;
         _loc2_ = new questPopupClass();
         _loc2_.cnt.mcAC.visible = false;
         _loc3_ = main.Game.ui.getChildByName("dsUI").addChild(_loc2_) as MovieClip;
         _loc3_.cnt.tName.text = param1.sName;
         _loc3_.cnt.rewards.tRewards.htmlText = "";
         _loc4_ = "";
         _loc5_ = param1.rewardObj;
         if(param1.rewardType == "ac")
         {
            _loc4_ = "<font color=\'#FFFFFF\'>" + param1.intAmount + "</font>";
            _loc4_ += "<font color=\'#FFCC00\'> Adventure Coins</font>";
            _loc3_.cnt.mcAC.visible = true;
         }
         else
         {
            if("intGold" in _loc5_ && _loc5_.intGold > 0)
            {
               _loc4_ = "<font color=\'#FFFFFF\'>" + _loc5_.intGold + "</font>";
               _loc4_ += "<font color=\'#FFCC00\'>g</font>";
            }
            if("intExp" in _loc5_ && _loc5_.intExp > 0)
            {
               if(_loc4_.length > 0)
               {
                  _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
               }
               _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.intExp + "</font>";
               _loc4_ += "<font color=\'#FF00FF\'>xp</font>";
            }
            if("iRep" in _loc5_ && _loc5_.iRep > 0)
            {
               if(_loc4_.length > 0)
               {
                  _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
               }
               _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.iRep + "</font>";
               _loc4_ += "<font color=\'#00CCFF\'>rep</font>";
            }
            if("guildRep" in _loc5_ && _loc5_.guildRep > 0)
            {
               if(_loc4_.length > 0)
               {
                  _loc4_ += "<font color=\'#FFFFFF\'>, </font>";
               }
               _loc4_ += "<font color=\'#FFFFFF\'>" + _loc5_.guildRep + "</font>";
               _loc4_ += "<font color=\'#00CCFF\'>guild rep</font>";
            }
         }
         _loc3_.cnt.rewards.tRewards.htmlText = _loc4_;
         _loc3_.fWidth = 240;
         _loc3_.fHeight = 70;
         _loc6_ = _loc3_.cnt.rewards.tRewards.x + _loc3_.cnt.rewards.tRewards.textWidth;
         _loc3_.cnt.rewards.x = Math.round(_loc3_.fWidth / 2 - _loc6_ / 2);
         _loc3_.fX = _loc3_.x = -(_loc3_.fWidth / 2);
         _loc3_.fY = _loc3_.y = -(_loc3_.fHeight + 8);
         this.cleanDSUI();
      }
      
      public function showItemDS(item:*, qty:*) : void
      {
         var dropClass:Class = main.Game.world.getClass("DFrameMC") as Class;
         var droppedItem:* = main.Game.copyObj(item);
         droppedItem.iQty = qty;
         var dropUI:* = new dropClass(droppedItem);
         main.Game.ui.getChildByName("dsUI").addChild(dropUI);
         dropUI.init();
         if(qty > 1)
         {
            dropUI.cnt.bg.width = int(dropUI.cnt.strName.textWidth) + 50;
            dropUI.cnt.bg.width += dropUI.cnt.strQ.textWidth + 2;
            dropUI.cnt.strQ.x = dropUI.cnt.strName.textWidth + 12;
            dropUI.cnt.fx1.width = dropUI.cnt.bg.width;
            dropUI.fWidth = dropUI.cnt.bg.width;
         }
         else if(dropUI.cnt.strName.textWidth < dropUI.cnt.strType.textWidth)
         {
            dropUI.cnt.bg.width = int(dropUI.cnt.strType.textWidth) + 50;
            dropUI.cnt.fx1.width = dropUI.cnt.bg.width;
            dropUI.fWidth = dropUI.cnt.bg.width;
         }
         dropUI.fY = dropUI.y = -(dropUI.fHeight + 8);
         dropUI.fX = dropUI.x = -(dropUI.fWidth / 2);
         this.cleanDSUI();
      }
      
      public function onExtensionResponseHandler(e:*) : void
      {
         var t_dItem:* = undefined;
         var dItem:* = undefined;
         var dID:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var val:* = undefined;
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "dropItem":
                  for(dID in resObj.items)
                  {
                     if(main.Game.world.invTree[dID])
                     {
                        dItem = main.Game.copyObj(main.Game.world.invTree[dID]);
                        if(this.isBlacklisted(dItem.sName.toUpperCase()))
                        {
                           continue;
                        }
                     }
                     else if(this.isBlacklisted(resObj.items[dID].sName.toUpperCase()))
                     {
                        continue;
                     }
                     if(this.itemCount[dID] == null)
                     {
                        this.itemCount[dID] = int(resObj.items[dID].iQty);
                        if(main.Game.world.invTree[dID] == null)
                        {
                           this.invTree.push(main.Game.copyObj(resObj.items[dID]));
                        }
                        else
                        {
                           dItem = main.Game.copyObj(main.Game.world.invTree[dID]);
                           dItem.iQty = int(resObj.items[dID].iQty);
                           this.invTree.push(dItem);
                        }
                        this.invTree[this.invTree.length - 1].dID = dID;
                     }
                     else
                     {
                        this.itemCount[dID] += int(resObj.items[dID].iQty);
                     }
                     this.itemWasAdded = true;
                  }
                  if(!this.mcAttached || this.mcAttached && this.bAttachedOpen)
                  {
                     this.reDraw();
                  }
                  if(this.itemWasAdded && (!this.visible && !this.mcAttached) || this.mcAttached && !this.bAttachedOpen)
                  {
                     main.Game.ui.mcPortrait.getChildByName("iconDrops").onAlert();
                     this.itemWasAdded = false;
                  }
                  break;
               case "addItems":
                  for(dID in resObj.items)
                  {
                     if(!optionHandler.filterChecks["chkSBPDropNotification"])
                     {
                        this.showItemDS(main.Game.world.invTree[dID] == null ? resObj.items[dID] : main.Game.world.invTree[dID],int(resObj.items[dID].iQty));
                     }
                  }
                  break;
               case "getDrop":
                  if(resObj.bSuccess == 1)
                  {
                     if("showDrop" in resObj && resObj.showDrop == 1)
                     {
                        this.showItemDS(main.Game.world.invTree[resObj.ItemID],int(resObj.iQty));
                     }
                  }
                  for(val in this.invTree)
                  {
                     if(this.invTree[val].ItemID == resObj.ItemID)
                     {
                        if(resObj.bSuccess == 1)
                        {
                           this.itemCount[this.invTree[val].dID] = null;
                           this.invTree.splice(val,1);
                        }
                     }
                  }
                  this.reDraw();
                  break;
               case "powerGem":
                  for(dID in resObj.items)
                  {
                     this.showItemDS(main.Game.world.invTree[dID] == null ? resObj.items[dID] : main.Game.world.invTree[dID],int(resObj.items[dID].iQty));
                  }
                  break;
               case "buyItem":
                  if(resObj.CharItemID != -1)
                  {
                     t_dItem = main.Game.copyObj(main.Game.world.shopBuyItem);
                     t_dItem.CharItemID = resObj.CharItemID;
                     this.showItemDS(main.Game.world.invTree[t_dItem.ItemID] == null ? resObj.items[t_dItem.ItemID] : main.Game.world.invTree[t_dItem.ItemID],int(t_dItem.iQty));
                  }
                  break;
               case "ccqr":
                  if(resObj.bSuccess != 0)
                  {
                     this.showQuestpopup(resObj);
                  }
                  break;
               case "Wheel":
                  this.showItemDS(resObj.dropItems["18927"],resObj.dropQty != null ? int(resObj.dropQty) : 1);
                  this.showItemDS(resObj.dropItems["19189"],1);
                  if(resObj.Item != null)
                  {
                     this.showItemDS(resObj.Item,1);
                  }
            }
         }
      }
      
      public function reDraw() : void
      {
         var item:* = undefined;
         var dropItemGet:* = undefined;
         var qtyCtr:int = 0;
         while((!!this.mcAttached ? this.mcAttached : this.menu).numChildren > 1)
         {
            (!!this.mcAttached ? this.mcAttached : this.menu).removeChildAt(1);
         }
         var ctr:int = 0;
         for each(item in this.invTree)
         {
            dropItemGet = new dEntry(item,this.itemCount[item.dID]);
            if(optionHandler.filterChecks["chkInvertDrop"])
            {
               dropItemGet.x = 1.5;
               dropItemGet.y = !!this.mcAttached ? 24 + 21.5 * ctr - 0.5 : 161 + 21.5 * ctr;
            }
            else
            {
               dropItemGet.x = 1.5;
               dropItemGet.y = !!this.mcAttached ? -16 - 21.5 * ctr + 0.5 : 108 - 21.5 * ctr;
            }
            dropItemGet.name = item.sName;
            (!!this.mcAttached ? this.mcAttached : this.menu).addChild(dropItemGet);
            qtyCtr += this.itemCount[item.dID];
            ctr++;
         }
         if(this.mcAttached)
         {
            if(optionHandler.filterChecks["chkInvertDrop"])
            {
               this.mcAttached.inner_menu.y = 0;
               this.mcAttached.inner_menu.height = ctr == 0 ? Number(47.5) : Number(47.5 + 21.5 * (ctr - 1));
               this.mcAttached.y = -521;
            }
            else
            {
               this.mcAttached.inner_menu.y = 4 - 21.5 * ctr;
               this.mcAttached.inner_menu.height = ctr == 0 ? Number(157.7) : Number(157.7 + 21.5 * (ctr - 1));
               this.mcAttached.y = -28;
            }
         }
         else
         {
            this.txtQty.text = " x " + qtyCtr;
            if(optionHandler.filterChecks["chkInvertDrop"])
            {
               this.menu.menuBG.y = 158;
               this.menu.menuBG.height = 21.5 * ctr + 6;
            }
            else
            {
               this.menu.menuBG.y = 108 - 21.5 * (ctr - 1) - 3;
               this.menu.menuBG.height = 21.5 * ctr + 6;
            }
         }
      }
   }
}
