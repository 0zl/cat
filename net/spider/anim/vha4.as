package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class vha4 extends SpellW
   {
       
      
      public var w1:MovieClip;
      
      public var w2:MovieClip;
      
      public var w3:MovieClip;
      
      public var w4:MovieClip;
      
      public var w5:MovieClip;
      
      public var w7:MovieClip;
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function vha4()
      {
         super();
         if(this.trueTarget != null)
         {
            if(this.trueTarget.x < this.trueSelf.x)
            {
               MovieClip(this).scaleX = MovieClip(this).scaleX * -1;
            }
         }
      }
   }
}
