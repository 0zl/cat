package net.spider.modules
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   import net.spider.draw.mcAC;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class bitmap extends MovieClip
   {
       
      
      public function bitmap()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.bitmapP)
         {
            for(playerMC in main.Game.world.avatars)
            {
               if(!(!main.Game.world.avatars[playerMC].dataLeaf && main.Game.world.avatars[playerMC].dataLeaf.strFrame != main.Game.world.strFrame))
               {
                  if(main.Game.world.avatars[playerMC].pMC)
                  {
                     if(!main.Game.world.avatars[playerMC].isMyAvatar)
                     {
                        if(main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"))
                        {
                           if(main.Game.world.avatars[playerMC].dataLeaf.intState > 0)
                           {
                              try
                              {
                                 main.Game.world.avatars[playerMC].pMC.removeChild(main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"));
                                 main.Game.world.avatars[playerMC].pMC.mcChar.visible = true;
                                 main.Game.world.avatars[playerMC].pMC.mouseEnabled = true;
                              }
                              catch(exception:*)
                              {
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var playerMC:* = undefined;
         if(!optionHandler.bitmapP || !main.Game.sfc.isConnected || !main.Game.world.avatars)
         {
            return;
         }
         for(playerMC in main.Game.world.avatars)
         {
            if(!(!main.Game.world.avatars[playerMC].dataLeaf && main.Game.world.avatars[playerMC].dataLeaf.strFrame != main.Game.world.strFrame))
            {
               if(main.Game.world.avatars[playerMC].pMC)
               {
                  if(!main.Game.world.avatars[playerMC].isMyAvatar)
                  {
                     if(main.Game.world.loaderQueue.length <= 0)
                     {
                        if(main.Game.world.avatars[playerMC].pMC.isLoaded)
                        {
                           if(!main.Game.world.avatars[playerMC].pMC.getChildByName("avtCache"))
                           {
                              if(main.Game.world.avatars[playerMC].dataLeaf.intState > 0)
                              {
                                 try
                                 {
                                    trace("Rasterizing - " + main.Game.world.avatars[playerMC].pMC.pname.ti.text);
                                    rasterize(main.Game.world.avatars[playerMC].pMC.mcChar);
                                 }
                                 catch(exception:*)
                                 {
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function createAvtBM(avt:DisplayObject) : Bitmap
      {
         var avtMatrix:Matrix = avt.transform.concatenatedMatrix;
         var avtGBounds:Rectangle = avt.getBounds(avt.stage);
         var avtGPos:Point = avt.localToGlobal(new Point());
         var avtOffset:Point = new Point(avtGPos.x - avtGBounds.left,avtGPos.y - avtGBounds.top);
         var scaledSprite:Sprite = new Sprite();
         avt.stage.addChild(scaledSprite);
         var scaledMatrix:Matrix = scaledSprite.transform.concatenatedMatrix;
         avt.stage.removeChild(scaledSprite);
         avtMatrix.tx = avtOffset.x * scaledMatrix.a;
         avtMatrix.ty = avtOffset.y * scaledMatrix.d;
         var avtBMD:BitmapData = new BitmapData(avtGBounds.width * scaledMatrix.a,avtGBounds.height * scaledMatrix.d,true,0);
         avtBMD.draw(avt,avtMatrix,null,null,null,true);
         var avtBM:Bitmap = new Bitmap(avtBMD);
         avtBM.smoothing = true;
         avtBM.x -= avtOffset.x;
         avtBM.y -= avtOffset.y;
         avtBM.scaleX = 1 / scaledMatrix.a;
         avtBM.scaleY = 1 / scaledMatrix.d;
         return avtBM;
      }
      
      public static function rasterizePart(avt:DisplayObject) : Bitmap
      {
         var avtMatrix:Matrix = avt.transform.matrix;
         var avtGBounds:Rectangle = avt.getBounds(avt.parent);
         var avtOffset:Point = new Point(avt.x - avtGBounds.left,avt.y - avtGBounds.top);
         avtMatrix.tx = avtOffset.x;
         avtMatrix.ty = avtOffset.y;
         var avtBMD:BitmapData = new BitmapData(avtGBounds.width,avtGBounds.height,true,0);
         avtBMD.draw(avt,avtMatrix,avt.parent.transform.colorTransform,null,null,true);
         var avtBM:Bitmap = new Bitmap(avtBMD);
         avtBM.smoothing = true;
         avtBM.x -= avtOffset.x;
         avtBM.y -= avtOffset.y;
         return avtBM;
      }
      
      public static function rasterize(avtDisplay:MovieClip) : void
      {
         var movieClip:mcAC = new mcAC();
         movieClip.name = "avtCache";
         avtDisplay.parent.addChild(movieClip);
         movieClip.visible = false;
         movieClipRasterizeInner(avtDisplay);
      }
      
      public static function movieClipRasterizeInner(container:MovieClip) : void
      {
         var toRasterize:MovieClip = null;
         var rasterized:* = undefined;
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               try
               {
                  toRasterize = container.getChildAt(i) as MovieClip;
                  if(toRasterize.visible != false)
                  {
                     toRasterize.getChildAt(0).visible = false;
                     rasterized = toRasterize.addChildAt(rasterizePart(toRasterize.getChildAt(0)),0);
                     movieClipRasterizeInner(container.getChildAt(i) as MovieClip);
                  }
               }
               catch(exception:*)
               {
               }
            }
         }
      }
      
      public static function movieClipStopAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               if((container.getChildAt(i) as MovieClip).name != "pvpFlag")
               {
                  if(getQualifiedClassName(container.getChildAt(i) as MovieClip).indexOf("Display") <= -1)
                  {
                     try
                     {
                        (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                        movieClipStopAll(container.getChildAt(i) as MovieClip);
                     }
                     catch(exception:*)
                     {
                     }
                  }
               }
            }
         }
      }
      
      public static function movieClipPlayAll(container:MovieClip) : void
      {
         for(var i:uint = 0; i < container.numChildren; i++)
         {
            if(container.getChildAt(i) is MovieClip)
            {
               if((container.getChildAt(i) as MovieClip).name != "pvpFlag")
               {
                  if(getQualifiedClassName(container.getChildAt(i) as MovieClip).indexOf("Display") <= -1)
                  {
                     try
                     {
                        (container.getChildAt(i) as MovieClip).gotoAndPlay(0);
                        movieClipPlayAll(container.getChildAt(i) as MovieClip);
                     }
                     catch(exception:*)
                     {
                     }
                  }
               }
            }
         }
      }
   }
}
