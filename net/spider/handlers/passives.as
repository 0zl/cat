package net.spider.handlers
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import net.spider.main;
   
   public class passives extends MovieClip
   {
      
      static var lastClass:String;
       
      
      public var titleBar:TextField;
      
      public var passivesTxt:TextField;
      
      public var head:MovieClip;
      
      public var back:MovieClip;
      
      public function passives()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         lastClass = "";
      }
      
      public static function onFrameUpdate() : void
      {
         if(!optionHandler.passive || !main.Game.sfc.isConnected || !main.Game.world.actions.passive)
         {
            return;
         }
         if(main.Game.ui.mcPopup.currentLabel == "Charpanel" && lastClass == main.Game.world.myAvatar.objData.strClassName)
         {
            if(main.Game.ui.mcPopup.mcCharpanel.cnt2.abilities.getChildByName("a10"))
            {
               return;
            }
         }
         if(main.Game.ui.mcPopup.currentLabel != "Charpanel")
         {
            return;
         }
         if(main.Game.world.actions.passive.length != 3)
         {
            return;
         }
         if(!main.Game.ui.mcPopup.mcCharpanel || !main.Game.ui.mcPopup.mcCharpanel.cnt2 || !main.Game.ui.mcPopup.mcCharpanel.cnt2.abilities)
         {
            return;
         }
         trace("DRAW");
         var mcPanel:* = main.Game.ui.mcPopup.mcCharpanel.cnt2.abilities;
         mcPanel.x = 20;
         var ico:Class = main.Game.world.getClass("ib2");
         var rnk:* = new ico();
         rnk.height = mcPanel.a4.height;
         rnk.width = mcPanel.a4.width;
         rnk.x = mcPanel.a4.x + mcPanel.a4.width + 5;
         rnk.y = mcPanel.a4.y;
         var o:* = main.Game.world.actions.passive[2];
         rnk.tQty.visible = false;
         main.Game.updateIcons([rnk],o.icon.split(","),null);
         if(!o.isOK)
         {
            rnk.alpha = 0.33;
         }
         rnk.actObj = o;
         rnk.addEventListener(MouseEvent.MOUSE_OVER,main.Game.actIconOver,false,0,true);
         rnk.addEventListener(MouseEvent.MOUSE_OUT,main.Game.actIconOut,false,0,true);
         rnk.name = "a10";
         mcPanel.addChild(rnk);
         var uoData:* = main.Game.world.myAvatar.objData;
         var g:* = mcPanel.bg.graphics;
         g.lineStyle(0,0,0);
         var ox:* = 0;
         var boxFill:* = 6710886;
         var textCol:* = "#FFFFFF";
         ox = 5 * 51;
         boxFill = 6710886;
         textCol = "#FFFFFF";
         if(uoData.iRank < 10)
         {
            boxFill = 2368548;
            textCol = "#999999";
            g.beginFill(boxFill);
            g.moveTo(ox,19);
            g.lineTo(ox + 50,19);
            g.lineTo(ox + 50,127);
            g.lineTo(ox,127);
            g.lineTo(ox,19);
            g.endFill();
         }
         g.beginFill(boxFill);
         g.moveTo(ox,0);
         g.lineTo(ox + 50,0);
         g.lineTo(ox + 50,18);
         g.lineTo(ox,18);
         g.lineTo(ox,0);
         g.endFill();
         g.beginFill(boxFill);
         g.moveTo(ox,128);
         g.lineTo(ox + 50,128);
         g.lineTo(ox + 50,132);
         g.lineTo(ox,132);
         g.lineTo(ox,128);
         g.endFill();
         var rnkDisplay:* = new TextField();
         rnkDisplay.type = TextFieldType.DYNAMIC;
         rnkDisplay.mouseEnabled = false;
         var txtFormat:TextFormat = mcPanel.tRank5.defaultTextFormat;
         txtFormat.font = "Arial";
         txtFormat.size = 11;
         rnkDisplay.setTextFormat(txtFormat);
         rnkDisplay.height = mcPanel.tRank5.height;
         rnkDisplay.width = 45;
         rnkDisplay.x = mcPanel.tRank5.x + mcPanel.tRank5.width + 9;
         rnkDisplay.y = mcPanel.tRank5.y - 1;
         rnkDisplay.htmlText = "<font face=\'Arial\' size=\'11\' color=\'" + textCol + "\'><b>" + "Rank 10</b></font>";
         mcPanel.addChild(rnkDisplay);
         lastClass = main.Game.world.myAvatar.objData.strClassName;
      }
   }
}
