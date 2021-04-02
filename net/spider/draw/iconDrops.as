package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   import net.spider.handlers.optionHandler;
   
   public class iconDrops extends MovieClip
   {
       
      
      public var border:MovieClip;
      
      private var iconTimer:Timer;
      
      private var alertTimer:Timer;
      
      private var glowFilter:GlowFilter;
      
      private var alternate:Boolean = false;
      
      public function iconDrops()
      {
         super();
         this.buttonMode = true;
         this.addEventListener(MouseEvent.CLICK,this.onBtDrop,false,0,true);
         this.glowFilter = new GlowFilter(16777215,1,35,35,1,1,true,false);
         this.alertTimer = new Timer(0);
         this.alertTimer.addEventListener(TimerEvent.TIMER,this.onGlow,false,0,true);
      }
      
      public function onBtDrop(e:MouseEvent) : void
      {
         if(this.alertTimer.running)
         {
            this.alertTimer.stop();
            this.border.filters = [];
         }
         e.stopPropagation();
         if(optionHandler.cDrops)
         {
            optionHandler.dropmenuMC.onShow();
         }
         if(optionHandler.sbpcDrops)
         {
            optionHandler.dropmenutwoMC.onShow();
         }
      }
      
      public function onAlert() : void
      {
         if(this.alertTimer.running)
         {
            return;
         }
         this.glowFilter.strength = 1;
         this.border.filters = [this.glowFilter];
         this.alternate = false;
         this.alertTimer.start();
      }
      
      public function onGlow(e:TimerEvent) : void
      {
         this.glowFilter.strength += !!this.alternate ? 0.05 : -0.05;
         this.border.filters = [this.glowFilter];
         if(this.glowFilter.strength <= 0 || this.glowFilter.strength >= 1)
         {
            this.alternate = this.glowFilter.strength <= 0 ? true : false;
         }
      }
   }
}
