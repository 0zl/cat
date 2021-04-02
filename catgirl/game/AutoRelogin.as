package catgirl.game
{
   import net.spider.main;
   
   public class AutoRelogin
   {
       
      
      public function AutoRelogin()
      {
         super();
      }
      
      public static function IsTemporarilyKicked() : String
      {
         return main.Game.mcLogin != null && main.Game.mcLogin.btnLogin != null && main.Game.mcLogin.btnLogin.visible == false ? main.TrueString : main.FalseString;
      }
      
      public static function Login() : void
      {
         main.Game.login(main.Username,main.Password);
      }
      
      public static function ResetServers() : String
      {
         try
         {
            main.Game.serialCmd.servers = [];
            main.Game.world.strMapName = "";
            return main.TrueString;
         }
         catch(e:*)
         {
            return main.FalseString;
         }
      }
      
      public static function AreServersLoaded() : String
      {
         if(main.Game.serialCmd != null)
         {
            if(main.Game.serialCmd.servers != null)
            {
               return main.Game.serialCmd.servers.length > 0 ? main.TrueString : main.FalseString;
            }
         }
         return main.FalseString;
      }
      
      public static function Connect(param1:String) : void
      {
         var _loc2_:Object = null;
         for each(_loc2_ in main.Game.serialCmd.servers)
         {
            if(_loc2_.sName == param1)
            {
               main.Game.objServerInfo = _loc2_;
               main.Game.chatF.iChat = _loc2_.iChat;
               break;
            }
         }
         main.Game.connectTo(main.Game.objServerInfo.sIP,main.Game.objServerInfo.iPort);
      }
   }
}
