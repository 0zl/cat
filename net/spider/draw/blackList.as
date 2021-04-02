package net.spider.draw
{
   import com.adobe.utils.StringUtil;
   import fl.controls.ComboBox;
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class blackList extends MovieClip
   {
       
      
      public var btnClear:SimpleButton;
      
      public var btnAdd:SimpleButton;
      
      public var btnDel:SimpleButton;
      
      public var txtSave:TextField;
      
      public var btnClose:SimpleButton;
      
      public var frame:MovieClip;
      
      public var btnDelSave:SimpleButton;
      
      public var txtBlacklist:TextField;
      
      public var btnSave:SimpleButton;
      
      public var cbSave:ComboBox;
      
      public var listBlack:List;
      
      public function blackList()
      {
         super();
         this.frame.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag,false,0,true);
         this.frame.addEventListener(MouseEvent.MOUSE_UP,this.onMRelease,false,0,true);
         this.btnAdd.addEventListener(MouseEvent.CLICK,this.onBtnAddBlacklist,false,0,true);
         this.btnDel.addEventListener(MouseEvent.CLICK,this.onBtnRemoveBlacklist,false,0,true);
         this.btnClear.addEventListener(MouseEvent.CLICK,this.onBtnClearBlacklist,false,0,true);
         this.btnSave.addEventListener(MouseEvent.CLICK,this.onBtnSave,false,0,true);
         this.btnDelSave.addEventListener(MouseEvent.CLICK,this.onBtnDelSave,false,0,true);
         this.cbSave.addEventListener(MouseEvent.CLICK,this.onCbSaveChange,false,0,true);
         this.cbSave.addEventListener(Event.CHANGE,this.onCbSaveChange,false,0,true);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.onClose,false,0,true);
         if(main.sharedObject.data.listBlack)
         {
            this.listBlack.dataProvider = new DataProvider(main.sharedObject.data.listBlack);
         }
         if(main.sharedObject.data.blacklistSaves)
         {
            this.cbSave.dataProvider = new DataProvider(main.sharedObject.data.blacklistSaves);
         }
      }
      
      public function onBtnSave(e:MouseEvent) : void
      {
         if(this.txtSave.length < 1)
         {
            return;
         }
         if(this.listBlack.dataProvider.length < 1)
         {
            return;
         }
         this.cbSave.dataProvider.addItem({
            "label":StringUtil.trim(this.txtSave.text),
            "data":this.listBlack.dataProvider.toArray()
         });
         main.sharedObject.data.blacklistSaves = this.cbSave.dataProvider.toArray();
         main.sharedObject.flush();
         this.cbSave.dataProvider.invalidate();
         this.txtSave.text = "";
         main._stage.focus = null;
      }
      
      public function onBtnDelSave(e:MouseEvent) : void
      {
         if(!main.sharedObject.data.blacklistSaves)
         {
            return;
         }
         this.cbSave.dataProvider.removeItemAt(this.cbSave.selectedIndex);
         main.sharedObject.data.blacklistSaves = this.cbSave.dataProvider.toArray();
         main.sharedObject.flush();
         this.cbSave.dataProvider.invalidate();
         main._stage.focus = null;
      }
      
      public function onCbSaveChange(e:*) : void
      {
         if(this.cbSave.selectedIndex < 0)
         {
            return;
         }
         this.listBlack.dataProvider = new DataProvider(this.cbSave.selectedItem.data);
         main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
         main.sharedObject.flush();
         optionHandler.blackListed = this.listBlack.dataProvider.toArray();
      }
      
      private function onClose(e:MouseEvent) : void
      {
         optionHandler.blackListMC = null;
         this.parent.removeChild(this);
      }
      
      private function blacklistwarn() : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         modalClass = main.Game.world.getClass("ModalMC");
         modal = new modalClass();
         modalO = {};
         modalO.strBody = "You must relog for blacklist changes to take effect";
         modalO.glow = "red,medium";
         modalO.btns = "mono";
         main._stage.addChild(modal);
         modal.init(modalO);
      }
      
      private function onBtnAddBlacklist(evt:MouseEvent) : void
      {
         if(!this.listBlack)
         {
            return;
         }
         this.listBlack.dataProvider.addItem({
            "label":this.txtBlacklist.text.toUpperCase(),
            "value":this.txtBlacklist.text.toUpperCase()
         });
         main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
         main.sharedObject.flush();
         optionHandler.blackListed = this.listBlack.dataProvider.toArray();
         this.txtBlacklist.text = "";
      }
      
      private function onBtnRemoveBlacklist(evt:MouseEvent) : void
      {
         if(!this.listBlack)
         {
            return;
         }
         if(this.listBlack.selectedIndex != -1)
         {
            this.listBlack.removeItemAt(this.listBlack.selectedIndex);
            this.listBlack.selectedIndex = -1;
         }
         main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
         main.sharedObject.flush();
         optionHandler.blackListed = main.sharedObject.data.listBlack;
         this.blacklistwarn();
      }
      
      private function onBtnClearBlacklist(evt:MouseEvent) : void
      {
         if(!this.listBlack)
         {
            return;
         }
         this.listBlack.removeAll();
         main.sharedObject.data.listBlack = this.listBlack.dataProvider.toArray();
         main.sharedObject.flush();
         optionHandler.blackListed = main.sharedObject.data.listBlack;
         this.blacklistwarn();
      }
      
      private function onDrag(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMRelease(e:MouseEvent) : void
      {
         this.stopDrag();
      }
   }
}
