package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class smoothbg extends MovieClip
   {
       
      
      public function smoothbg()
      {
         super();
      }
      
      public static function onFrameUpdate() : void
      {
         if(!optionHandler.smoothBG || !main.Game.world)
         {
            return;
         }
         if(!main.Game.world.map)
         {
            return;
         }
         var ctr:Number = 0;
         while(ctr < main.Game.world.map.numChildren)
         {
            if(main.Game.world.map.getChildAt(ctr) is MovieClip && main.Game.world.map.getChildAt(ctr).width >= 960 && !main.Game.world.map.getChildAt(ctr).visible && getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcShadow") == -1)
            {
               main.Game.world.map.getChildAt(ctr).visible = true;
            }
            if(getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("Bitmap") > -1 && main.Game.world.map.getChildAt(ctr).visible)
            {
               main.Game.world.map.getChildAt(ctr).visible = false;
            }
            if(getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcFloor") > -1 && main.Game.world.map.getChildAt(ctr).visible)
            {
               if(getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("mcFloors") == -1)
               {
                  main.Game.world.map.getChildAt(ctr).visible = false;
               }
            }
            if(getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("Plate") > -1 && main.Game.world.map.getChildAt(ctr).visible)
            {
               main.Game.world.map.getChildAt(ctr).visible = false;
            }
            if(main.Game.world.strMapName.toLowerCase() == "bludrutbrawl")
            {
               if(getQualifiedClassName(main.Game.world.map.getChildAt(ctr)).indexOf("asset_") > -1 && main.Game.world.map.getChildAt(ctr).visible)
               {
                  main.Game.world.map.getChildAt(ctr).visible = false;
               }
            }
            if(main.Game.world.strMapName.toLowerCase() == "dwarfhold")
            {
               if(main.Game.world.map.getChildAt(ctr) is MovieClip && main.Game.world.map.getChildAt(ctr).numChildren > 0 && main.Game.world.map.getChildAt(ctr).getChildAt(0).name.indexOf("shadow") > -1 && main.Game.world.map.getChildAt(ctr).visible)
               {
                  main.Game.world.map.getChildAt(ctr).visible = false;
               }
            }
            ctr++;
         }
      }
   }
}
