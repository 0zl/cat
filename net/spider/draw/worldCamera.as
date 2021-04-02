package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class worldCamera extends MovieClip
   {
       
      
      public var btnLeft:MovieClip;
      
      public var btnZoomOut:SimpleButton;
      
      public var btnUp:MovieClip;
      
      public var btnZoomIn:SimpleButton;
      
      public var btnDown:MovieClip;
      
      public var btnExit:SimpleButton;
      
      public var btnReset:SimpleButton;
      
      public var btnRight:MovieClip;
      
      public function worldCamera()
      {
         super();
         this.btnExit.addEventListener(MouseEvent.CLICK,this.onExit,false,0,true);
         this.btnZoomIn.addEventListener(MouseEvent.CLICK,this.onZoomIn,false,0,true);
         this.btnZoomOut.addEventListener(MouseEvent.CLICK,this.onZoomOut,false,0,true);
         this.btnUp.addEventListener(MouseEvent.CLICK,this.onUp,false,0,true);
         this.btnDown.addEventListener(MouseEvent.CLICK,this.onDown,false,0,true);
         this.btnLeft.addEventListener(MouseEvent.CLICK,this.onLeft,false,0,true);
         this.btnRight.addEventListener(MouseEvent.CLICK,this.onRight,false,0,true);
         this.btnReset.addEventListener(MouseEvent.CLICK,this.onReset,false,0,true);
         main.Game.ui.visible = false;
         main.Game.world.mouseEnabled = main.Game.world.mouseChildren = false;
         main._stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag,false,0,true);
         main._stage.addEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag,false,0,true);
         main._stage.addEventListener(KeyboardEvent.KEY_UP,this.onKey,false,0,true);
      }
      
      public function onKey(e:KeyboardEvent) : void
      {
         var i:Number = NaN;
         if(String.fromCharCode(e.charCode) == "h")
         {
            for(i = 0; i < this.numChildren; i++)
            {
               this.getChildAt(i).visible = !this.getChildAt(i).visible;
            }
         }
      }
      
      public function onDrag(e:MouseEvent) : void
      {
         main.Game.startDrag();
      }
      
      public function onReleaseDrag(e:MouseEvent) : void
      {
         main.Game.stopDrag();
      }
      
      public function onExit(e:MouseEvent) : void
      {
         main.Game.removeEventListener(KeyboardEvent.KEY_UP,this.onKey);
         main._stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDrag);
         main._stage.removeEventListener(MouseEvent.MOUSE_UP,this.onReleaseDrag);
         main.Game.x = main.Game.y = 0;
         main.Game.scaleX = main.Game.scaleY = 1;
         main.Game.ui.visible = true;
         main.Game.world.mouseEnabled = main.Game.world.mouseChildren = true;
         optionHandler.worldCameraMC = null;
         this.parent.removeChild(this);
      }
      
      public function onZoomIn(e:MouseEvent) : void
      {
         main.Game.scaleX = main.Game.scaleY = main.Game.scaleX = main.Game.scaleX + 0.5;
         main.Game.x -= 220;
         main.Game.y -= 150;
      }
      
      public function onZoomOut(e:MouseEvent) : void
      {
         main.Game.scaleX = main.Game.scaleY = main.Game.scaleX = main.Game.scaleX - 0.5;
         main.Game.x += 220;
         main.Game.y += 150;
      }
      
      public function onReset(e:MouseEvent) : void
      {
         main.Game.x = main.Game.y = 0;
         main.Game.scaleX = main.Game.scaleY = 1;
      }
      
      public function onUp(e:MouseEvent) : void
      {
         main.Game.y += 10;
      }
      
      public function onLeft(e:MouseEvent) : void
      {
         main.Game.x -= 10;
      }
      
      public function onRight(e:MouseEvent) : void
      {
         main.Game.x += 10;
      }
      
      public function onDown(e:MouseEvent) : void
      {
         main.Game.y -= 10;
      }
   }
}
