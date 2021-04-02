package net.spider.handlers
{
   import com.adobe.utils.StringUtil;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.spider.main;
   
   public class boosts extends MovieClip
   {
      
      private static var runOnce:Boolean = false;
       
      
      public var activesTxt:TextField;
      
      public var titleBar:TextField;
      
      public var head:MovieClip;
      
      public var back:MovieClip;
      
      public function boosts()
      {
         super();
      }
      
      public static function onTimerUpdate() : void
      {
         var pItem:* = undefined;
         var nuDesc:* = null;
         if(!optionHandler.boost || !main.Game.sfc.isConnected)
         {
            return;
         }
         if(!main.Game.world.myAvatar)
         {
            return;
         }
         if(!main.Game.world.myAvatar.items)
         {
            return;
         }
         if(!flags.isInventory() && runOnce)
         {
            runOnce = false;
         }
         if(flags.isInventory() && !runOnce)
         {
            for each(pItem in main.Game.world.myAvatar.items)
            {
               if(!pItem.oldDesc)
               {
                  pItem.oldDesc = pItem.sDesc && StringUtil.trim(pItem.sDesc) != "" ? pItem.sDesc : "";
               }
               nuDesc = "";
               if(pItem.sMeta)
               {
                  nuDesc = "sMeta: " + pItem.sMeta + "\n";
               }
               pItem.sDesc = nuDesc + "Stacks: " + pItem.iQty + "/" + pItem.iStk + "\n" + pItem.oldDesc;
               nuDesc = null;
            }
            runOnce = true;
         }
      }
   }
}
