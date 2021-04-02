package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   
   public class memoryusage extends MovieClip
   {
       
      
      public var bg:MovieClip;
      
      public var txtMemory:TextField;
      
      public function memoryusage()
      {
         super();
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onHold,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease,false,0,true);
         this.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onFrame(e:*) : void
      {
         this.txtMemory.text = "Not In Use: " + System.freeMemory / 1000000 + "mb\nIn Use: " + System.totalMemory / 1000000 + "mb\nAllocated: " + System.privateMemory / 1000000 + "mb";
      }
      
      public function cleanup() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_DOWN,this.onHold);
         this.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease);
         this.removeEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      private function onHold(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMouseRelease(e:MouseEvent) : void
      {
         this.stopDrag();
      }
   }
}
