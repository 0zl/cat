package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class listOptionsItem extends MovieClip
   {
       
      
      public var txtName:TextField;
      
      public var txtStatus:TextField;
      
      public var btnLeft:MovieClip;
      
      public var btnRight:MovieClip;
      
      public var bEnabled:Boolean;
      
      public var sDesc:String;
      
      public function listOptionsItem(bEnabled:Boolean, sDesc:String)
      {
         super();
         this.txtStatus.text = !!bEnabled ? "ON" : " OFF";
         this.bEnabled = bEnabled;
         this.sDesc = sDesc;
         this.btnLeft.addEventListener(MouseEvent.CLICK,this.onToggle,false,0,true);
         this.btnRight.addEventListener(MouseEvent.CLICK,this.onToggle,false,0,true);
      }
      
      public function onToggle(e:MouseEvent) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         switch(this.txtName.text)
         {
            case "Custom Drops UI":
               if(optionHandler.sbpcDrops)
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "You can only have one version of the Custom Drops UI enabled! Disable the other one before enabling this one!";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
                  return;
               }
               break;
            case "SBP\'s Custom Drops UI":
               if(optionHandler.cDrops)
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "You can only have one version of the Custom Drops UI enabled! Disable the other one before enabling this one!";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
                  return;
               }
               break;
            case "Disable Map Animations":
               if(!optionHandler.disMapAnim)
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "Enabling \"Disable Map Animations\" will cause map buttons (e.g. Quest Heads) to NOT work!";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
               }
         }
         this.bEnabled = !this.bEnabled;
         this.txtStatus.text = !!this.bEnabled ? "ON" : " OFF";
         optionHandler.cmd(this.txtName.text);
      }
   }
}
