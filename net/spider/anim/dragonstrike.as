package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class dragonstrike extends SpellW
   {
       
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function dragonstrike()
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
