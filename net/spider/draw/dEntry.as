package net.spider.draw
{
   import fl.data.DataProvider;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class dEntry extends MovieClip
   {
       
      
      public var btPreview:SimpleButton;
      
      public var icon:MovieClip;
      
      public var overEntryBar:MovieClip;
      
      public var btNo:SimpleButton;
      
      public var txtDrop:TextField;
      
      public var iconAC:MovieClip;
      
      public var btYes:SimpleButton;
      
      public var entryBar:MovieClip;
      
      public var itemObj:Object;
      
      var format:TextFormat;
      
      var alreadyClicked:Boolean = false;
      
      var allowPass:Boolean = false;
      
      public function dEntry(resObj:Object, relQty:int)
      {
         var AssetClass:Class = null;
         var mcIcon:* = undefined;
         var check:detailedCheck = null;
         this.format = new TextFormat();
         super();
         this.alreadyClicked = false;
         this.allowPass = false;
         this.gotoAndStop("idle");
         this.btYes.visible = false;
         this.btNo.visible = false;
         this.btPreview.visible = false;
         this.itemObj = resObj;
         this.iconAC.visible = resObj.bCoins == 1;
         this.txtDrop.text = "";
         this.txtDrop.htmlText = "";
         if(resObj.bUpg == 1)
         {
            this.txtDrop.htmlText = "<font color=\'#FCC749\'>" + resObj.sName + " x " + relQty + "</font>";
         }
         else
         {
            this.txtDrop.text = resObj.sName + " x " + relQty;
         }
         if(this.iconAC.visible)
         {
            this.iconAC.x = this.txtDrop.textWidth + 35;
         }
         var sIcon:String = "";
         if(resObj.sType.toLowerCase() == "enhancement")
         {
            sIcon = main.Game.getIconBySlot(resObj.sES);
         }
         else if(resObj.sType.toLowerCase() == "serveruse" || resObj.sType.toLowerCase() == "clientuse")
         {
            if("sFile" in resObj && resObj.sFile.length > 0 && main.Game.world.getClass(resObj.sFile) != null)
            {
               sIcon = resObj.sFile;
            }
            else
            {
               sIcon = resObj.sIcon;
            }
         }
         else if(resObj.sIcon == null || resObj.sIcon == "" || resObj.sIcon == "none")
         {
            if(resObj.sLink.toLowerCase() != "none")
            {
               sIcon = "iidesign";
            }
            else
            {
               sIcon = "iibag";
            }
         }
         else
         {
            sIcon = resObj.sIcon;
         }
         try
         {
            AssetClass = main.Game.world.getClass(sIcon) as Class;
            mcIcon = this.icon.addChild(new AssetClass());
         }
         catch(e:Error)
         {
            AssetClass = main.Game.world.getClass("iibag") as Class;
            mcIcon = this.icon.addChild(new AssetClass());
         }
         if(this.isOwned(resObj.bHouse,resObj.ItemID))
         {
            check = new detailedCheck();
            check.width = mcIcon.width;
            check.height = mcIcon.height;
            check.x = 0;
            check.y = 0;
            mcIcon.addChild(check);
         }
         mcIcon.scaleX = mcIcon.scaleY = 0.4;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onHighlight,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onDeHighlight,false,0,true);
         this.addEventListener(MouseEvent.CLICK,this.onShiftClick,false,0,true);
         this.btYes.addEventListener(MouseEvent.CLICK,this.onBtYes,false,0,true);
         this.btNo.addEventListener(MouseEvent.CLICK,this.onBtNo,false,0,true);
         this.btPreview.addEventListener(MouseEvent.CLICK,this.onBtPreview,false,0,true);
      }
      
      function onShiftClick(e:MouseEvent) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         if(e.shiftKey)
         {
            modalClass = main.Game.world.getClass("ModalMC");
            modal = new modalClass();
            modalO = {};
            modalO.strBody = "Are you sure you want to add " + this.itemObj.sName + " to the item blacklist?";
            modalO.callback = this.onModifyBlacklist;
            modalO.params = {"sName":this.itemObj.sName};
            modalO.glow = "red,medium";
            modalO.btns = "dual";
            main._stage.addChild(modal);
            modal.init(modalO);
         }
      }
      
      function onModifyBlacklist(o:Object) : void
      {
         var t_dataProvider:DataProvider = null;
         if(o.accept)
         {
            t_dataProvider = new DataProvider(main.sharedObject.data.listBlack);
            t_dataProvider.addItem({
               "label":o.sName.toUpperCase(),
               "value":o.sName.toUpperCase()
            });
            main.sharedObject.data.listBlack = t_dataProvider.toArray();
            main.sharedObject.flush();
            optionHandler.blackListed = main.sharedObject.data.listBlack;
            optionHandler.dropmenutwoMC.onBtNo(this.itemObj);
         }
         main._stage.focus = null;
      }
      
      function isOwned(isHouse:Boolean, itemID:*) : Boolean
      {
         var item:* = undefined;
         for each(item in !!isHouse ? main.Game.world.myAvatar.houseitems : main.Game.world.myAvatar.items)
         {
            if(item.ItemID == itemID)
            {
               return true;
            }
         }
         if(main.Game.world.bankinfo.isItemInBank(itemID))
         {
            return true;
         }
         return false;
      }
      
      function updateFormat(size:int) : void
      {
         this.format.size = size;
         this.txtDrop.setTextFormat(this.format);
      }
      
      function onAcceptDrop(o:Object) : void
      {
         if(o.accept)
         {
            this.alreadyClicked = false;
            this.btYes.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      function onBtYes(e:MouseEvent) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         var nutext:String = null;
         if(this.alreadyClicked)
         {
            modalClass = main.Game.world.getClass("ModalMC");
            modal = new modalClass();
            modalO = {};
            modalO.strBody = "Are you sure you want to accept the drop for " + this.itemObj.sName + " again? You might get disconnected!";
            modalO.callback = this.onAcceptDrop;
            modalO.params = {"sName":this.itemObj.sName};
            modalO.glow = "red,medium";
            modalO.btns = "dual";
            main._stage.addChild(modal);
            modal.init(modalO);
            return;
         }
         for(var i:int = 0; i < main.Game.ui.dropStack.numChildren; i++)
         {
            if(main.Game.ui.dropStack.getChildAt(i))
            {
               if(this.itemObj.iStk == 1)
               {
                  if(main.Game.ui.dropStack.getChildAt(i).cnt && main.Game.ui.dropStack.getChildAt(i).cnt.strName)
                  {
                     if(main.Game.ui.dropStack.getChildAt(i).cnt.strName.text == this.itemObj.sName)
                     {
                        main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        this.alreadyClicked = true;
                        break;
                     }
                  }
               }
               else
               {
                  nutext = main.Game.ui.dropStack.getChildAt(i).cnt.strName.text;
                  nutext = nutext.substring(0,nutext.lastIndexOf(" x"));
                  if(nutext == this.itemObj.sName)
                  {
                     main.Game.ui.dropStack.getChildAt(i).cnt.ybtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                     this.alreadyClicked = true;
                     break;
                  }
               }
            }
         }
         main._stage.focus = null;
      }
      
      function onDeclineDrop(o:Object) : void
      {
         if(o.accept)
         {
            this.allowPass = true;
            this.btNo.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      function onBtNo(e:MouseEvent) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         if(optionHandler.filterChecks["chkSBPDecline"])
         {
            if(!this.allowPass)
            {
               modalClass = main.Game.world.getClass("ModalMC");
               modal = new modalClass();
               modalO = {};
               modalO.strBody = "Are you sure you want to decline the drop for " + this.itemObj.sName + "?";
               modalO.callback = this.onDeclineDrop;
               modalO.params = {"sName":this.itemObj.sName};
               modalO.glow = "red,medium";
               modalO.btns = "dual";
               main._stage.addChild(modal);
               modal.init(modalO);
               return;
            }
         }
         optionHandler.dropmenutwoMC.onBtNo(this.itemObj);
         this.allowPass = false;
         main._stage.focus = null;
      }
      
      function onBtPreview(e:MouseEvent) : void
      {
         if(main.Game.ui.getChildByName("renderPreview"))
         {
            main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
         }
         var dRenderObj:* = new dRender(this.itemObj);
         dRenderObj.name = "renderPreview";
         main.Game.ui.addChild(dRenderObj);
         main._stage.focus = null;
      }
      
      function onHighlight(e:MouseEvent) : void
      {
         this.gotoAndStop("hover");
         this.btYes.visible = true;
         this.btNo.visible = true;
         this.btPreview.visible = true;
      }
      
      function onDeHighlight(e:MouseEvent) : void
      {
         this.gotoAndStop("idle");
         this.btYes.visible = false;
         this.btNo.visible = false;
         this.btPreview.visible = false;
      }
   }
}
