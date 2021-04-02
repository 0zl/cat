package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class monstype extends MovieClip
   {
       
      
      public function monstype()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         var mons:Array = null;
         var _m:* = undefined;
         if(!optionHandler.hideM)
         {
            if(!main.Game.world.strFrame)
            {
               return;
            }
            mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each(_m in mons)
            {
               if(_m)
               {
                  if(_m.pMC)
                  {
                     if(_m.pMC.getChildAt(1))
                     {
                        if(!_m.pMC.getChildAt(1).visible)
                        {
                           _m.pMC.getChildAt(1).visible = true;
                        }
                     }
                  }
               }
            }
         }
      }
      
      public static function onFrameUpdate() : void
      {
         var mons:Array = null;
         var _m:* = undefined;
         var t_type:TextField = null;
         var t_format:TextFormat = null;
         if(!optionHandler.mType || !main.Game.sfc.isConnected || !main.Game.world.myAvatar)
         {
            return;
         }
         if(main.Game.world.strFrame)
         {
            mons = main.Game.world.getMonstersByCell(main.Game.world.strFrame);
            for each(_m in mons)
            {
               if(_m)
               {
                  if(_m.pMC)
                  {
                     if(_m.pMC.getChildAt(1))
                     {
                        if(!_m.pMC.pname.getChildByName("ptype"))
                        {
                           t_type = new TextField();
                           t_format = new TextFormat();
                           t_format = _m.pMC.pname.ti.getTextFormat();
                           t_format.align = TextFormatAlign.CENTER;
                           t_format.font = "Purista";
                           t_type.defaultTextFormat = t_format;
                           t_type.name = "ptype";
                           t_type.width = _m.pMC.pname.ti.width;
                           t_type.y = 9;
                           t_type.text = "< " + _m.pMC.pAV.objData.sRace + " >";
                           _m.pMC.pname.addChild(t_type);
                        }
                     }
                  }
               }
            }
         }
         if(main.Game.world.myAvatar.target == null)
         {
            return;
         }
         if(main.Game.world.myAvatar.target.npcType == "monster")
         {
            if(main.Game.ui.mcPortraitTarget.strClass.text != main.Game.world.myAvatar.target.objData.sRace)
            {
               main.Game.ui.mcPortraitTarget.strClass.text = main.Game.world.myAvatar.target.objData.sRace;
            }
         }
      }
   }
}
