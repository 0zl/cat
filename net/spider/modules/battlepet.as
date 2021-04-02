package net.spider.modules
{
   import flash.display.MovieClip;
   import net.spider.handlers.optionHandler;
   import net.spider.main;
   
   public class battlepet extends MovieClip
   {
       
      
      public function battlepet()
      {
         super();
      }
      
      public static function onExtensionResponseHandler(e:*) : void
      {
         var dID:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var o:* = undefined;
         if(!optionHandler.bBattlePet)
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
               case "ct":
                  if(resObj.anims == null)
                  {
                     return;
                  }
                  if(!main.Game.world.myAvatar.objData.eqp["pe"])
                  {
                     return;
                  }
                  for each(o in resObj.anims)
                  {
                     if(o.tInf.indexOf("m:") > -1 && o.cInf.indexOf("p:") > -1)
                     {
                        if(main.Game.world.getAvatarByUserID(String(o.cInf.split(":")[1])).isMyAvatar)
                        {
                           if(o.animStr == main.Game.world.actions.active[0].anim)
                           {
                              if(main.Game.world.myAvatar.objData.eqp["pe"])
                              {
                                 main.Game.world.myAvatar.pMC.queueAnim("PetAttack");
                              }
                              return;
                           }
                        }
                     }
                  }
                  break;
            }
         }
      }
   }
}
