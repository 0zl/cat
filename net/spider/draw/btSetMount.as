package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import net.spider.main;
   
   public class btSetMount extends SimpleButton
   {
       
      
      private var t_tip:ToolTipMC;
      
      public function btSetMount()
      {
         super();
         this.t_tip = new ToolTipMC();
         main._stage.addChild(this.t_tip);
         this.addEventListener(MouseEvent.CLICK,this.onSetMount,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.onHover,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.onOut,false,0,true);
      }
      
      public function onHover(e:MouseEvent) : void
      {
         this.t_tip.openWith({"str":"Set Primary Mount"});
      }
      
      public function onOut(e:MouseEvent) : void
      {
         this.t_tip.close();
      }
      
      public function warning() : void
      {
         var modalClass:Class = main.Game.world.getClass("ModalMC");
         var modal:* = new modalClass();
         var modalO:* = {};
         modalO.strBody = "This armor is not a mount!";
         modalO.params = {};
         modalO.glow = "red,medium";
         modalO.btns = "mono";
         main._stage.addChild(modal);
         modal.init(modalO);
      }
      
      public function onSetMount(e:MouseEvent) : void
      {
         var t_obj:Object = null;
         if(!main.Game.ui.mcPopup.getChildByName("mcInventory"))
         {
            return;
         }
         if(!main.Game.ui.mcPopup.getChildByName("mcInventory").iSel)
         {
            return;
         }
         var mcFocus:MovieClip = MovieClip(main.Game.ui.mcPopup.getChildByName("mcInventory")).previewPanel.getChildAt(3);
         if(!mcFocus.mcPreview)
         {
            return;
         }
         if(!mcFocus.mcPreview.getChildByName("previewMCB"))
         {
            return;
         }
         var mnt:MovieClip = mcFocus.mcPreview.getChildByName("previewMCB").mcChar.robe.getChildAt(0);
         for(var i:* = 0; i < mnt.currentLabels.length; i++)
         {
            trace(mnt.currentLabels[i].name);
            if(mnt.currentLabels[i].name.indexOf("Walk") == 0)
            {
               t_obj = !!main.sharedObject.data.savedMounts ? main.sharedObject.data.savedMounts : [];
               t_obj[main.Game.world.myAvatar.objData.strUsername.toLowerCase()] = main.Game.ui.mcPopup.getChildByName("mcInventory").iSel.ItemID;
               main.sharedObject.data.savedMounts = t_obj;
               main.sharedObject.flush();
               return;
            }
         }
         this.warning();
      }
   }
}
