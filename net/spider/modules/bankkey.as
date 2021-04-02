package net.spider.modules
{
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class bankkey extends MovieClip
   {
       
      
      public function bankkey()
      {
         super();
      }
      
      public static function isAllowed() : Boolean
      {
         var item:* = undefined;
         for each(item in main.Game.world.myAvatar.items)
         {
            if(item.sName.indexOf(" Bank") > -1 || item.sType == "Pet" && item.sName.indexOf(" Moglin Plush Pet") > -1 || item.sDesc.indexOf(" Bank Pet ") > -1 || item.sName.indexOf("Apocalyptic LichMoglin on your Back") > -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function onKey(e:KeyboardEvent) : void
      {
         if(!optionHandler.bBankKey)
         {
            return;
         }
         var chatF:* = main.Game.chatF;
         var world:* = main.Game.world;
         var ui:* = main.Game.ui;
         if(!("text" in e.target))
         {
            if(String.fromCharCode(e.charCode) == "b")
            {
               if(main._stage.focus != ui.mcInterface.te)
               {
                  trace(isAllowed());
                  if(isAllowed())
                  {
                     main.Game.world.toggleBank();
                  }
               }
            }
         }
      }
   }
}
