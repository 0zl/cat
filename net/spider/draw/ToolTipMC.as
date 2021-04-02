package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Timer;
   import net.spider.main;
   
   public class ToolTipMC extends MovieClip
   {
       
      
      public var tClose:Timer;
      
      public var cnt:MovieClip;
      
      private var neutralCT:ColorTransform;
      
      var mc:MovieClip;
      
      public var isOpen:Boolean = false;
      
      private var blackCT:ColorTransform;
      
      var data:Object;
      
      var tWidth:int;
      
      public var tOpen:Timer;
      
      public function ToolTipMC()
      {
         super();
         this.isOpen = false;
         this.neutralCT = new ColorTransform();
         this.blackCT = new ColorTransform(0,0,0);
         this.tOpen = new Timer(200,1);
         this.tClose = new Timer(10000,1);
         this.mc = MovieClip(this);
         this.mc.cnt.visible = false;
         this.mc.cnt.ti.autoSize = "left";
         this.tWidth = this.mc.cnt.ti.width;
         this.mc.mouseEnabled = false;
         this.mc.mouseChildren = false;
         this.tOpen.addEventListener(TimerEvent.TIMER_COMPLETE,this.open,false,0,true);
         this.tClose.addEventListener(TimerEvent.TIMER_COMPLETE,this.close,false,0,true);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false,0,true);
         this.mc.cnt.ti.addEventListener(TextEvent.LINK,this.onTextLink,false,0,true);
      }
      
      private function onMouseOver(e:MouseEvent) : void
      {
         this.tClose.reset();
      }
      
      public function close(e:Event = null) : *
      {
         this.isOpen = false;
         this.tOpen.reset();
         this.tClose.reset();
         this.mc.gotoAndPlay("out");
      }
      
      public function openWith(newData:*) : *
      {
         this.data = newData;
         this.tOpen.reset();
         this.tOpen.start();
         if("closein" in this.data)
         {
            this.tClose.reset();
            this.tClose.delay = int(this.data.closein);
            this.tClose.start();
         }
      }
      
      public function open(e:TimerEvent) : *
      {
         this.isOpen = true;
         this.mc.cnt.visible = true;
         this.mc.cnt.ti.width = this.tWidth;
         this.mc.cnt.ti.htmlText = this.data.str;
         this.mc.cnt.ti.width = int(this.mc.cnt.ti.textWidth) + 6;
         this.mc.cnt.bg.width = int(this.mc.cnt.ti.width) + 10;
         this.mc.cnt.bg.height = int(this.mc.cnt.ti.height) + 8;
         if("invert" in this.data && this.data.invert)
         {
            this.mc.cnt.bg.transform.colorTransform = this.blackCT;
         }
         else
         {
            this.mc.cnt.bg.transform.colorTransform = this.neutralCT;
         }
         if("lowerright" in this.data)
         {
            this.mc.x = 960 - this.mc.cnt.bg.width - 4;
            this.mc.y = 480 - this.mc.cnt.bg.height - 4;
         }
         else
         {
            this.mc.x = main._stage.mouseX - this.mc.width / 2 - main.Game.x;
            this.mc.y = main._stage.mouseY - this.mc.height - 15;
            if(this.mc.x + this.mc.cnt.bg.width > 960)
            {
               this.mc.x = 960 - this.mc.cnt.bg.width - 10;
            }
            if(this.mc.x < 1)
            {
               this.mc.x = 1;
            }
            if(this.mc.y < 1)
            {
               this.mc.y = main._stage.mouseY + 10;
            }
         }
         if(this.data.str.indexOf("href") > -1)
         {
            this.mc.mouseEnabled = false;
            this.mc.mouseChildren = true;
         }
         else
         {
            this.mc.mouseEnabled = false;
            this.mc.mouseChildren = false;
         }
         this.mc.x = int(this.mc.x);
         this.mc.y = int(this.mc.y);
         this.mc.gotoAndPlay("in");
      }
      
      private function onMouseOut(e:MouseEvent) : void
      {
         if(this.tOpen.running)
         {
            this.tOpen.stop();
         }
         if(this.tClose.running)
         {
            this.tClose.stop();
         }
         this.close();
      }
      
      public function hide() : *
      {
         this.mc.cnt.visible = false;
         this.mc.x = 1050;
         this.mc.y = 0;
      }
      
      private function onTextLink(e:TextEvent) : void
      {
         var cmd:String = null;
         cmd = String(e.text.split("::")[0]).toLowerCase();
         if(cmd == "link")
         {
            navigateToURL(new URLRequest(e.text.split("::")[1]),"_blank");
         }
      }
   }
}
