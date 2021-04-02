package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   import net.spider.draw.detailedCheck;
   import net.spider.draw.fadedAC;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class detailquests extends MovieClip
   {
      
      public static var frame;
      
      public static var itemUI;
       
      
      public function detailquests()
      {
         super();
      }
      
      public static function onFrameUpdate() : void
      {
         if(!optionHandler.detailquest || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(main.Game.ui.ModalStack.numChildren)
         {
            frame = main.Game.ui.ModalStack.getChildAt(0);
            if(getQualifiedClassName(frame) == "QFrameMC")
            {
               if(frame.cnt.core)
               {
                  if(frame.cnt.core.rewardsStatic)
                  {
                     establishRender(frame.cnt.core.rewardsStatic);
                  }
                  if(frame.cnt.core.rewardsRoll)
                  {
                     establishRender(frame.cnt.core.rewardsRoll);
                  }
                  if(frame.cnt.core.rewardsChoice)
                  {
                     establishRender(frame.cnt.core.rewardsChoice);
                  }
                  if(frame.cnt.core.rewardsRandom)
                  {
                     establishRender(frame.cnt.core.rewardsRandom);
                  }
               }
            }
         }
      }
      
      public static function isOwned(isHouse:Boolean, itemID:*) : Boolean
      {
         var item:* = undefined;
         for each(item in !!isHouse ? main.Game.world.myAvatar.houseitems : main.Game.world.myAvatar.items)
         {
            if(item.ItemID == itemID)
            {
               return true;
            }
         }
         if(main.Game.world.bankinfo.isItemInBank(itemID))
         {
            return true;
         }
         return false;
      }
      
      public static function establishRender(core:*) : void
      {
         var s:* = undefined;
         var j:* = undefined;
         var k:* = undefined;
         var flag:mcCoin = null;
         var ac:fadedAC = null;
         var txtFormat:TextFormat = null;
         var check:detailedCheck = null;
         for(var i:* = 1; i < core.numChildren; i++)
         {
            itemUI = core.getChildAt(i);
            if(!itemUI.getChildByName("flag"))
            {
               loop1:
               for each(s in frame.qData.reward)
               {
                  if(s["ItemID"] == itemUI.ItemID)
                  {
                     for each(j in frame.qData.oRewards)
                     {
                        for each(k in j)
                        {
                           if(k.ItemID == s["ItemID"])
                           {
                              if(k.bCoins == 1)
                              {
                                 ac = new fadedAC();
                                 ac.width = 68.55;
                                 ac.height = 38.1;
                                 ac.x = itemUI.bg.width - 72;
                                 ac.alpha = 0.25;
                                 itemUI.addChild(ac);
                              }
                              if(k.bUpg)
                              {
                                 txtFormat = itemUI.strName.defaultTextFormat;
                                 txtFormat.color = 16566089;
                                 itemUI.strName.setTextFormat(txtFormat);
                                 txtFormat = itemUI.strQ.defaultTextFormat;
                                 txtFormat.color = 16566089;
                                 itemUI.strQ.setTextFormat(txtFormat);
                              }
                              if(isOwned(k.bHouse,k.ItemID))
                              {
                                 check = new detailedCheck();
                                 check.width = itemUI.icon.width;
                                 check.height = itemUI.icon.height;
                                 check.x = 0;
                                 check.y = 0;
                                 itemUI.icon.addChild(check);
                              }
                              flag = new mcCoin();
                              flag.visible = false;
                              flag.name = "flag";
                              itemUI.addChild(flag);
                              break loop1;
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
