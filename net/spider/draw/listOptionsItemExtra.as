package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class listOptionsItemExtra extends MovieClip
   {
       
      
      public var txtName:TextField;
      
      public var chkActive:MovieClip;
      
      public var sDesc:String;
      
      public function listOptionsItemExtra(bEnabled:Boolean, sDesc:String)
      {
         super();
         this.sDesc = sDesc;
         this.chkActive.checkmark.visible = bEnabled;
         this.chkActive.addEventListener(MouseEvent.CLICK,this.onToggle,false,0,true);
      }
      
      public function onToggle(e:MouseEvent) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         switch(this.txtName.text)
         {
            case "Force Basic Rider Animation":
               if(optionHandler.filterChecks["chkHorseRiderAnim"])
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "You can only have one of these enabled at a time.";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
                  return;
               }
               break;
            case "Force Horse Rider Animation":
               if(optionHandler.filterChecks["chkBasicRiderAnim"])
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "You can only have one of these enabled at a time.";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
                  return;
               }
               break;
            case "Warn When Declining A Drop":
               if(!optionHandler.sbpcDrops && !optionHandler.cDrops)
               {
                  modalClass = main.Game.world.getClass("ModalMC");
                  modal = new modalClass();
                  modalO = {};
                  modalO.strBody = "You must enable the feature before changing this setting.";
                  modalO.params = {};
                  modalO.glow = "red,medium";
                  modalO.btns = "mono";
                  main._stage.addChild(modal);
                  modal.init(modalO);
                  return;
               }
               break;
         }
         this.chkActive.checkmark.visible = !this.chkActive.checkmark.visible;
         optionHandler.cmd(this.txtName.text);
      }
   }
}
