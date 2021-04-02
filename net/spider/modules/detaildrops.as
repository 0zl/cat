package net.spider.modules
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.TextFormat;
   import flash.ui.*;
   import flash.utils.*;
   import net.spider.draw.*;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class detaildrops extends MovieClip
   {
      
      public static var itemArchive:Vector.<Object>;
       
      
      public function detaildrops()
      {
         super();
      }
      
      public static function onToggle() : void
      {
         if(optionHandler.detaildrop)
         {
            itemArchive = new Vector.<Object>();
         }
         else
         {
            itemArchive = null;
         }
      }
      
      public static function onExtensionResponseHandler(e:*) : void
      {
         var dID:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         if(!optionHandler.detaildrop)
         {
            return;
         }
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "dropItem":
                  for(dID in resObj.items)
                  {
                     if(resObj.items[dID].sName == null)
                     {
                        if(!itemExists(main.Game.world.invTree[dID].sName))
                        {
                           itemArchive.push(main.Game.copyObj(main.Game.world.invTree[dID]));
                        }
                     }
                     else if(!itemExists(resObj.items[dID].sName))
                     {
                        itemArchive.push(main.Game.copyObj(resObj.items[dID]));
                     }
                  }
            }
         }
      }
      
      public static function itemExists(item:String) : Boolean
      {
         var t_item:* = undefined;
         for each(t_item in itemArchive)
         {
            if(t_item.sName == item)
            {
               return true;
            }
         }
         return false;
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
      
      public static function onFrameUpdate() : void
      {
         var mcDrop:* = undefined;
         var sName:String = null;
         var item:* = undefined;
         var flag:mcCoin = null;
         var glowFilter:* = undefined;
         var txtFormat:TextFormat = null;
         var t_check:detailedCheck = null;
         if(!optionHandler.detaildrop || !main.Game.sfc.isConnected || main.Game.ui.dropStack.numChildren < 1)
         {
            return;
         }
         for(var i:int = 0; i < main.Game.ui.dropStack.numChildren; i++)
         {
            try
            {
               mcDrop = main.Game.ui.dropStack.getChildAt(i) as MovieClip;
               if(getQualifiedClassName(mcDrop) != "DFrame2MC")
               {
                  continue;
               }
               if(!mcDrop.cnt.bg.getChildByName("flag"))
               {
                  sName = mcDrop.cnt.strName.text.replace(/ x[0-9]/g,"");
                  for each(item in itemArchive)
                  {
                     if(item.sName != null && item.sName == sName)
                     {
                        if(item.bCoins == 1)
                        {
                           glowFilter = new GlowFilter(16173610,1,8,8,2,1,false,false);
                           mcDrop.filters = [glowFilter];
                        }
                        if(item.bUpg)
                        {
                           txtFormat = mcDrop.cnt.strName.defaultTextFormat;
                           txtFormat.color = 16566089;
                           mcDrop.cnt.strName.setTextFormat(txtFormat);
                        }
                        if(isOwned(item.bHouse,item.ItemID))
                        {
                           trace("register " + itemArchive.length);
                           t_check = new detailedCheck();
                           t_check.width = mcDrop.cnt.icon.width;
                           t_check.height = mcDrop.cnt.icon.height;
                           t_check.x = 0;
                           t_check.y = 0;
                           mcDrop.cnt.icon.addChild(t_check);
                        }
                        flag = new mcCoin();
                        flag.visible = false;
                        flag.name = "flag";
                        mcDrop.cnt.bg.addChild(flag);
                     }
                  }
                  itemArchive.length = 0;
               }
            }
            catch(exception:*)
            {
               trace("Error handling drops: " + exception);
               continue;
            }
         }
      }
      
      public static function onPreview(itemObj:*) : Function
      {
         return function(e:MouseEvent):void
         {
            if(main.Game.ui.getChildByName("renderPreview"))
            {
               main.Game.ui.removeChild(main.Game.ui.getChildByName("renderPreview"));
            }
            var dRenderObj:* = new dRender(itemObj);
            dRenderObj.name = "renderPreview";
            main.Game.ui.addChild(dRenderObj);
         };
      }
   }
}
