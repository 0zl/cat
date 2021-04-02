package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import net.spider.handlers.ClientEvent;
   import net.spider.main;
   
   public class tryMe extends MovieClip
   {
       
      
      public var btnTry:SimpleButton;
      
      var item;
      
      var petDisable:Timer;
      
      public function tryMe()
      {
         this.petDisable = new Timer(0);
         super();
         this.btnTry.addEventListener(MouseEvent.CLICK,this.onBtnTry,false,0,true);
      }
      
      function onBtnTry(e:MouseEvent) : void
      {
         this.item = main.Game.ui.mcPopup.getChildByName("mcShop").iSel;
         var sES:String = this.item.sES;
         if(sES == "ar")
         {
            sES = "co";
         }
         if(sES == "pe")
         {
            if(main.Game.world.myAvatar.objData.eqp["pe"])
            {
               main.Game.world.myAvatar.unloadPet();
            }
         }
         if(!main.Game.world.myAvatar.objData.eqp[sES])
         {
            main.Game.world.myAvatar.objData.eqp[sES] = {};
            main.Game.world.myAvatar.objData.eqp[sES].wasCreated = true;
         }
         if(!main.Game.world.myAvatar.objData.eqp[sES].isPreview)
         {
            main.Game.world.myAvatar.objData.eqp[sES].isPreview = true;
            if(!main.Game.world.myAvatar.objData.eqp[sES].isShowable)
            {
               if("sType" in this.item)
               {
                  main.Game.world.myAvatar.objData.eqp[sES].oldType = main.Game.world.myAvatar.objData.eqp[sES].sType;
               }
               main.Game.world.myAvatar.objData.eqp[sES].oldFile = main.Game.world.myAvatar.objData.eqp[sES].sFile;
               main.Game.world.myAvatar.objData.eqp[sES].oldLink = main.Game.world.myAvatar.objData.eqp[sES].sLink;
            }
         }
         if("sType" in this.item)
         {
            main.Game.world.myAvatar.objData.eqp[sES].sType = this.item.sType;
         }
         main.Game.world.myAvatar.objData.eqp[sES].sFile = this.item.sFile == "undefined" ? "" : this.item.sFile;
         main.Game.world.myAvatar.objData.eqp[sES].sLink = this.item.sLink;
         main.Game.world.myAvatar.loadMovieAtES(sES,this.item.sFile,this.item.sLink);
         if(sES == "pe" && this.item.sName.indexOf("Bank Pet") != -1)
         {
            this.petDisable.addEventListener(TimerEvent.TIMER,this.onPetDisable,false,0,true);
            this.petDisable.start();
         }
         if(main.Game.ui.mcPopup.currentLabel == "MergeShop")
         {
            main.Game.ui.mcPopup.getChildByName("mcShop").fClose();
         }
         else
         {
            main.Game.ui.mcPopup.getChildByName("mcShop").previewPanel.visible = false;
         }
         main.events.dispatchEvent(new ClientEvent(ClientEvent.onCostumePending));
      }
      
      function onPetDisable(e:TimerEvent) : void
      {
         if(!main.Game.world.myAvatar.petMC.mcChar)
         {
            return;
         }
         main.Game.world.myAvatar.petMC.mcChar.mouseEnabled = false;
         main.Game.world.myAvatar.petMC.mcChar.mouseChildren = false;
         main.Game.world.myAvatar.petMC.mcChar.enabled = false;
         this.petDisable.reset();
         this.petDisable.removeEventListener(TimerEvent.TIMER,this.onPetDisable);
      }
   }
}
