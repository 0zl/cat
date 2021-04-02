package net.spider.avatar
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class mcSkel extends MovieClip
   {
       
      
      public var idlefoot:MovieClip;
      
      public var chest:MovieClip;
      
      public var weaponOff:MovieClip;
      
      public var frontthigh:MovieClip;
      
      public var cape:MovieClip;
      
      public var frontshoulder:MovieClip;
      
      public var weaponFistOff:MovieClip;
      
      public var hitbox:MovieClip;
      
      public var head:MovieClip;
      
      public var backshoulder:MovieClip;
      
      public var hip:MovieClip;
      
      public var backthigh:MovieClip;
      
      public var backhair:MovieClip;
      
      public var weaponFist:MovieClip;
      
      public var backshin:MovieClip;
      
      public var weaponTemp:MovieClip;
      
      public var robe:MovieClip;
      
      public var pvpFlag:MovieClip;
      
      public var weapon:MovieClip;
      
      public var frontshin:MovieClip;
      
      public var backfoot:MovieClip;
      
      public var backrobe:MovieClip;
      
      public var arrow:MovieClip;
      
      public var emoteFX:MovieClip;
      
      public var shield:MovieClip;
      
      public var frontfoot:MovieClip;
      
      public var backhand:MovieClip;
      
      public var fronthand:MovieClip;
      
      public var animLoop:int;
      
      public var avtMC:MovieClip;
      
      public var projClass:Class;
      
      public var projMC:MovieClip;
      
      public var sp:Point;
      
      public var ep:Point;
      
      public var onMove:Boolean = false;
      
      public function mcSkel()
      {
         super();
      }
      
      public function emoteLoopFrame() : int
      {
         var _loc1_:int = 0;
         while(_loc1_ < currentLabels.length)
         {
            if(currentLabels[_loc1_].name == currentLabel)
            {
               return currentLabels[_loc1_].frame;
            }
            _loc1_++;
         }
         return 8;
      }
      
      public function emoteLoop(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = this.emoteLoopFrame();
         if(_loc3_ > 8)
         {
            if(++this.animLoop < param1)
            {
               this.gotoAndPlay(_loc3_ + 1);
               return;
            }
         }
         if(param2)
         {
            this.gotoAndPlay("Idle");
         }
      }
      
      public function showIdleFoot() : *
      {
         if(optionHandler.cameratoolMC)
         {
            if(!optionHandler.cameratoolMC.isCharHidden)
            {
               this.frontfoot.visible = false;
               this.idlefoot.visible = true;
            }
            else
            {
               this.frontfoot.visible = false;
               this.idlefoot.visible = false;
            }
         }
      }
      
      public function showFrontFoot() : *
      {
         if(optionHandler.cameratoolMC)
         {
            if(!optionHandler.cameratoolMC.isCharHidden)
            {
               this.idlefoot.visible = false;
               this.frontfoot.visible = true;
            }
            else
            {
               this.frontfoot.visible = false;
               this.idlefoot.visible = false;
            }
         }
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         this.handleAnimEvent(String(param1));
         super.gotoAndPlay(param1);
      }
      
      private function handleAnimEvent(param1:String) : void
      {
         var _loc3_:Function = null;
         var _loc2_:Object = MovieClip(parent).AnimEvent;
         if(_loc2_[param1] == null)
         {
            return;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_[param1].length)
         {
            _loc3_ = _loc2_[param1][_loc4_];
            _loc3_();
            _loc4_++;
         }
      }
   }
}
