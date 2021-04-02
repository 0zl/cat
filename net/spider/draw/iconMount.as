package net.spider.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import net.spider.main;
   import net.spider.modules.bettermounts;
   
   public class iconMount extends MovieClip
   {
       
      
      public var btSummon:MovieClip;
      
      private var isRunning:Boolean = false;
      
      private var loadTimer:Timer;
      
      private var oldID:Number = 0;
      
      private var wasMount:Boolean = false;
      
      public function iconMount()
      {
         super();
         this.buttonMode = true;
         this.addEventListener(MouseEvent.CLICK,this.onBtMount,false,0,true);
      }
      
      public function dispatchMount() : void
      {
         this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function onBtMount(e:*) : void
      {
         var t_obj:Object = null;
         var sES:String = null;
         var avt_eqp:* = undefined;
         e.stopPropagation();
         if(this.isRunning)
         {
            return;
         }
         this.isRunning = true;
         if(main.sharedObject.data.savedMounts)
         {
            t_obj = main.sharedObject.data.savedMounts;
            if(!t_obj[main.Game.world.myAvatar.objData.strUsername.toLowerCase()])
            {
               this.isRunning = false;
               this.warning();
               return;
            }
            if(bettermounts.isMountEquipped && bettermounts.mnt_id != 0)
            {
               sES = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
               avt_eqp = main.Game.world.myAvatar.objData.eqp[sES];
               if(avt_eqp.hasOwnProperty("relsFile"))
               {
                  this.revertMount();
                  return;
               }
            }
            this.wasMount = bettermounts.isMountEquipped && bettermounts.mnt_id != 0;
            this.oldID = bettermounts.mnt_id;
            var _local2:* = undefined;
            var _local3:* = undefined;
            _local2 = {};
            _local2.typ = "generic";
            _local2.dur = 0.5;
            _local2.txt = "Summoning Mount";
            _local2.callback = this.summonMount;
            _local2.args = {};
            main.Game.ui.mcCastBar.fOpenWith(_local2);
            return;
         }
         this.isRunning = false;
         this.warning();
      }
      
      public function warning() : void
      {
         var modalClass:Class = main.Game.world.getClass("ModalMC");
         var modal:* = new modalClass();
         var modalO:* = {};
         modalO.strBody = "You must set your primary mount from your inventory!";
         modalO.params = {};
         modalO.glow = "red,medium";
         modalO.btns = "mono";
         main._stage.addChild(modal);
         modal.init(modalO);
      }
      
      public function summonMount(_arg1:*) : void
      {
         var item:* = undefined;
         var t_item:* = undefined;
         var t_obj:Object = main.sharedObject.data.savedMounts;
         for each(t_item in main.Game.world.myAvatar.items)
         {
            if(t_item.ItemID == t_obj[main.Game.world.myAvatar.objData.strUsername.toLowerCase()])
            {
               item = t_item;
            }
         }
         if(!item)
         {
            this.warning();
            return;
         }
         var sES:String = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
         var avt_eqp:* = main.Game.world.myAvatar.objData.eqp[sES];
         avt_eqp.relsFile = avt_eqp.sFile;
         avt_eqp.relsLink = avt_eqp.sLink;
         avt_eqp.sFile = item.sFile;
         avt_eqp.sLink = item.sLink;
         main.Game.world.myAvatar.loadMovieAtES(sES,item.sFile,item.sLink);
         bettermounts.isMountEquipped = true;
         bettermounts.mnt_id = item.ItemID;
         this.isRunning = false;
      }
      
      public function revertMount() : void
      {
         var sES:String = main.Game.world.myAvatar.objData.eqp.co == null ? "ar" : "co";
         var avt_eqp:* = main.Game.world.myAvatar.objData.eqp[sES];
         avt_eqp.sFile = avt_eqp.relsFile;
         avt_eqp.sLink = avt_eqp.relsLink;
         main.Game.world.myAvatar.loadMovieAtES(sES,avt_eqp.sFile,avt_eqp.sLink);
         delete avt_eqp.relsFile;
         delete avt_eqp.relsLink;
         bettermounts.isMountEquipped = this.wasMount;
         bettermounts.mnt_id = !!this.wasMount ? Number(this.oldID) : Number(0);
         this.isRunning = false;
      }
   }
}
