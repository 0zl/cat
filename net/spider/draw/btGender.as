package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getQualifiedClassName;
   import net.spider.avatar.AvatarMC;
   import net.spider.main;
   
   public class btGender extends SimpleButton
   {
       
      
      private var t_tip:ToolTipMC;
      
      public function btGender()
      {
         super();
         this.t_tip = new ToolTipMC();
         main._stage.addChild(this.t_tip);
         this.addEventListener(MouseEvent.CLICK,this.onBtGender,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onHover,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut,false,0,true);
      }
      
      public function onHover(e:MouseEvent) : void
      {
         this.t_tip.openWith({"str":"Switch Gender Preview"});
      }
      
      public function onOut(e:MouseEvent) : void
      {
         this.t_tip.close();
      }
      
      public function onClick(e:MouseEvent) : void
      {
         var mcFocus:String = null;
         var focusMovie:MovieClip = null;
         if(getQualifiedClassName(e.target).indexOf("LPFElementListItemItem") > -1)
         {
            if(main.Game.ui.mcPopup.currentLabel == "Shop")
            {
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.getChildAt(3);
               mcFocus = "mcShop";
            }
            else if(main.Game.ui.mcPopup.currentLabel == "MergeShop")
            {
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.getChildAt(3);
               mcFocus = "mcShop";
            }
            else
            {
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
               mcFocus = "mcInventory";
            }
            focusMovie.mcPreview.visible = true;
            focusMovie.removeChild(focusMovie.getChildByName("genderPreview"));
            MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).removeEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
      
      public function onBtGender(e:Event) : void
      {
         var mcFocus:String = null;
         var focusMovie:MovieClip = null;
         var genderPreview:* = undefined;
         var objChar:Object = null;
         switch(main.Game.ui.mcPopup.currentLabel)
         {
            case "Shop":
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).previewPanel.getChildAt(3);
               mcFocus = "mcShop";
               break;
            case "MergeShop":
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcShop")).mergePanel.getChildAt(3);
               mcFocus = "mcShop";
               break;
            case "Inventory":
               focusMovie = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
               mcFocus = "mcInventory";
         }
         focusMovie.mcPreview.visible = !focusMovie.mcPreview.visible;
         if(!focusMovie.getChildByName("genderPreview"))
         {
            genderPreview = focusMovie.addChild(new AvatarMC());
            genderPreview.name = "genderPreview";
         }
         focusMovie.getChildByName("genderPreview").visible = !focusMovie.mcPreview.visible;
         if(focusMovie.getChildByName("genderPreview").visible)
         {
            objChar = new Object();
            objChar.strGender = main.Game.world.myAvatar.objData.strGender == "M" ? "F" : "M";
            (focusMovie.getChildByName("genderPreview") as AvatarMC).pAV.objData = objChar;
            focusMovie.getChildByName("genderPreview").x = focusMovie.mcPreview.x;
            focusMovie.getChildByName("genderPreview").y = focusMovie.mcPreview.y;
            (focusMovie.getChildByName("genderPreview") as AvatarMC).loadArmor(main.Game.ui.mcPopup.getChildByName(mcFocus).iSel.sFile,main.Game.ui.mcPopup.getChildByName(mcFocus).iSel.sLink);
            focusMovie.setChildIndex(focusMovie.getChildByName("genderPreview"),focusMovie.getChildIndex(focusMovie.tInfo) - 1);
         }
         if(!MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).hasEventListener(MouseEvent.CLICK))
         {
            MovieClip(main.Game.ui.mcPopup.getChildByName(mcFocus)).addEventListener(MouseEvent.CLICK,this.onClick);
         }
      }
   }
}
