package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class thunderclap extends SpellW
   {
       
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function thunderclap()
      {
         super();
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
