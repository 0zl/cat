package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class firedragon extends SpellW
   {
       
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function firedragon()
      {
         super();
         MovieClip(this).scaleX = MovieClip(this).scaleX * 0.7;
         MovieClip(this).scaleY = MovieClip(this).scaleY * 0.7;
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
