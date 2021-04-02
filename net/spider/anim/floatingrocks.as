package net.spider.anim
{
   import flash.display.MovieClip;
   import net.spider.handlers.modules;
   
   public dynamic class floatingrocks extends SpellW
   {
       
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function floatingrocks()
      {
         super();
         modules.relCombatMC.groundRupture = true;
         if(this.trueTarget != null)
         {
            if(this.trueTarget.x < this.trueSelf.x)
            {
               MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
            }
         }
         MovieClip(this).scaleX = MovieClip(this).scaleX * 0.5;
         MovieClip(this).scaleY = MovieClip(this).scaleY * 0.5;
      }
   }
}
