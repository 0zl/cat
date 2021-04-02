package catgirl.game
{
   import net.spider.main;
   
   public class Settings
   {
       
      
      public function Settings()
      {
         super();
      }
      
      public static function SetInfiniteRange() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            main.Game.world.actions.active[_loc1_].range = 20000;
            _loc1_++;
         }
      }
      
      public static function SetProvokeMonsters() : void
      {
         main.Game.world.aggroAllMon();
      }
      
      public static function SetEnemyMagnet() : void
      {
         if(main.Game.world.myAvatar.target != null)
         {
            main.Game.world.myAvatar.target.pMC.x = main.Game.world.myAvatar.pMC.x;
            main.Game.world.myAvatar.target.pMC.y = main.Game.world.myAvatar.pMC.y;
         }
      }
      
      public static function SetLagKiller(param1:String) : void
      {
         main.Game.world.visible = param1 == "False";
      }
      
      public static function DestroyPlayers() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:* = null;
         for(_loc1_ in main.Game.world.avatars)
         {
            _loc2_ = Number(_loc1_);
            if(!main.Game.world.avatars[_loc2_].isMyAvatar)
            {
               main.Game.world.destroyAvatar(_loc2_);
            }
         }
      }
      
      public static function SetSkipCutscenes() : void
      {
         while(main.Game.mcExtSWF.numChildren > 0)
         {
            main.Game.mcExtSWF.removeChildAt(0);
         }
         main.Game.showInterface();
      }
      
      public static function SetWalkSpeed(param1:String) : void
      {
         main.Game.world.WALKSPEED = parseInt(param1);
      }
   }
}
