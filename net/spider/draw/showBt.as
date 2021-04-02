package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.spider.main;
   
   public class showBt extends MovieClip
   {
       
      
      public var txtShow:TextField;
      
      public var btShow:SimpleButton;
      
      var item;
      
      public function showBt()
      {
         super();
         this.bt_update();
         this.txtShow.mouseEnabled = false;
         this.btShow.addEventListener(MouseEvent.CLICK,this.onShowBt,false,0,true);
      }
      
      public function bt_update() : void
      {
         var sES:String = main.Game.ui.mcPopup.getChildByName("mcInventory").iSel.sES;
         if(sES == "ar")
         {
            sES = "co";
         }
         if(main.Game.world.myAvatar.objData.eqp[sES] && main.Game.ui.mcPopup.getChildByName("mcInventory").iSel.sFile == main.Game.world.myAvatar.objData.eqp[sES].sFile)
         {
            this.txtShow.text = "Hide";
         }
         else
         {
            this.txtShow.text = "Show";
         }
      }
      
      public function onShowBt(e:MouseEvent) : void
      {
         this.item = main.Game.ui.mcPopup.getChildByName("mcInventory").iSel;
         var sES:String = this.item.sES;
         if(sES == "ar")
         {
            sES = "co";
         }
         if(this.txtShow.text == "Show")
         {
            if(!main.Game.world.myAvatar.objData.eqp[sES])
            {
               main.Game.world.myAvatar.objData.eqp[sES] = {};
               main.Game.world.myAvatar.objData.eqp[sES].wasCreatedShowable = true;
            }
            if(!main.Game.world.myAvatar.objData.eqp[sES].isShowable)
            {
               main.Game.world.myAvatar.objData.eqp[sES].isShowable = true;
               if(!main.Game.world.myAvatar.objData.eqp[sES].isPreview)
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
         }
         else if(main.Game.world.myAvatar.objData.eqp[sES].wasCreatedShowable)
         {
            delete main.Game.world.myAvatar.objData.eqp[sES];
            main.Game.world.myAvatar.unloadMovieAtES(sES);
         }
         else if(main.Game.world.myAvatar.objData.eqp[sES].isShowable)
         {
            main.Game.world.myAvatar.objData.eqp[sES].sType = main.Game.world.myAvatar.objData.eqp[sES].oldType;
            main.Game.world.myAvatar.objData.eqp[sES].sFile = main.Game.world.myAvatar.objData.eqp[sES].oldFile;
            main.Game.world.myAvatar.objData.eqp[sES].sLink = main.Game.world.myAvatar.objData.eqp[sES].oldLink;
            main.Game.world.myAvatar.loadMovieAtES(sES,main.Game.world.myAvatar.objData.eqp[sES].oldFile,main.Game.world.myAvatar.objData.eqp[sES].oldLink);
            main.Game.world.myAvatar.objData.eqp[sES].isShowable = null;
         }
         main.Game.ui.mcPopup.getChildByName("mcInventory").previewPanel.visible = false;
      }
   }
}
