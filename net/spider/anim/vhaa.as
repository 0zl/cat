package net.spider.anim
{
   import flash.display.MovieClip;
   
   public dynamic class vhaa extends SpellW
   {
       
      
      public var w6:MovieClip;
      
      public var w1:MovieClip;
      
      public var w2:MovieClip;
      
      public var w3:MovieClip;
      
      public var w4:MovieClip;
      
      public var w5:MovieClip;
      
      public var w7:MovieClip;
      
      public var w8:MovieClip;
      
      public var trueTarget:MovieClip;
      
      public var trueSelf:MovieClip;
      
      public function vhaa()
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
      
      function rand(min:Number, max:Number) : Number
      {
         return Math.floor(Math.random() * (max - min + 1)) + min;
      }
   }
}
