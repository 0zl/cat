package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class toxicabomination extends SpellW
   {
       
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function toxicabomination()
      {
         super();
         MovieClip(this).scaleX = MovieClip(this).scaleX * 0.5;
         MovieClip(this).scaleY = MovieClip(this).scaleY * 0.5;
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
