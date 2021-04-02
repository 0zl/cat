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
   import net.spider.main;
   
   public class travelMenu extends MovieClip
   {
       
      
      public var btnClear:SimpleButton;
      
      public var btnAdd:SimpleButton;
      
      public var btnDel:SimpleButton;
      
      public var txtSave:TextField;
      
      public var btnClose:SimpleButton;
      
      public var btnUp:SimpleButton;
      
      public var listTravel:List;
      
      public var txtExpand:TextField;
      
      public var btnTravel:SimpleButton;
      
      public var txtTravel:TextField;
      
      public var btnExpand:SimpleButton;
      
      public var btnDown:SimpleButton;
      
      public var frame:MovieClip;
      
      public var btnDelSave:SimpleButton;
      
      public var btnSave:SimpleButton;
      
      public var cbSave:ComboBox;
      
      private var lObj:Object;
      
      private var lIndex:int;
      
      public function travelMenu()
      {
         super();
         this.txtExpand.mouseEnabled = false;
         this.frame.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag,false,0,true);
         this.frame.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
         this.btnAdd.addEventListener(MouseEvent.CLICK,this.onBtnAdd,false,0,true);
         this.btnDel.addEventListener(MouseEvent.CLICK,this.onBtnDel,false,0,true);
         this.btnUp.addEventListener(MouseEvent.CLICK,this.onBtnUp,false,0,true);
         this.btnDown.addEventListener(MouseEvent.CLICK,this.onBtnDown,false,0,true);
         this.btnTravel.addEventListener(MouseEvent.CLICK,this.onBtnTravel,false,0,true);
         this.btnSave.addEventListener(MouseEvent.CLICK,this.onBtnSave,false,0,true);
         this.btnClear.addEventListener(MouseEvent.CLICK,this.onBtnClear,false,0,true);
         this.btnDelSave.addEventListener(MouseEvent.CLICK,this.onBtnDelSave,false,0,true);
         this.cbSave.addEventListener(MouseEvent.CLICK,this.onCbSaveChange,false,0,true);
         this.cbSave.addEventListener(Event.CHANGE,this.onCbSaveChange,false,0,true);
         this.btnExpand.addEventListener(MouseEvent.CLICK,this.onBtnExpand,false,0,true);
         this.btnClose.addEventListener(MouseEvent.CLICK,this.onBtnClose,false,0,true);
         if(main.sharedObject.data.travelSaves)
         {
            this.cbSave.dataProvider = new DataProvider(main.sharedObject.data.travelSaves);
         }
      }
      
      public function onBtnSave(e:MouseEvent) : void
      {
         if(this.txtSave.length < 1)
         {
            return;
         }
         if(this.listTravel.dataProvider.length < 1)
         {
            return;
         }
         this.cbSave.dataProvider.addItem({
            "label":StringUtil.trim(this.txtSave.text),
            "data":this.listTravel.dataProvider.toArray()
         });
         main.sharedObject.data.travelSaves = this.cbSave.dataProvider.toArray();
         main.sharedObject.flush();
         this.cbSave.dataProvider.invalidate();
         this.txtSave.text = "";
         main._stage.focus = null;
      }
      
      public function onBtnClear(e:MouseEvent) : void
      {
         this.listTravel.dataProvider.removeAll();
         main._stage.focus = null;
      }
      
      public function onBtnDelSave(e:MouseEvent) : void
      {
         if(!main.sharedObject.data.travelSaves)
         {
            return;
         }
         this.cbSave.dataProvider.removeItemAt(this.cbSave.selectedIndex);
         main.sharedObject.data.travelSaves = this.cbSave.dataProvider.toArray();
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
         this.listTravel.dataProvider = new DataProvider(this.cbSave.selectedItem.data);
         this.listTravel.dataProvider.invalidate();
      }
      
      public function onBtnExpand(e:MouseEvent) : void
      {
         this.txtExpand.text = this.txtExpand.text == "+" ? "-" : "+";
         var i:int = 0;
         if(this.frame.visible)
         {
            while(i < this.numChildren)
            {
               if(this.getChildAt(i).name != "btnExpand" && this.getChildAt(i).name != "txtExpand")
               {
                  this.getChildAt(i).visible = false;
               }
               i++;
            }
         }
         else
         {
            while(i < this.numChildren)
            {
               this.getChildAt(i).visible = true;
               i++;
            }
         }
         main._stage.focus = null;
      }
      
      public function onDrag(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function onStopDrag(e:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function onBtnClose(e:MouseEvent) : void
      {
         this.visible = false;
         main._stage.focus = null;
      }
      
      public function onBtnAdd(e:MouseEvent) : void
      {
         if(this.txtTravel.text != "")
         {
            this.listTravel.dataProvider.addItem({"label":StringUtil.trim(this.txtTravel.text)});
         }
         this.txtTravel.text = "";
      }
      
      public function onBtnDel(e:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex > -1)
         {
            this.listTravel.dataProvider.removeItemAt(this.listTravel.selectedIndex);
         }
         this.listTravel.selectedIndex = 0;
         main._stage.focus = null;
      }
      
      public function onBtnUp(e:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex == -1)
         {
            return;
         }
         if(this.listTravel.selectedIndex != -1 && this.listTravel.selectedIndex != 0)
         {
            this.lObj = this.listTravel.selectedItem;
            this.lIndex = this.listTravel.selectedIndex - 1;
            this.listTravel.dataProvider.removeItem(this.listTravel.selectedItem);
            this.listTravel.dataProvider.addItemAt(this.lObj,this.lIndex);
            this.listTravel.selectedIndex = this.lIndex;
         }
         main._stage.focus = null;
      }
      
      public function onBtnDown(e:MouseEvent) : void
      {
         if(this.listTravel.selectedIndex == -1)
         {
            return;
         }
         if(this.listTravel.selectedIndex < this.listTravel.length - 1)
         {
            this.lObj = this.listTravel.selectedItem;
            this.lIndex = this.listTravel.selectedIndex + 1;
            this.listTravel.dataProvider.removeItem(this.listTravel.selectedItem);
            this.listTravel.dataProvider.addItemAt(this.lObj,this.lIndex);
            this.listTravel.selectedIndex = this.lIndex;
         }
         main._stage.focus = null;
      }
      
      public function dispatchTravel() : void
      {
         this.btnTravel.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onBtnTravel(e:MouseEvent) : void
      {
         var town:String = null;
         var cell:String = null;
         var pad:String = null;
         if(this.listTravel.length < 1)
         {
            return;
         }
         if(this.listTravel.selectedIndex == -1)
         {
            this.listTravel.selectedIndex = 0;
         }
         if(main.Game.world.myAvatar.dataLeaf.intState == 0)
         {
            main.Game.MsgBox.notify("You are dead!");
         }
         else if(!main.Game.world.myAvatar.invLoaded || !main.Game.world.myAvatar.pMC.artLoaded())
         {
            main.Game.MsgBox.notify("Character still being loaded.");
         }
         else if(main.Game.world.coolDown("tfer"))
         {
            town = this.listTravel.selectedItem.label;
            main.Game.MsgBox.notify("Joining " + town);
            cell = "Enter";
            pad = "Spawn";
            main.Game.world.setReturnInfo(town,cell,pad);
            main.Game.sfc.sendXtMessage("zm","cmd",["tfer",main.Game.sfc.myUserName,town,cell,pad],"str",main.Game.world.curRoom);
            if(main.Game.world.strAreaName.indexOf("battleon") < 0 || main.Game.world.strAreaName.indexOf("battleontown") > -1)
            {
               main.Game.menuClose();
            }
            ++this.listTravel.selectedIndex;
            if(this.listTravel.selectedIndex > this.listTravel.length - 1)
            {
               this.listTravel.selectedIndex = 0;
            }
         }
         else
         {
            main.Game.MsgBox.notify("Not able to travel yet, please wait.");
         }
         main._stage.focus = null;
      }
   }
}
