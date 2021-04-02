package net.spider
{
   import catgirl.game.AutoRelogin;
   import catgirl.game.Bank;
   import catgirl.game.House;
   import catgirl.game.Inventory;
   import catgirl.game.Player;
   import catgirl.game.Quests;
   import catgirl.game.Settings;
   import catgirl.game.Shops;
   import catgirl.game.TempInventory;
   import catgirl.game.World;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.Security;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import net.spider.draw.cMenu;
   import net.spider.draw.forestbg;
   import net.spider.draw.iconDrops;
   import net.spider.draw.iconMount;
   import net.spider.draw.travelMenu;
   import net.spider.handlers.ClientEvent;
   import net.spider.handlers.SFSEvent;
   import net.spider.handlers.chatui;
   import net.spider.handlers.dropmenu;
   import net.spider.handlers.dropmenutwo;
   import net.spider.handlers.modules;
   import net.spider.handlers.optionHandler;
   import net.spider.handlers.skills;
   import net.spider.handlers.targetskills;
   import net.spider.modules.cskillanim;
   import net.spider.modules.houseentrance;
   import net.spider.modules.qlog;
   import net.spider.modules.qpin;
   
   public class main extends MovieClip
   {
      
      public static var events:EventDispatcher = new EventDispatcher();
      
      public static var Game:Object;
      
      public static var aqlData:SharedObject;
      
      public static var _stage;
      
      public static var rootDisplay;
      
      public static var dropMenu;
      
      public static var gameDomain:ApplicationDomain;
      
      public static var curVersion:Number = 16;
      
      public static var isUpdated:Boolean;
      
      public static var latestVersion:String = "not set";
      
      public static var Username;
      
      public static var Password;
      
      public static const TrueString:String = "\"True\"";
      
      public static const FalseString:String = "\"False\"";
       
      
      public var loader:MovieClip;
      
      var sURL = "https://game.aq.com/game/";
      
      var gameFile = "gameversion.asp";
      
      var sFile;
      
      var aqliteLoader:URLLoader;
      
      var versionLoader:URLLoader;
      
      var swfLoader:Loader;
      
      var swfRequest:URLRequest;
      
      var titleDomain:ApplicationDomain;
      
      var loginURL:String = "https://game.aq.com/game/cf-userlogin.asp";
      
      var sBG:String;
      
      var hasEvent:Boolean = false;
      
      private var hasLeft:Boolean = false;
      
      private var waitForLogin:Timer;
      
      var travelMenuFlag:Boolean = false;
      
      var runOnce:Boolean;
      
      var modulesInit:Boolean = false;
      
      public function main()
      {
         this.waitForLogin = new Timer(0);
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.stageHandler);
         addEventListener(Event.ADDED_TO_STAGE,this.__setPerspectiveProjection_);
      }
      
      public static function get sharedObject() : SharedObject
      {
         if(!aqlData)
         {
            aqlData = SharedObject.getLocal("AQLite_Data","/");
         }
         return aqlData;
      }
      
      public static function debug(str:String) : *
      {
         main.Game.chatF.pushMsg("server",str,"AQLite","",0);
      }
      
      public static function SendMessage(param1:String) : void
      {
         Game.chatF.pushMsg("Moderator",param1,"CATGIRL","",0);
      }
      
      public static function callGameFunction(path:String, ... args) : String
      {
         var parts:Array = path.split(".");
         var funcName:String = parts.pop();
         var obj:* = _getObjectA(main.Game,parts);
         var func:Function = obj[funcName] as Function;
         return JSON.stringify(func.apply(null,args));
      }
      
      public static function _getObjectA(root:*, parts:Array) : *
      {
         var i:int = 0;
         var obj:* = root;
         i = 0;
         while(i < parts.length)
         {
            obj = obj[parts[i]];
            i++;
         }
         return obj;
      }
      
      public function __setPerspectiveProjection_(evt:Event) : void
      {
         root.transform.perspectiveProjection.fieldOfView = 84.51821;
         root.transform.perspectiveProjection.projectionCenter = new Point(480,275);
      }
      
      public function onCostumePending(e:ClientEvent) : void
      {
         if(!this.hasEvent)
         {
            Game.sfc.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
            this.hasEvent = true;
         }
      }
      
      public function onExtensionResponseHandler(e:*) : void
      {
         var dItem:* = undefined;
         var dID:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var slot:* = undefined;
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "moveToArea":
                  for(slot in main.Game.world.myAvatar.objData.eqp)
                  {
                     if(main.Game.world.myAvatar.objData.eqp[slot].wasCreated)
                     {
                        delete main.Game.world.myAvatar.objData.eqp[slot];
                        main.Game.world.myAvatar.unloadMovieAtES(slot);
                     }
                     else
                     {
                        if(slot == "pe")
                        {
                           if(main.Game.world.myAvatar.objData.eqp["pe"])
                           {
                              main.Game.world.myAvatar.unloadPet();
                           }
                        }
                        if(main.Game.world.myAvatar.objData.eqp[slot].isPreview)
                        {
                           main.Game.world.myAvatar.objData.eqp[slot].sType = main.Game.world.myAvatar.objData.eqp[slot].oldType;
                           main.Game.world.myAvatar.objData.eqp[slot].sFile = main.Game.world.myAvatar.objData.eqp[slot].oldFile;
                           main.Game.world.myAvatar.objData.eqp[slot].sLink = main.Game.world.myAvatar.objData.eqp[slot].oldLink;
                           main.Game.world.myAvatar.loadMovieAtES(slot,main.Game.world.myAvatar.objData.eqp[slot].oldFile,main.Game.world.myAvatar.objData.eqp[slot].oldLink);
                           main.Game.world.myAvatar.objData.eqp[slot].isPreview = null;
                        }
                     }
                  }
                  Game.sfc.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
                  this.hasEvent = false;
            }
         }
      }
      
      private function stageHandler(e:Event) : void
      {
         trace(Capabilities.version);
         main.events.addEventListener(ClientEvent.onCostumePending,this.onCostumePending);
         aqlData = SharedObject.getLocal("AQLite_Data","/");
         aqlData.flush();
         addFrameScript(0,this.frame1);
         stage.addEventListener(Event.MOUSE_LEAVE,this.focusGame);
         stage.addEventListener(MouseEvent.MOUSE_OVER,this.refocusGame);
      }
      
      public function focusGame(e:*) : void
      {
         if(!this.hasLeft)
         {
            this.hasLeft = true;
         }
      }
      
      public function refocusGame(e:*) : void
      {
         if(this.hasLeft)
         {
            stage.focus = null;
            this.hasLeft = false;
         }
      }
      
      public function frame1() : void
      {
         _stage = stage;
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         stop();
         this.GetVersion();
      }
      
      function LoadGame() : *
      {
         this.swfLoader = new Loader();
         this.swfRequest = new URLRequest(this.sURL + "gamefiles/" + this.sFile);
         this.swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onGameComplete,false,0,true);
         this.swfLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
         this.swfLoader.load(this.swfRequest,new LoaderContext(false,ApplicationDomain.currentDomain));
      }
      
      function onGameComplete(loadEvent:Event) : *
      {
         var v:* = undefined;
         rootDisplay = root as DisplayObjectContainer;
         dropMenu = (root as DisplayObjectContainer).getChildByName("dropsUI2");
         stage.addChildAt(MovieClip(loadEvent.currentTarget.content),0);
         loadEvent.currentTarget.content.y = 0;
         loadEvent.currentTarget.content.x = 0;
         Game = Object(loadEvent.currentTarget.content).root;
         gameDomain = loadEvent.currentTarget.applicationDomain;
         for(v in root.loaderInfo.parameters)
         {
            trace(v + ": " + root.loaderInfo.parameters[v]);
            Game.params[v] = root.loaderInfo.parameters[v];
         }
         Game.params.sURL = this.sURL;
         Game.params.sTitle = "CATGIRL.";
         Game.params.isWeb = false;
         Game.params.doSignup = false;
         Game.params.loginURL = this.loginURL;
         Game.params.sBG = "https://i.snipboard.io/jXQ6Dd.jpg";
         Game.titleDomain = this.titleDomain;
         this.waitForLogin.addEventListener(TimerEvent.TIMER,this.onWait);
         this.waitForLogin.start();
         Game.sfc.addEventListener(SFSEvent.onConnectionLost,this.OnDisconnect);
         addEventListener(Event.ENTER_FRAME,this.EnterFrame);
         this.Externalize();
      }
      
      private function OnDisconnect(param1:*) : void
      {
         ExternalInterface.call("disconnect");
      }
      
      private function OnLoginComplete(param1:Event) : void
      {
         trace("Login Complete");
         param1.target.data = String(ExternalInterface.call("modifyServers",param1.target.data));
      }
      
      private function EnterFrame(param1:Event) : void
      {
         var _loc2_:* = undefined;
         if(Game.mcLogin != null && Game.mcLogin.ni != null && Game.mcLogin.pi != null && Game.mcLogin.btnLogin != null)
         {
            removeEventListener(Event.ENTER_FRAME,this.EnterFrame);
            _loc2_ = Game.mcLogin.btnLogin;
            _loc2_.addEventListener(MouseEvent.CLICK,this.OnLoginClick);
         }
      }
      
      private function OnLoginClick(param1:MouseEvent) : void
      {
         var _loc2_:* = Game.mcLogin.btnLogin;
         _loc2_.removeEventListener(MouseEvent.CLICK,this.OnLoginClick);
         Username = Game.mcLogin.ni.text;
         Password = Game.mcLogin.pi.text;
      }
      
      function onWait(e:TimerEvent) : void
      {
         var loadingLoader:Loader = null;
         var newBG:forestbg = null;
         if(Game.mcLogin)
         {
            if(Game.mcLogin.currentLabel == "GetLauncher")
            {
               Game.mcLogin.gotoAndStop("Init");
            }
            if(Game.mcLogin.mcTitle.getChildByName("forest"))
            {
               Game.mcLogin.mcTitle.removeChildAt(0);
               newBG = new forestbg();
               newBG.name = "forest";
               Game.mcLogin.mcTitle.addChild(newBG);
               Game.mcLogin.mcTitle.visible = true;
            }
         }
         if(Game.sfc.isConnected)
         {
            if(Game.world.actions.active != null && !Game.world.mapLoadInProgress)
            {
               if(Game.world.myAvatar.invLoaded && Game.world.myAvatar.pMC.artLoaded())
               {
                  this.waitForLogin.reset();
                  this.waitForLogin.removeEventListener(TimerEvent.TIMER,this.onWait);
                  this.waitForLogin.addEventListener(TimerEvent.TIMER,this.onLogout);
                  this.waitForLogin.start();
                  this.runOnce = false;
               }
            }
         }
      }
      
      function onLogout(e:TimerEvent) : void
      {
         var _menu:iconDrops = null;
         var _mnt_menu:iconMount = null;
         var i:* = undefined;
         if(!Game.sfc.isConnected)
         {
            this.travelMenuFlag = !!optionHandler.travelMenuMC ? true : false;
            if(this.travelMenuFlag)
            {
               optionHandler.travelMenuMC = null;
            }
            this.waitForLogin.reset();
            this.waitForLogin.addEventListener(TimerEvent.TIMER,this.onWait);
            this.waitForLogin.start();
         }
         if(!this.runOnce && Game.ui)
         {
            if(!this.modulesInit)
            {
               modules.create();
               this.modulesInit = true;
            }
            Game.ui.mcPortrait.addEventListener(MouseEvent.CLICK,this.targetPlayer,false,0,true);
            Game.ui.mcPortrait.removeEventListener(MouseEvent.CLICK,Game.portraitClick);
            Game.ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK,this.targetPlayer,false,0,true);
            Game.ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK,Game.portraitClick);
            if(this.travelMenuFlag && !Game.ui.getChildByName("travelMenuMC"))
            {
               this.travelMenuFlag = false;
               optionHandler.travelMenuMC = new travelMenu();
               optionHandler.travelMenuMC.name = "travelMenuMC";
               Game.ui.addChild(optionHandler.travelMenuMC);
            }
            if(!Game.ui.mcPortrait.getChildByName("iconDrops"))
            {
               _menu = new iconDrops();
               _menu.name = "iconDrops";
               Game.ui.mcPortrait.addChild(_menu);
               _menu.x = 40;
               _menu.y = 72.15;
               _menu.visible = optionHandler.cDrops || optionHandler.sbpcDrops;
            }
            if(!Game.ui.mcPortrait.getChildByName("iconMount"))
            {
               _mnt_menu = new iconMount();
               _mnt_menu.name = "iconMount";
               Game.ui.mcPortrait.addChild(_mnt_menu);
               _mnt_menu.x = 187.9;
               _mnt_menu.y = 62.35;
               _mnt_menu.visible = optionHandler.bBetterMounts;
            }
            if(optionHandler.cDrops && !Game.ui.getChildByName("dropmenu"))
            {
               optionHandler.dropmenuMC = new dropmenu();
               optionHandler.dropmenuMC.name = "dropmenu";
               Game.ui.addChild(optionHandler.dropmenuMC);
            }
            if(optionHandler.sbpcDrops && !Game.ui.getChildByName("dropmenutwo"))
            {
               optionHandler.dropmenutwoMC = new dropmenutwo();
               optionHandler.dropmenutwoMC.name = "dropmenutwo";
               Game.ui.addChild(optionHandler.dropmenutwoMC);
            }
            if(optionHandler.cSkillAnim && Game.ui)
            {
               i = 2;
               while(i < 6)
               {
                  if(Game.ui.mcInterface.actBar.getChildByName("i" + i))
                  {
                     Game.ui.mcInterface.actBar.getChildByName("i" + i).addEventListener(MouseEvent.CLICK,cskillanim.actIconClick,false,0,true);
                  }
                  i++;
               }
            }
            if(optionHandler.qPin && Game.ui)
            {
               Game.ui.iconQuest.addEventListener(MouseEvent.CLICK,qpin.onPinQuests);
               Game.ui.iconQuest.removeEventListener(MouseEvent.CLICK,Game.oniconQuestClick);
            }
            if(optionHandler.qLog && Game.ui.mcInterface.mcMenu.btnQuest)
            {
               Game.ui.mcInterface.mcMenu.btnQuest.addEventListener(MouseEvent.CLICK,qlog.onRegister,false,0,true);
            }
            if(optionHandler.skill && Game.ui)
            {
               if(!Game.ui.getChildByName("skillsMC"))
               {
                  optionHandler.skillsMC = new skills();
                  optionHandler.skillsMC.name = "skillsMC";
                  Game.ui.addChild(optionHandler.skillsMC);
                  optionHandler.targetskillsMC = new targetskills();
                  optionHandler.targetskillsMC.name = "targetskillsMC";
                  Game.ui.addChild(optionHandler.targetskillsMC);
               }
            }
            if(optionHandler.bHouseEntrance)
            {
               Game.ui.mcInterface.mcMenu.btnHouse.addEventListener(MouseEvent.CLICK,houseentrance.onHouseClick,false,0,true);
               houseentrance.houseEvent = true;
            }
            if(optionHandler.bCChat && Game.ui && !Game.ui.mcInterface.getChildByName("chatui"))
            {
               optionHandler.chatuiMC = new chatui();
               optionHandler.chatuiMC.name = "chatui";
               Game.ui.mcInterface.addChild(optionHandler.chatuiMC);
            }
            Game.world.myAvatar.factions.sortOn("sName");
            Game.ui.mcUpdates.mouseEnabled = Game.ui.mcUpdates.mouseChildren = false;
            this.runOnce = true;
         }
      }
      
      function targetPlayer(param1:MouseEvent) : void
      {
         var _menu:cMenu = null;
         if(getQualifiedClassName(param1.target).indexOf("ib2") > -1)
         {
            return;
         }
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         _loc2_ = MovieClip(param1.currentTarget);
         if(!Game.ui.getChildByName("customMenu"))
         {
            _menu = new cMenu();
            _menu.name = "customMenu";
            Game.ui.addChild(_menu);
         }
         var nuMenu:* = Game.ui.getChildByName("customMenu");
         if(_loc2_.pAV.npcType == "player")
         {
            _loc3_ = {};
            _loc3_.ID = _loc2_.pAV.objData.CharID;
            _loc3_.strUsername = _loc2_.pAV.objData.strUsername;
            if(_loc2_.pAV != Game.world.myAvatar)
            {
               nuMenu.fOpenWith("user",_loc3_);
            }
            else
            {
               nuMenu.fOpenWith("self",_loc3_);
            }
         }
         else
         {
            _loc3_ = {};
            _loc3_.ID = _loc2_.pAV.objData.MonMapID;
            _loc3_.strUsername = _loc2_.pAV.objData.strMonName;
            _loc3_.target = main.Game.world.getMonster(_loc3_.ID).pMC;
            nuMenu.fOpenWith("mons",_loc3_);
         }
      }
      
      function GetVersion() : *
      {
         this.aqliteLoader = new URLLoader();
         this.aqliteLoader.addEventListener(Event.COMPLETE,this.onAQLiteVersion,false,0,true);
         this.aqliteLoader.load(new URLRequest("https://api.github.com/repos/133spider/AQLite/releases/latest"));
         this.versionLoader = new URLLoader();
         this.versionLoader.addEventListener(Event.COMPLETE,this.onVersionComplete,false,0,true);
         this.versionLoader.load(new URLRequest(this.sURL + this.gameFile));
      }
      
      function onProgress(arg1:ProgressEvent) : void
      {
         var loc1:* = arg1.currentTarget.bytesLoaded / arg1.currentTarget.bytesTotal * 100;
         this.loader.progress.text = Math.floor(loc1).toString() + "%";
         if(loc1 == 100)
         {
            this.removeChild(this.loader);
         }
         ExternalInterface.call("progress",Math.round(Number(locl)));
      }
      
      function onVersionComplete(param1:Event) : *
      {
         var vars:URLVariables = null;
         vars = new URLVariables(param1.target.data);
         if(vars.status == "success")
         {
            this.sFile = vars.sFile;
            this.sBG = vars.sBG;
            this.titleDomain = new ApplicationDomain();
            this.LoadGame();
         }
         this.versionLoader.removeEventListener(Event.COMPLETE,this.onVersionComplete);
         this.versionLoader = null;
      }
      
      function onAQLiteVersion(param1:Event) : *
      {
         isUpdated = true;
         trace("[ CATGIRL ]: AQLite Version: " + curVersion);
         this.aqliteLoader.removeEventListener(Event.COMPLETE,this.onAQLiteVersion);
         this.aqliteLoader = null;
      }
      
      function Externalize() : *
      {
         ExternalInterface.addCallback("IsLoggedIn",Player.IsLoggedIn);
         ExternalInterface.addCallback("Cell",Player.Cell);
         ExternalInterface.addCallback("Pad",Player.Pad);
         ExternalInterface.addCallback("Class",Player.Class);
         ExternalInterface.addCallback("State",Player.State);
         ExternalInterface.addCallback("Health",Player.Health);
         ExternalInterface.addCallback("HealthMax",Player.HealthMax);
         ExternalInterface.addCallback("Mana",Player.Mana);
         ExternalInterface.addCallback("ManaMax",Player.ManaMax);
         ExternalInterface.addCallback("Map",Player.Map);
         ExternalInterface.addCallback("Level",Player.Level);
         ExternalInterface.addCallback("Gold",Player.Gold);
         ExternalInterface.addCallback("HasTarget",Player.HasTarget);
         ExternalInterface.addCallback("IsAfk",Player.IsAfk);
         ExternalInterface.addCallback("AllSkillsAvailable",Player.AllSkillsAvailable);
         ExternalInterface.addCallback("SkillAvailable",Player.SkillAvailable);
         ExternalInterface.addCallback("Position",Player.Position);
         ExternalInterface.addCallback("WalkToPoint",Player.WalkToPoint);
         ExternalInterface.addCallback("CancelTarget",Player.CancelTarget);
         ExternalInterface.addCallback("CancelTargetSelf",Player.CancelTargetSelf);
         ExternalInterface.addCallback("MuteToggle",Player.MuteToggle);
         ExternalInterface.addCallback("AttackMonster",Player.AttackMonster);
         ExternalInterface.addCallback("Jump",Player.Jump);
         ExternalInterface.addCallback("Rest",Player.Rest);
         ExternalInterface.addCallback("Join",Player.Join);
         ExternalInterface.addCallback("Equip",Player.Equip);
         ExternalInterface.addCallback("EquipPotion",Player.EquipPotion);
         ExternalInterface.addCallback("GoTo",Player.GoTo);
         ExternalInterface.addCallback("UseBoost",Player.UseBoost);
         ExternalInterface.addCallback("UseSkill",Player.UseSkill);
         ExternalInterface.addCallback("GetMapItem",Player.GetMapItem);
         ExternalInterface.addCallback("Logout",Player.Logout);
         ExternalInterface.addCallback("HasActiveBoost",Player.HasActiveBoost);
         ExternalInterface.addCallback("UserID",Player.UserID);
         ExternalInterface.addCallback("CharID",Player.CharID);
         ExternalInterface.addCallback("Gender",Player.Gender);
         ExternalInterface.addCallback("SetEquip",Player.SetEquip);
         ExternalInterface.addCallback("GetEquip",Player.GetEquip);
         ExternalInterface.addCallback("Buff",Player.Buff);
         ExternalInterface.addCallback("PlayerData",Player.PlayerData);
         ExternalInterface.addCallback("GetFactions",Player.GetFactions);
         ExternalInterface.addCallback("ChangeName",Player.ChangeName);
         ExternalInterface.addCallback("ChangeGuild",Player.ChangeGuild);
         ExternalInterface.addCallback("ChangeAccessLevel",Player.ChangeAccessLevel);
         ExternalInterface.addCallback("MapLoadComplete",World.MapLoadComplete);
         ExternalInterface.addCallback("PlayersInMap",World.PlayersInMap);
         ExternalInterface.addCallback("IsActionAvailable",World.IsActionAvailable);
         ExternalInterface.addCallback("GetMonstersInCell",World.GetMonstersInCell);
         ExternalInterface.addCallback("GetVisibleMonstersInCell",World.GetVisibleMonstersInCell);
         ExternalInterface.addCallback("SetSpawnPoint",World.SetSpawnPoint);
         ExternalInterface.addCallback("IsMonsterAvailable",World.IsMonsterAvailable);
         ExternalInterface.addCallback("GetSkillName",World.GetSkillName);
         ExternalInterface.addCallback("GetCells",World.GetCells);
         ExternalInterface.addCallback("GetItemTree",World.GetItemTree);
         ExternalInterface.addCallback("RoomId",World.RoomId);
         ExternalInterface.addCallback("RoomNumber",World.RoomNumber);
         ExternalInterface.addCallback("Players",World.Players);
         ExternalInterface.addCallback("IsInProgress",Quests.IsInProgress);
         ExternalInterface.addCallback("Complete",Quests.Complete);
         ExternalInterface.addCallback("Accept",Quests.Accept);
         ExternalInterface.addCallback("LoadQuest",Quests.Load);
         ExternalInterface.addCallback("LoadQuests",Quests.LoadMultiple);
         ExternalInterface.addCallback("GetQuests",Quests.GetQuests);
         ExternalInterface.addCallback("GetQuestTree",Quests.GetQuestTree);
         ExternalInterface.addCallback("CanComplete",Quests.CanComplete);
         ExternalInterface.addCallback("IsAvailable",Quests.IsAvailable);
         ExternalInterface.addCallback("GetShops",Shops.GetShops);
         ExternalInterface.addCallback("LoadShop",Shops.Load);
         ExternalInterface.addCallback("LoadHairShop",Shops.LoadHairShop);
         ExternalInterface.addCallback("LoadArmorCustomizer",Shops.LoadArmorCustomizer);
         ExternalInterface.addCallback("SellItem",Shops.SellItem);
         ExternalInterface.addCallback("ResetShopInfo",Shops.ResetShopInfo);
         ExternalInterface.addCallback("IsShopLoaded",Shops.IsShopLoaded);
         ExternalInterface.addCallback("BuyItem",Shops.BuyItem);
         ExternalInterface.addCallback("GetBankItems",Bank.GetBankItems);
         ExternalInterface.addCallback("BankSlots",Bank.BankSlots);
         ExternalInterface.addCallback("UsedBankSlots",Bank.UsedBankSlots);
         ExternalInterface.addCallback("TransferToBank",Bank.TransferToBank);
         ExternalInterface.addCallback("TransferToInventory",Bank.TransferToInventory);
         ExternalInterface.addCallback("BankSwap",Bank.BankSwap);
         ExternalInterface.addCallback("ShowBank",Bank.Show);
         ExternalInterface.addCallback("LoadBankItems",Bank.LoadBankItems);
         ExternalInterface.addCallback("GetInventoryItems",Inventory.GetInventoryItems);
         ExternalInterface.addCallback("InventorySlots",Inventory.InventorySlots);
         ExternalInterface.addCallback("UsedInventorySlots",Inventory.UsedInventorySlots);
         ExternalInterface.addCallback("GetTempItems",TempInventory.GetTempItems);
         ExternalInterface.addCallback("ItemIsInTemp",TempInventory.ItemIsInTemp);
         ExternalInterface.addCallback("GetHouseItems",House.GetHouseItems);
         ExternalInterface.addCallback("HouseSlots",House.HouseSlots);
         ExternalInterface.addCallback("IsTemporarilyKicked",AutoRelogin.IsTemporarilyKicked);
         ExternalInterface.addCallback("Login",AutoRelogin.Login);
         ExternalInterface.addCallback("ResetServers",AutoRelogin.ResetServers);
         ExternalInterface.addCallback("AreServersLoaded",AutoRelogin.AreServersLoaded);
         ExternalInterface.addCallback("Connect",AutoRelogin.Connect);
         ExternalInterface.addCallback("GetUsername",this.GetUsername);
         ExternalInterface.addCallback("GetPassword",this.GetPassword);
         ExternalInterface.addCallback("SetFPS",this.SetFPS);
         ExternalInterface.addCallback("RealAddress",this.RealAddress);
         ExternalInterface.addCallback("RealPort",this.RealPort);
         ExternalInterface.addCallback("setTitle",this.setTitle);
         ExternalInterface.addCallback("callGameFunction",callGameFunction);
         ExternalInterface.addCallback("SetInfiniteRange",Settings.SetInfiniteRange);
         ExternalInterface.addCallback("SetProvokeMonsters",Settings.SetProvokeMonsters);
         ExternalInterface.addCallback("SetEnemyMagnet",Settings.SetEnemyMagnet);
         ExternalInterface.addCallback("SetLagKiller",Settings.SetLagKiller);
         ExternalInterface.addCallback("DestroyPlayers",Settings.DestroyPlayers);
         ExternalInterface.addCallback("SetSkipCutscenes",Settings.SetSkipCutscenes);
         ExternalInterface.addCallback("SetWalkSpeed",Settings.SetWalkSpeed);
      }
      
      public function RealAddress() : String
      {
         return "\"" + Game.objServerInfo.RealAddress + "\"";
      }
      
      public function RealPort() : String
      {
         return Game.objServerInfo.RealPort;
      }
      
      private function GetUsername() : String
      {
         return "\"" + Username + "\"";
      }
      
      private function GetPassword() : String
      {
         return "\"" + Password + "\"";
      }
      
      private function SetFPS(param1:String) : void
      {
         _stage.frameRate = parseInt(param1);
      }
      
      public function setTitle(title:String) : void
      {
         Game.mcLogin.mcLogo.txtTitle.htmlText = "<font color=\"#CC1F41\">Release:</font>: " + title;
         Game.params.sTitle.htmlText = "<font color=\"#CC1F41\">Release:</font>: " + title;
      }
   }
}
