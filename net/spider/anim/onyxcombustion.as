package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class onyxcombustion extends SpellW
   {
       
      
      public function onyxcombustion()
      {
         super();
         MovieClip(this).scaleX = MovieClip(this).scaleX * 0.7;
         MovieClip(this).scaleY = MovieClip(this).scaleY * 0.7;
      }
   }
}
