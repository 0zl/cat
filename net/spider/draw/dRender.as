package net.spider.draw
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Timer;
   import net.spider.avatar.AvatarMC;
   import net.spider.handlers.ClientEvent;
   import net.spider.main;
   
   public class dRender extends MovieClip
   {
       
      
      public var btnTryMe:MovieClip;
      
      public var pMC:AvatarMC;
      
      public var btnClose:SimpleButton;
      
      var rootClass:MovieClip;
      
      var mcStage:MovieClip;
      
      var curItem:Object;
      
      var sLinkArmor:String = "";
      
      var sLinkCape:String = "";
      
      var sLinkHelm:String = "";
      
      var sLinkPet:String = "";
      
      var sLinkWeapon:String = "";
      
      var sLinkHouse:String = "";
      
      var petDisable:Timer;
      
      var ldr;
      
      public function dRender(e:*)
      {
         this.petDisable = new Timer(0);
         this.ldr = new Loader();
         super();
         this.rootClass = MovieClip(main.Game);
         this.x = 325;
         this.y = 90;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.xClick,false,0,true);
         this.btnTryMe.addEventListener(MouseEvent.CLICK,this.xTryMe,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onHold,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseRelease,false,0,true);
         this.mcStage = MovieClip(this.addChild(new MovieClip()));
         this.loadItem(e);
      }
      
      private function xClick(event:MouseEvent) : *
      {
         this.parent.removeChild(this);
      }
      
      private function xTryMe(event:MouseEvent) : *
      {
         var sES:String = null;
         switch(this.curItem.sES)
         {
            case "Weapon":
            case "he":
            case "ba":
            case "pe":
            case "ar":
            case "co":
               sES = this.curItem.sES;
               if(sES == "ar")
               {
                  sES = "co";
               }
               if(sES == "pe")
               {
                  if(main.Game.world.myAvatar.objData.eqp["pe"])
                  {
                     main.Game.world.myAvatar.unloadPet();
                  }
               }
               if(!main.Game.world.myAvatar.objData.eqp[sES])
               {
                  main.Game.world.myAvatar.objData.eqp[sES] = {};
                  main.Game.world.myAvatar.objData.eqp[sES].wasCreated = true;
               }
               if(!main.Game.world.myAvatar.objData.eqp[sES].isPreview)
               {
                  main.Game.world.myAvatar.objData.eqp[sES].isPreview = true;
                  if(!main.Game.world.myAvatar.objData.eqp[sES].isShowable)
                  {
                     if("sType" in this.curItem)
                     {
                        main.Game.world.myAvatar.objData.eqp[sES].oldType = main.Game.world.myAvatar.objData.eqp[sES].sType;
                     }
                     main.Game.world.myAvatar.objData.eqp[sES].oldFile = main.Game.world.myAvatar.objData.eqp[sES].sFile;
                     main.Game.world.myAvatar.objData.eqp[sES].oldLink = main.Game.world.myAvatar.objData.eqp[sES].sLink;
                  }
               }
               if("sType" in this.curItem)
               {
                  main.Game.world.myAvatar.objData.eqp[sES].sType = this.curItem.sType;
               }
               main.Game.world.myAvatar.objData.eqp[sES].sFile = this.curItem.sFile == "undefined" ? "" : this.curItem.sFile;
               main.Game.world.myAvatar.objData.eqp[sES].sLink = this.curItem.sLink;
               main.Game.world.myAvatar.loadMovieAtES(sES,this.curItem.sFile,this.curItem.sLink);
               if(sES == "pe" && this.curItem.sName.indexOf("Bank Pet") != -1)
               {
                  this.petDisable.addEventListener(TimerEvent.TIMER,this.onPetDisable,false,0,true);
                  this.petDisable.start();
               }
               this.visible = false;
               main.events.dispatchEvent(new ClientEvent(ClientEvent.onCostumePending));
         }
      }
      
      function onPetDisable(e:TimerEvent) : void
      {
         if(!main.Game.world.myAvatar.petMC.mcChar)
         {
            return;
         }
         main.Game.world.myAvatar.petMC.mcChar.mouseEnabled = false;
         main.Game.world.myAvatar.petMC.mcChar.mouseChildren = false;
         main.Game.world.myAvatar.petMC.mcChar.enabled = false;
         this.petDisable.reset();
         this.petDisable.removeEventListener(TimerEvent.TIMER,this.onPetDisable);
      }
      
      public function loadItem(e:*) : void
      {
         this.visible = true;
         var param1:* = e;
         if(this.curItem != param1)
         {
            this.btnTryMe.visible = false;
            this.pMC.visible = false;
            this.curItem = param1;
            switch(this.curItem.sES)
            {
               case "Weapon":
               case "he":
               case "ba":
               case "pe":
               case "ar":
               case "co":
                  if(this.curItem.bUpg == 1)
                  {
                     if(!main.Game.world.myAvatar.isUpgraded())
                     {
                        this.btnTryMe.visible = false;
                     }
                     else
                     {
                        this.btnTryMe.visible = true;
                     }
                  }
                  else
                  {
                     this.btnTryMe.visible = true;
                  }
            }
            switch(param1.sES)
            {
               case "Weapon":
                  this.loadWeapon(param1.sFile,param1.sLink);
                  break;
               case "he":
                  this.loadHelm(param1.sFile,param1.sLink);
                  break;
               case "ba":
                  this.loadCape(param1.sFile,param1.sLink);
                  break;
               case "pe":
                  this.loadPet(param1.sFile,param1.sLink);
                  break;
               case "ar":
               case "co":
                  this.loadArmor(param1.sFile,param1.sLink);
                  break;
               case "ho":
                  this.loadHouse(param1.sFile);
                  break;
               case "hi":
                  this.loadHouseItem(param1.sFile,param1.sLink);
                  break;
               default:
                  this.loadItemFile();
            }
         }
      }
      
      private function clearStage() : void
      {
         var _loc_1:* = this.mcStage.numChildren - 1;
         while(_loc_1 >= 0)
         {
            this.mcStage.removeChildAt(_loc_1);
            _loc_1--;
         }
      }
      
      private function loadHouseItem(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkHouse = param2;
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + param1),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onloadHouseItemComplete,false,0,true);
      }
      
      private function onloadHouseItemComplete(param1:Event) : void
      {
         var _loc_3:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkHouse) as Class;
         var _loc_4:* = new _loc_3();
         _loc_4.x = 150;
         _loc_4.y = 200;
         this.mcStage.addChild(_loc_4);
         this.addGlow(_loc_4);
      }
      
      private function loadWeapon(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkWeapon = param2;
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + param1),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadWeaponComplete,false,0,true);
      }
      
      private function loadCape(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkCape = param2;
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + param1),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadCapeComplete,false,0,true);
      }
      
      private function loadHelm(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkHelm = param2;
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + param1),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadHelmComplete,false,0,true);
      }
      
      private function loadPet(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkPet = param2;
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + param1),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadPetComplete,false,0,true);
      }
      
      private function loadHouse(param1:*) : void
      {
         this.clearStage();
         var _loc_2:* = "maps/" + this.curItem.sFile.substr(0,-4) + "_preview.swf";
         this.ldr = new Loader();
         this.ldr.load(new URLRequest("http://game.aq.com/game/gamefiles/" + _loc_2),new LoaderContext(false,new ApplicationDomain()));
         this.ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadHouseComplete,false,0,true);
      }
      
      function onLoadHouseComplete(event:Event) : void
      {
         var _loc_2:* = this.curItem.sFile.substr(0,-4).substr(this.curItem.sFile.lastIndexOf("/") + 1).split("-").join("_") + "_preview";
         var _loc_3:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(_loc_2) as Class;
         var _loc_4:* = new _loc_3();
         _loc_4.x = 150;
         _loc_4.y = 200;
         this.mcStage.addChild(_loc_4);
         this.addGlow(_loc_4);
      }
      
      private function loadArmor(param1:*, param2:*) : void
      {
         this.clearStage();
         this.sLinkArmor = param2;
         var _loc_3:* = this.pMC;
         var objChar:Object = new Object();
         objChar.strGender = main.Game.world.myAvatar.objData.strGender;
         _loc_3.pAV.objData = objChar;
         _loc_3.x = 150;
         _loc_3.y = 250;
         var _loc_4:* = 1.65;
         _loc_3.scaleY = 1.65;
         _loc_3.scaleX = _loc_4;
         _loc_3.loadArmor(param1,param2);
         this.addGlow(_loc_3);
         _loc_3.visible = true;
      }
      
      function onLoadWeaponComplete(event:Event) : void
      {
         var mc:MovieClip = null;
         var AssetClass:Class = null;
         var e:* = undefined;
         e = event;
         try
         {
            AssetClass = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkWeapon) as Class;
            mc = new AssetClass();
         }
         catch(err:Error)
         {
            mc = MovieClip(e.target.content);
         }
         mc.x = 150;
         mc.y = 180;
         var _loc_3:* = 0.3;
         mc.scaleY = 0.3;
         mc.scaleX = _loc_3;
         this.mcStage.addChild(mc);
         this.addGlow(mc);
      }
      
      function onLoadCapeComplete(event:Event) : void
      {
         var _loc_2:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkCape) as Class;
         var _loc_3:* = new _loc_2();
         _loc_3.x = 150;
         _loc_3.y = 150;
         var _loc_4:* = 0.5;
         _loc_3.scaleY = 0.5;
         _loc_3.scaleX = _loc_4;
         this.mcStage.addChild(_loc_3);
         this.addGlow(_loc_3);
      }
      
      function onLoadHelmComplete(event:Event) : void
      {
         trace("SAME DOMAIN? " + this.ldr.contentLoaderInfo.sameDomain);
         var _loc_2:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkHelm) as Class;
         var _loc_3:* = new _loc_2();
         _loc_3.x = 170;
         _loc_3.y = 200;
         this.mcStage.addChild(_loc_3);
         this.addGlow(_loc_3);
      }
      
      function onLoadPetComplete(event:Event) : void
      {
         var _loc_2:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.sLinkPet) as Class;
         var _loc_3:* = new _loc_2();
         _loc_3.x = 150;
         _loc_3.y = 250;
         var _loc_4:* = 2;
         _loc_3.scaleY = 2;
         _loc_3.scaleX = _loc_4;
         this.mcStage.addChild(_loc_3);
         this.addGlow(_loc_3);
      }
      
      private function addGlow(param1:MovieClip) : void
      {
         var _loc_2:* = new GlowFilter(16777215,1,8,8,2,1,false,false);
         param1.filters = [_loc_2];
      }
      
      private function loadItemFile() : void
      {
         this.clearStage();
         var _loc_1:* = new Loader();
         _loc_1.load(new URLRequest("http://game.aq.com/game/gamefiles/" + this.curItem.sFile),new LoaderContext(false,new ApplicationDomain()));
         _loc_1.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadItemFileComplete,false,0,true);
         _loc_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,0,true);
      }
      
      function onLoadItemFileComplete(event:Event) : void
      {
         var _loc_2:* = this.ldr.contentLoaderInfo.applicationDomain.getDefinition(this.curItem.sLink) as Class;
         var _loc_3:* = new _loc_2();
         _loc_3.x = 150;
         _loc_3.y = 250;
         if(_loc_3.height > 225)
         {
            _loc_3.height = 225;
            _loc_3.scaleX = _loc_3.scaleY;
         }
         if(_loc_3.width > 275)
         {
            _loc_3.width = 275;
            _loc_3.scaleY = _loc_3.scaleX;
         }
         this.mcStage.addChild(_loc_3);
         this.addGlow(_loc_3);
      }
      
      function onLoadError(event:Event) : void
      {
         var _loc_2:* = main.Game.world.getClass("iibag") as Class;
         var _loc_3:* = new _loc_2();
         _loc_3.x = 150;
         _loc_3.y = 180;
         _loc_3.scaleY = _loc_3.scaleX = 1;
         this.mcStage.addChild(_loc_3);
         this.addGlow(_loc_3);
      }
      
      private function onHold(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      private function onMouseRelease(e:MouseEvent) : void
      {
         this.stopDrag();
      }
   }
}
