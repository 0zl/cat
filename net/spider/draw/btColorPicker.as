package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class btColorPicker extends MovieClip
   {
       
      
      public var btnColor:SimpleButton;
      
      public function btColorPicker()
      {
         super();
         this.btnColor.addEventListener(MouseEvent.CLICK,this.onBtnColor,false,0,true);
      }
      
      public function onBtnColor(e:MouseEvent) : void
      {
         if(!optionHandler.colorPickerMC)
         {
            optionHandler.colorPickerMC = new colorPicker();
            main._stage.addChild(optionHandler.colorPickerMC);
         }
         else
         {
            optionHandler.colorPickerMC.visible = !optionHandler.colorPickerMC.visible;
         }
      }
      
      public function destroy() : void
      {
         this.btnColor.removeEventListener(MouseEvent.CLICK,this.onBtnColor);
      }
   }
}
