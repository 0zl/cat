package net.spider.handlers
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import net.spider.main;
   
   public class chatui extends MovieClip
   {
       
      
      public var tabShadowBar:MovieClip;
      
      private var activeTab:Number = 0;
      
      private var chatBox:MovieClip;
      
      private var chatBox_mask:Shape;
      
      private var tabs:Vector.<Object>;
      
      private var messages:Vector.<Object>;
      
      private var ghostBt1:MovieClip;
      
      private var ghostBt2:MovieClip;
      
      private var heightConst:Number = -137;
      
      public function chatui()
      {
         var txt:String = null;
         super();
         this.tabs = new <Object>[{"label":"GENERAL"},{"label":"CHAT"},{"label":"SYSTEM"},{"label":"PARTY"},{"label":"GUILD"},{"label":"WHISPER"}];
         var game_chat:* = main.Game.ui.mcInterface.t1;
         this.x = game_chat.x - 12;
         this.y = this.heightConst - this.height;
         this.messages = new Vector.<Object>();
         this.chatBox = new MovieClip();
         this.chatBox_mask = new Shape();
         this.chatBox_mask.graphics.beginFill(0);
         this.chatBox_mask.graphics.drawRect(0,0,game_chat.width,game_chat.height);
         this.chatBox_mask.graphics.endFill();
         main.Game.ui.mcInterface.addChild(this.chatBox_mask);
         this.chatBox_mask.name = "chatBox_chatBox_mask";
         this.chatBox_mask.x = game_chat.x;
         this.chatBox_mask.y = game_chat.y;
         this.chatBox.x = game_chat.x;
         this.chatBox.y = game_chat.y;
         this.chatBox.mask = this.chatBox_mask;
         this.draw_tab();
         main.Game.addEventListener(MouseEvent.MOUSE_WHEEL,this.onWheel,false,0,true);
         main.Game.ui.mcInterface.bShortTall.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         var id:Number = 1;
         for(var i:uint = 0; i < game_chat.numChildren; i++)
         {
            if(game_chat.getChildAt(i).getChildAt(0).ti)
            {
               txt = game_chat.getChildAt(i).getChildAt(0).ti.htmlText;
               switch(true)
               {
                  case txt.indexOf("COLOR=\"#FF0000\"") > -1:
                  case txt.indexOf("COLOR=\"#00FFFF\"") > -1:
                     id = 2;
                     break;
                  case txt.indexOf("COLOR=\"#00CCFF\"") > -1:
                     id = 3;
                     break;
                  case txt.indexOf("COLOR=\"#99FF00\"") > -1:
                     id = 4;
                     break;
                  case txt.indexOf("COLOR=\"#990099\"") > -1:
                  case txt.indexOf("COLOR=\"#FF00FF\"") > -1:
                     id = 5;
               }
               this.messages.push({
                  "id":id,
                  "message":txt,
                  "timestamp":"<font size=\"11\" style=\"font-family:purista;\">" + format_time() + "</font> "
               });
            }
         }
         main.Game.ui.mcInterface.bShortTall.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         main.Game.ui.mcInterface.addChild(this.chatBox);
         this.chatBox.name = "chatui_chatBox";
         game_chat.visible = false;
         this.filterMessages();
         this.chatBox.mouseEnabled = this.chatBox.mouseChildren = false;
         game_chat.addEventListener(Event.ADDED,this.onAdded,false,0,true);
         main.Game.ui.mcInterface.bShortTall.mouseEnabled = main.Game.ui.mcInterface.bShortTall.mouseChildren = false;
         main.Game.ui.mcInterface.bMinMax.mouseEnabled = main.Game.ui.mcInterface.bMinMax.mouseChildren = false;
         var ghostBtShape:Shape = new Shape();
         ghostBtShape.graphics.beginFill(0,0);
         ghostBtShape.graphics.drawRect(0,0,main.Game.ui.mcInterface.bShortTall.width,main.Game.ui.mcInterface.bShortTall.height);
         ghostBtShape.graphics.endFill();
         this.ghostBt1 = new MovieClip();
         this.ghostBt1.addChild(ghostBtShape);
         main.Game.ui.mcInterface.addChild(this.ghostBt1);
         this.ghostBt1.x = main.Game.ui.mcInterface.bShortTall.x;
         this.ghostBt1.y = main.Game.ui.mcInterface.bShortTall.y;
         var ghostBtShape2:Shape = new Shape();
         ghostBtShape2.graphics.beginFill(0,0);
         ghostBtShape2.graphics.drawRect(0,0,main.Game.ui.mcInterface.bMinMax.width,main.Game.ui.mcInterface.bMinMax.height);
         ghostBtShape2.graphics.endFill();
         this.ghostBt2 = new MovieClip();
         this.ghostBt2.addChild(ghostBtShape2);
         main.Game.ui.mcInterface.addChild(this.ghostBt2);
         this.ghostBt2.x = main.Game.ui.mcInterface.bMinMax.x;
         this.ghostBt2.y = main.Game.ui.mcInterface.bMinMax.y;
         this.ghostBt1.addEventListener(MouseEvent.CLICK,this.onChangeSize,false,0,true);
         this.ghostBt2.addEventListener(MouseEvent.CLICK,this.onVisibility,false,0,true);
      }
      
      public static function format_time() : String
      {
         var hours:Number = main.Game.date_server.hours;
         var minutes:Number = main.Game.date_server.minutes;
         var format_hrs:String = "" + hours;
         var format_mints:String = "" + minutes;
         if(hours < 10)
         {
            format_hrs = "0" + hours;
         }
         if(minutes < 10)
         {
            format_mints = "0" + minutes;
         }
         return format_hrs + ":" + format_mints + " ";
      }
      
      public function onVisibility(e:*) : void
      {
         trace("visiblity clicked");
         this.visible = !this.visible;
         this.chatBox.visible = !this.chatBox.visible;
      }
      
      public function cleanup() : void
      {
         main._stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onWheel);
         main.Game.ui.mcInterface.t1.removeEventListener(Event.ADDED,this.onAdded);
         main.Game.ui.mcInterface.bShortTall.removeEventListener(MouseEvent.CLICK,this.onChangeSize);
         main.Game.ui.mcInterface.bMinMax.removeEventListener(MouseEvent.CLICK,this.onVisibility);
         main.Game.ui.mcInterface.removeChild(main.Game.ui.mcInterface.getChildByName("chatui_chatBox"));
         main.Game.ui.mcInterface.removeChild(main.Game.ui.mcInterface.getChildByName("chatBox_chatBox_mask"));
         main.Game.ui.mcInterface.bShortTall.mouseEnabled = main.Game.ui.mcInterface.bShortTall.mouseChildren = true;
         main.Game.ui.mcInterface.bMinMax.mouseEnabled = main.Game.ui.mcInterface.bMinMax.mouseChildren = true;
         main.Game.ui.mcInterface.t1.visible = true;
         this.parent.removeChild(this);
      }
      
      public function onChangeSize(e:*) : void
      {
         this.heightConst = this.heightConst == -137 ? Number(-378) : Number(-137);
         main.Game.ui.mcInterface.removeChild(main.Game.ui.mcInterface.getChildByName("chatBox_chatBox_mask"));
         this.chatBox_mask = new Shape();
         this.chatBox_mask.graphics.beginFill(0);
         this.chatBox_mask.graphics.drawRect(0,0,371.9,this.heightConst == -137 ? Number(121.35) : Number(362.25));
         this.chatBox_mask.graphics.endFill();
         main.Game.ui.mcInterface.addChild(this.chatBox_mask);
         this.chatBox_mask.name = "chatBox_chatBox_mask";
         this.chatBox_mask.x = this.chatBox.x;
         this.chatBox_mask.y = this.heightConst;
         this.chatBox.mask = this.chatBox_mask;
         this.draw_tab();
         this.filterMessages();
      }
      
      public function onAdded(e:Event) : void
      {
         if(!e.target.getChildAt(e.target.numChildren - 1).hasOwnProperty("ti"))
         {
            return;
         }
         var txt:String = e.target.getChildAt(e.target.numChildren - 1).ti.htmlText;
         var id:Number = 1;
         switch(true)
         {
            case txt.indexOf("COLOR=\"#FF0000\"") > -1:
            case txt.indexOf("COLOR=\"#00FFFF\"") > -1:
               id = 2;
               break;
            case txt.indexOf("COLOR=\"#00CCFF\"") > -1:
               id = 3;
               break;
            case txt.indexOf("COLOR=\"#99FF00\"") > -1:
               id = 4;
               break;
            case txt.indexOf("COLOR=\"#990099\"") > -1:
            case txt.indexOf("COLOR=\"#FF00FF\"") > -1:
               id = 5;
         }
         this.messages.push({
            "id":id,
            "message":txt,
            "timestamp":"<font size=\"11\" style=\"font-family:purista;\">" + format_time() + "</font> "
         });
         if(this.messages.length > 100)
         {
            this.messages.shift();
         }
         this.filterMessages();
      }
      
      public function onWheel(e:MouseEvent) : void
      {
         e.stopPropagation();
         if(!this.chatBox.hitTestPoint(e.stageX,e.stageY))
         {
            return;
         }
         e.delta *= 2;
         if(this.chatBox.y + e.delta <= this.heightConst)
         {
            this.chatBox.y += e.delta;
         }
         else if(this.chatBox.y + e.delta >= this.heightConst + (this.chatBox.height + this.chatBox.mask.height))
         {
            this.chatBox.y -= e.delta;
         }
         if(this.chatBox.y >= this.heightConst)
         {
            this.chatBox.y = this.heightConst;
         }
         else if(this.chatBox.y <= this.heightConst - (this.chatBox.height - this.chatBox.mask.height))
         {
            this.chatBox.y = this.heightConst - (this.chatBox.height - this.chatBox.mask.height);
         }
      }
      
      public function draw_tab() : void
      {
         var _tab:Object = null;
         var _child:* = undefined;
         var active_stripe:MovieClip = null;
         var txtFilter:DropShadowFilter = new DropShadowFilter(0,45,0,1,3,3,10,1,false,false,false);
         var txtFormat:TextFormat = new TextFormat();
         txtFormat.font = "MINI 7 Condensed";
         txtFormat.size = 9;
         for(var i:Number = 0; i < this.tabs.length; i++)
         {
            _tab = this.tabs[i];
            if(_tab.component && this.getChildByName("@" + _tab.component.text) != null)
            {
               this.removeChild(this.getChildByName("@" + _tab.component.text));
            }
            _tab.component = null;
            _tab.component = new TextField();
            txtFormat.color = i == this.activeTab ? 16777215 : 10066329;
            _tab.component.filters = [txtFilter];
            _tab.component.defaultTextFormat = txtFormat;
            _tab.component.border = false;
            _tab.component.text = _tab.label;
            _tab.component.selectable = false;
            _tab.component.autoSize = "left";
            _child = this.addChild(_tab.component);
            _child.name = "@" + _tab.component.text;
            _child.x = i > 0 ? this.tabs[i - 1].component.x + this.tabs[i - 1].component.width + 8 : 12;
            _child.y = this.heightConst == -137 ? 4.9 : -236.1;
            this.tabShadowBar.y = this.heightConst == -137 ? Number(0) : Number(-241);
            _child.addEventListener(MouseEvent.CLICK,this.onTabClicked,false,0,true);
            if(i == this.activeTab)
            {
               if(this.getChildByName("active_stripe") != null)
               {
                  this.removeChild(this.getChildByName("active_stripe"));
               }
               active_stripe = new MovieClip();
               active_stripe.name = "active_stripe";
               active_stripe.graphics.beginFill(16777215);
               active_stripe.graphics.drawRect(0,0,_tab.component.width,2.2);
               active_stripe.graphics.endFill();
               active_stripe.x = _child.x;
               active_stripe.y = this.heightConst == -137 ? Number(22.8) : Number(-218.2);
               this.addChild(active_stripe);
            }
         }
      }
      
      public function filterMessages() : void
      {
         var msg_string:* = undefined;
         var txtui:Class = null;
         var mc_txtui:MovieClip = null;
         while(this.chatBox.numChildren > 0)
         {
            this.chatBox.removeChildAt(0);
         }
         for each(msg_string in this.messages)
         {
            if(this.activeTab == 0 || this.activeTab == msg_string.id || this.activeTab == 1 && (msg_string.id == 3 || msg_string.id == 4 || msg_string.id == 5))
            {
               txtui = main.Game.world.getClass("uiTextLine");
               mc_txtui = new (txtui as Class)();
               mc_txtui.ti.filters = [new DropShadowFilter(0,45,0,1,3,3,10,1,false,false,false)];
               mc_txtui.ti.htmlText = !!optionHandler.filterChecks["chkTimestamp"] ? msg_string.timestamp + msg_string.message : msg_string.message;
               mc_txtui.ti.autoSize = "left";
               mc_txtui.y = this.chatBox.numChildren > 0 ? Number(this.chatBox.getChildAt(this.chatBox.numChildren - 1).y + this.chatBox.getChildAt(this.chatBox.numChildren - 1).height) : Number(0);
               this.chatBox.addChild(mc_txtui);
               mc_txtui.mouseEnabled = mc_txtui.mouseChildren = false;
            }
         }
         this.chatBox.y = this.heightConst - (this.chatBox.height - this.chatBox.mask.height);
         trace("PLACED@@ HEIGHT: " + this.chatBox.height + " | " + this.chatBox.mask.height);
      }
      
      public function onTabClicked(e:MouseEvent) : void
      {
         for(var i:Number = 0; i < this.tabs.length; i++)
         {
            if(this.tabs[i].label == e.target.text)
            {
               this.activeTab = i;
               this.draw_tab();
               break;
            }
         }
         trace(e.target.text + "CLICKED");
         this.filterMessages();
      }
   }
}
