package net.spider.draw
{
   import fl.data.DataProvider;
   import fl.events.ColorPickerEvent;
   import fl.events.SliderEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.spider.avatar.relAvatarMC;
   import net.spider.main;
   
   public class cameratool extends MovieClip
   {
       
      
      public var weaponUI:MovieClip;
      
      public var background:MovieClip;
      
      public var dummyMC:MovieClip;
      
      public var btnLeft:SimpleButton;
      
      public var btnClose:SimpleButton;
      
      public var txtRight:TextField;
      
      public var btnExpand:SimpleButton;
      
      public var txtLeft:TextField;
      
      public var btnExpandTxt:TextField;
      
      public var btnRight:SimpleButton;
      
      public var cameratoolUI:MovieClip;
      
      public var AvatarDisplay:relAvatarMC;
      
      private var op;
      
      private var tp;
      
      private var walkTS;
      
      private var walkD;
      
      public var mcCharHidden:Boolean;
      
      public var mcCharOptions:Object;
      
      public var scaleAvt:Number = 3;
      
      public var weaponDeattached:Boolean;
      
      public var deattachedMain:MovieClip;
      
      public var deattachedOff:MovieClip;
      
      public var weaponFocus:int = 0;
      
      public var isMirrored:Boolean;
      
      public var isMirroredOff:Boolean;
      
      public var isFrozen:Boolean;
      
      public var isStoned:Boolean;
      
      public var isHit:Boolean;
      
      public var glowMain:Boolean;
      
      public var glowOff:Boolean;
      
      public var glowPlayer:Boolean;
      
      var oldX:int;
      
      var oldY:int;
      
      public function cameratool()
      {
         this.mcCharOptions = {
            "backhair":false,
            "robe":false,
            "backrobe":false
         };
         super();
         this.btnExpandTxt.mouseEnabled = false;
         this.weaponUI.visible = false;
         this.dummyMC.visible = false;
         this.cameratoolUI.secondary.visible = false;
         this.btnExpand.addEventListener(MouseEvent.CLICK,this.onBtnExpand,false,0,true);
         this.AvatarDisplay = new relAvatarMC();
         this.AvatarDisplay.world = main.Game.world;
         this.copyTo(this.AvatarDisplay.mcChar);
         this.AvatarDisplay.x = 650;
         this.AvatarDisplay.y = 450;
         this.AvatarDisplay.hideHPBar();
         this.AvatarDisplay.gotoAndPlay("in2");
         this.AvatarDisplay.mcChar.gotoAndPlay("Idle");
         this.addChild(this.AvatarDisplay);
         this.AvatarDisplay.scale(this.scaleAvt);
         this.AvatarDisplay.shadow.visible = false;
         this.cameratoolUI.primary.txtClassName.text = main.Game.world.myAvatar.objData.strClassName;
         this.background.mouseEnabled = true;
         this.background.addEventListener(MouseEvent.CLICK,this.onWalk,false,0,true);
         this.cameratoolUI.primary.colBG.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,this.onColBG,false,0,true);
         this.cameratoolUI.primary.colBG.addEventListener(Event.CLOSE,this.onColBG,false,0,true);
         var emotes:Array = [{"label":"Idle"},{"label":"Walk"},{"label":"Dance"},{"label":"Laugh"},{"label":"Point"},{"label":"Use"},{"label":"Stern"},{"label":"SternLoop"},{"label":"Salute"},{"label":"Cheer"},{"label":"Facepalm"},{"label":"Airguitar"},{"label":"Backflip"},{"label":"Sleep"},{"label":"Jump"},{"label":"Punt"},{"label":"Dance2"},{"label":"Swordplay"},{"label":"Feign"},{"label":"Dead"},{"label":"Wave"},{"label":"Bow"},{"label":"Rest"},{"label":"Cry"},{"label":"Unsheath"},{"label":"Fight"},{"label":"Attack1"},{"label":"Attack2"},{"label":"Attack3"},{"label":"Attack4"},{"label":"Hit"},{"label":"Knockout"},{"label":"Getup"},{"label":"Stab"},{"label":"Thrash"},{"label":"Castgood"},{"label":"Cast1"},{"label":"Cast2"},{"label":"Cast3"},{"label":"Sword/ShieldFight"},{"label":"Sword/ShieldAttack1"},{"label":"Sword/ShieldAttack2"},{"label":"ShieldBlock"},{"label":"DuelWield/DaggerFight"},{"label":"DuelWield/DaggerAttack1"},{"label":"DuelWield/DaggerAttack2"},{"label":"FistweaponFight"},{"label":"FistweaponAttack1"},{"label":"FistweaponAttack2"},{"label":"PolearmFight"},{"label":"PolearmAttack1"},{"label":"PolearmAttack2"},{"label":"RangedFight"},{"label":"UnarmedFight"},{"label":"UnarmedAttack1"},{"label":"UnarmedAttack2"},{"label":"KickAttack"},{"label":"FlipAttack"},{"label":"Dodge"},{"label":"Powerup"},{"label":"Kneel"},{"label":"Jumpcheer"},{"label":"Salute2"},{"label":"Cry2"},{"label":"Spar"},{"label":"Samba"},{"label":"Stepdance"},{"label":"Headbang"},{"label":"Dazed"},{"label":"Psychic1"},{"label":"Psychic2"},{"label":"Danceweapon"},{"label":"Useweapon"},{"label":"Throw"},{"label":"FireBreath"}];
         emotes.sortOn("label");
         this.cameratoolUI.primary.cbEmotes.dataProvider = new DataProvider(emotes);
         this.cameratoolUI.primary.btnEmote.addEventListener(MouseEvent.CLICK,this.onBtnEmote,false,0,true);
         this.cameratoolUI.primary.btnClass1.addEventListener(MouseEvent.CLICK,this.onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass2.addEventListener(MouseEvent.CLICK,this.onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass3.addEventListener(MouseEvent.CLICK,this.onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass4.addEventListener(MouseEvent.CLICK,this.onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnClass5.addEventListener(MouseEvent.CLICK,this.onBtnClass,false,0,true);
         this.cameratoolUI.primary.btnToggleDummy.addEventListener(MouseEvent.CLICK,this.onBtnToggleDummy,false,0,true);
         this.dummyMC.addEventListener(MouseEvent.MOUSE_DOWN,this.onDummyDown,false,0,true);
         this.dummyMC.addEventListener(MouseEvent.MOUSE_UP,this.onDummyUp,false,0,true);
         var visible:Array = [{"label":"Mainhand"},{"label":"Offhand"},{"label":"Cape"},{"label":"Helmet"},{"label":"Player"},{"label":"Shadow"},{"label":"Head"},{"label":"Robe"},{"label":"Back Robe"}];
         visible.sortOn("label");
         this.cameratoolUI.primary.cbVisibility.dataProvider = new DataProvider(visible);
         this.cameratoolUI.primary.btnVisibility.addEventListener(MouseEvent.CLICK,this.onBtnVisibility,false,0,true);
         this.cameratoolUI.primary.numScaling.addEventListener(Event.CHANGE,this.onNumScaling,false,0,true);
         this.cameratoolUI.primary.btnDeattach.addEventListener(MouseEvent.CLICK,this.onBtnDeattach,false,0,true);
         this.cameratoolUI.primary.btnShowDeattach.addEventListener(MouseEvent.CLICK,this.onBtnShowDeattach,false,0,true);
         this.weaponUI.background.addEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponUIDown,false,0,true);
         this.weaponUI.background.addEventListener(MouseEvent.MOUSE_UP,this.onWeaponUIUp,false,0,true);
         this.weaponUI.txtFocus.mouseEnabled = false;
         this.weaponUI.btnSetFocus.addEventListener(MouseEvent.CLICK,this.onBtnSetFocus,false,0,true);
         this.weaponUI.sldrRotation.addEventListener(SliderEvent.CHANGE,this.onSldrRotation,false,0,true);
         this.weaponUI.btnAddLayer.addEventListener(MouseEvent.CLICK,this.onBtnAddLayer,false,0,true);
         this.weaponUI.btnDelLayer.addEventListener(MouseEvent.CLICK,this.onBtnDelLayer,false,0,true);
         this.weaponUI.numWepScale.addEventListener(Event.CHANGE,this.onNumWepScale,false,0,true);
         this.weaponUI.btnMirror.addEventListener(MouseEvent.CLICK,this.onBtnMirror,false,0,true);
         this.weaponUI.btnInCombat.addEventListener(MouseEvent.CLICK,this.onBtnInCombat,false,0,true);
         this.cameratoolUI.primary.btnFreezePlayer.addEventListener(MouseEvent.CLICK,this.onBtnFreezePlayer,false,0,true);
         this.cameratoolUI.primary.btnStonePlayer.addEventListener(MouseEvent.CLICK,this.onBtnStonePlayer,false,0,true);
         this.cameratoolUI.primary.btnHitPlayer.addEventListener(MouseEvent.CLICK,this.onBtnHitPlayer,false,0,true);
         this.cameratoolUI.primary.btnResetPlayer.addEventListener(MouseEvent.CLICK,this.onBtnResetPlayer,false,0,true);
         this.cameratoolUI.primary.colGlow.addEventListener(Event.CLOSE,this.onColGlow,false,0,true);
         this.cameratoolUI.primary.colGlow.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,this.onColGlow,false,0,true);
         this.cameratoolUI.primary.colGlowMain.addEventListener(Event.CLOSE,this.onColGlowMain,false,0,true);
         this.cameratoolUI.primary.colGlowMain.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,this.onColGlowMain,false,0,true);
         this.cameratoolUI.primary.colGlowOff.addEventListener(Event.CLOSE,this.onColGlowOff,false,0,true);
         this.cameratoolUI.primary.colGlowOff.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,this.onColGlowOff,false,0,true);
         this.cameratoolUI.primary.btnGlowMain.addEventListener(MouseEvent.CLICK,this.onBtnGlowMain,false,0,true);
         this.cameratoolUI.primary.btnGlowOff.addEventListener(MouseEvent.CLICK,this.onBtnGlowOff,false,0,true);
         this.cameratoolUI.primary.btnGlowPlayer.addEventListener(MouseEvent.CLICK,this.onBtnGlowPlayer,false,0,true);
         this.cameratoolUI.secondary.btnGender.addEventListener(MouseEvent.CLICK,this.onBtnGender,false,0,true);
         this.cameratoolUI.secondary.btnTurnHead.addEventListener(MouseEvent.CLICK,this.onBtnTurnHead,false,0,true);
         this.txtLeft.mouseEnabled = false;
         this.txtRight.mouseEnabled = false;
         this.btnClose.addEventListener(MouseEvent.CLICK,this.onBtnClose,false,0,true);
         this.btnLeft.addEventListener(MouseEvent.CLICK,this.onBtnLeft,false,0,true);
         this.btnRight.addEventListener(MouseEvent.CLICK,this.onBtnRight,false,0,true);
      }
      
      public function onBtnLeft(e:MouseEvent) : void
      {
         this.cameratoolUI.primary.visible = !this.cameratoolUI.primary.visible;
         this.cameratoolUI.secondary.visible = !this.cameratoolUI.secondary.visible;
      }
      
      public function onBtnRight(e:MouseEvent) : void
      {
         this.cameratoolUI.primary.visible = !this.cameratoolUI.primary.visible;
         this.cameratoolUI.secondary.visible = !this.cameratoolUI.secondary.visible;
      }
      
      public function copyTo(param1:MovieClip) : void
      {
         var _loc7_:* = undefined;
         var _loc3_:* = undefined;
         this.AvatarDisplay.pAV = main.Game.world.myAvatar;
         this.AvatarDisplay.strGender = this.AvatarDisplay.pAV.objData.strGender;
         var _loc2_:* = ["cape","backhair","robe","backrobe"];
         for(_loc3_ in _loc2_)
         {
            if(typeof param1[_loc2_[_loc3_]] != undefined)
            {
               param1[_loc2_[_loc3_]].visible = false;
            }
         }
         if(!this.AvatarDisplay.pAV.dataLeaf.showHelm || !("he" in this.AvatarDisplay.pAV.objData.eqp) && this.AvatarDisplay.pAV.objData.eqp.he == null)
         {
            this.AvatarDisplay.loadHair();
         }
         for(_loc7_ in main.Game.world.myAvatar.objData.eqp)
         {
            switch(_loc7_)
            {
               case "Weapon":
                  this.AvatarDisplay.loadWeapon(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  break;
               case "he":
                  if(this.AvatarDisplay.pAV.dataLeaf.showHelm)
                  {
                     this.AvatarDisplay.loadHelm(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "ba":
                  if(this.AvatarDisplay.pAV.dataLeaf.showCloak)
                  {
                     this.AvatarDisplay.loadCape(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "ar":
                  if(main.Game.world.myAvatar.objData.eqp.co == null)
                  {
                     this.AvatarDisplay.loadClass(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "co":
                  this.AvatarDisplay.loadArmor(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,this.AvatarDisplay.pAV.objData.eqp[_loc7_].sLink);
                  break;
            }
         }
      }
      
      public function loadWeaponOff(param1:*, param2:*) : void
      {
         main.Game.world.queueLoad({
            "strFile":main.Game.world.rootClass.getFilePath() + param1,
            "callBackA":this.onLoadWeaponOffComplete,
            "avt":this.AvatarDisplay.pAV,
            "sES":"weapon"
         });
      }
      
      public function onLoadWeaponOffComplete(param1:Event) : void
      {
         var AssetClass:Class = null;
         this.AvatarDisplay.pAV.updateLoaded();
         this.AvatarDisplay.mcChar.weaponOff.removeChildAt(0);
         try
         {
            AssetClass = main.Game.world.getClass(this.AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            this.AvatarDisplay.mcChar.weaponOff.addChild(new AssetClass());
         }
         catch(err:Error)
         {
            trace(AvatarDisplay.pAV.objData.eqp.Weapon.sLink + " weaponOff added to display list manually");
            AvatarDisplay.mcChar.weaponOff.addChild(param1.target.content);
         }
         this.AvatarDisplay.mcChar.weaponOff.visible = true;
      }
      
      public function onBtnClose(e:MouseEvent) : void
      {
         main.Game.world.visible = true;
         this.parent.removeChild(this);
      }
      
      public function onWalk(e:MouseEvent) : void
      {
         if(this.isFrozen)
         {
            return;
         }
         this.walkTo(e.stageX,e.stageY,16);
      }
      
      public function walkTo(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         param1 = param1;
         param2 = param2;
         param3 = param3;
         this.op = new Point(this.AvatarDisplay.x,this.AvatarDisplay.y);
         this.tp = new Point(param1,param2);
         _loc4_ = Point.distance(this.op,this.tp);
         this.walkTS = new Date().getTime();
         this.walkD = Math.round(1000 * (_loc4_ / (param3 * 22)));
         if(this.walkD > 0)
         {
            _loc5_ = this.op.x - this.tp.x;
            if(_loc5_ < 0)
            {
               this.AvatarDisplay.turn("right");
            }
            else
            {
               this.AvatarDisplay.turn("left");
            }
            if(!this.AvatarDisplay.mcChar.onMove)
            {
               this.AvatarDisplay.mcChar.onMove = true;
               if(this.AvatarDisplay.mcChar.currentLabel != "Walk")
               {
                  this.AvatarDisplay.mcChar.gotoAndPlay("Walk");
               }
            }
            this.AvatarDisplay.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameWalk);
            this.AvatarDisplay.addEventListener(Event.ENTER_FRAME,this.onEnterFrameWalk,false,0,true);
         }
      }
      
      public function onEnterFrameWalk(event:Event) : void
      {
         var now:Number = NaN;
         var f:Number = NaN;
         var vX:* = undefined;
         var vY:* = undefined;
         var hitOK:Boolean = false;
         var aP:Point = null;
         var aR:Rectangle = null;
         now = new Date().getTime();
         f = (now - this.walkTS) / this.walkD;
         if(f > 1)
         {
            f = 1;
         }
         if(Point.distance(this.op,this.tp) > 0.5 && this.AvatarDisplay.mcChar.onMove)
         {
            vX = this.AvatarDisplay.x;
            vY = this.AvatarDisplay.y;
            this.AvatarDisplay.x = Point.interpolate(this.tp,this.op,f).x;
            this.AvatarDisplay.y = Point.interpolate(this.tp,this.op,f).y;
            if(Math.round(vX) == Math.round(this.AvatarDisplay.x) && Math.round(vY) == Math.round(this.AvatarDisplay.y) && now > this.walkTS + 50)
            {
               this.stopWalking();
            }
         }
         else
         {
            this.stopWalking();
         }
      }
      
      public function stopWalking() : void
      {
         if(this.AvatarDisplay.mcChar.onMove)
         {
            this.AvatarDisplay.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameWalk);
         }
         this.AvatarDisplay.mcChar.onMove = false;
         this.AvatarDisplay.mcChar.gotoAndPlay("Idle");
      }
      
      public function onBtnExpand(e:MouseEvent) : void
      {
         if(this.cameratoolUI.visible)
         {
            this.cameratoolUI.visible = false;
            this.weaponUI.visible = false;
            this.btnLeft.visible = false;
            this.btnRight.visible = false;
            this.txtLeft.visible = false;
            this.txtRight.visible = false;
            this.btnExpandTxt.text = "+";
         }
         else
         {
            this.cameratoolUI.visible = true;
            this.btnLeft.visible = true;
            this.btnRight.visible = true;
            this.txtLeft.visible = true;
            this.txtRight.visible = true;
            this.btnExpandTxt.text = "-";
         }
      }
      
      public function onColBG(e:*) : void
      {
         var backgroundTransform:* = new ColorTransform();
         backgroundTransform.color = "0x" + e.currentTarget.hexValue;
         this.background.transform.colorTransform = backgroundTransform;
      }
      
      public function onBtnEmote(e:MouseEvent) : void
      {
         if(this.cameratoolUI.primary.cbEmotes.selectedItem.label == "Walk")
         {
            this.AvatarDisplay.mcChar.onMove = true;
         }
         else
         {
            this.AvatarDisplay.mcChar.onMove = false;
         }
         this.AvatarDisplay.mcChar.gotoAndPlay(this.cameratoolUI.primary.cbEmotes.selectedItem.label);
      }
      
      public function onBtnClass(e:MouseEvent) : void
      {
         var animSkill:String = null;
         var active:* = undefined;
         switch(e.currentTarget.name)
         {
            case "btnClass1":
               animSkill = main.Game.world.actions.active[0].anim;
               active = main.Game.world.actions.active[0];
               break;
            case "btnClass2":
               animSkill = main.Game.world.actions.active[1].anim;
               active = main.Game.world.actions.active[1];
               break;
            case "btnClass3":
               animSkill = main.Game.world.actions.active[2].anim;
               active = main.Game.world.actions.active[2];
               break;
            case "btnClass4":
               animSkill = main.Game.world.actions.active[3].anim;
               active = main.Game.world.actions.active[3];
               break;
            case "btnClass5":
               animSkill = main.Game.world.actions.active[4].anim;
               active = main.Game.world.actions.active[4];
         }
         if(animSkill.indexOf(",") > -1)
         {
            animSkill = animSkill.split(",")[Math.round(Math.random() * (animSkill.split(",").length - 1))];
         }
         this.AvatarDisplay.mcChar.gotoAndPlay(animSkill);
         this.AvatarDisplay.spFX = main.Game.world.myAvatar.pMC.spFX;
         this.AvatarDisplay.spFX.strl = active.strl;
         this.AvatarDisplay.spFX.fx = active.fx;
         this.AvatarDisplay.spFX.tgt = active.tgt;
         this.castSpellFX(this.AvatarDisplay.pAV,this.AvatarDisplay.spFX,null,7);
      }
      
      public function castSpellFX(param1:*, param2:*, param3:*, param4:int = 0) : *
      {
         var _loc7_:* = undefined;
         var _loc6_:* = main.Game.world.getClass(param2.strl) as Class;
         if(_loc6_ != null)
         {
            _loc7_ = new _loc6_();
            _loc7_.spellDur = param4;
            this.addChild(_loc7_);
            _loc7_.scaleX *= this.scaleAvt;
            _loc7_.scaleY *= this.scaleAvt;
            _loc7_.mouseEnabled = false;
            _loc7_.mouseChildren = false;
            _loc7_.visible = true;
            _loc7_.world = main.Game.world;
            _loc7_.strl = param2.strl;
            if(param2.tgt == "s")
            {
               _loc7_.tMC = this.AvatarDisplay;
            }
            else
            {
               _loc7_.tMC = this.dummyMC;
            }
            switch(param2.fx)
            {
               case "p":
                  _loc7_.x = this.AvatarDisplay.x + 71;
                  _loc7_.y = this.AvatarDisplay.y - this.AvatarDisplay.mcChar.height * 0.5 + 122;
                  _loc7_.dir = this.dummyMC.x - this.AvatarDisplay.x >= 0 ? 1 : -1;
                  break;
               case "w":
                  _loc7_.x = _loc7_.tMC.x + 71;
                  _loc7_.y = _loc7_.tMC.y + 3 + 122;
                  if(param1 != null)
                  {
                     if(_loc7_.tMC.x < this.AvatarDisplay.x)
                     {
                        _loc7_.scaleX *= -1;
                     }
                  }
            }
            this.showSpellFXHit({
               "tMC":_loc7_.tMC,
               "strl":_loc7_.strl
            });
         }
         else
         {
            trace();
            trace("*>*>*> Could not load class " + param2.strl);
            trace();
         }
      }
      
      public function showSpellFXHit(param1:*) : *
      {
         var _loc2_:* = {};
         switch(param1.strl)
         {
            case "sp_ice1":
               _loc2_.strl = "sp_ice2";
               break;
            case "sp_el3":
               _loc2_.strl = "sp_el2";
               break;
            case "sp_ed3":
               _loc2_.strl = "sp_ed1";
               break;
            case "sp_ef1":
            case "sp_ef6":
               _loc2_.strl = "sp_ef2";
         }
         _loc2_.fx = "w";
         _loc2_.avts = [param1.tMC];
         this.castSpellFX(null,_loc2_,null);
      }
      
      public function onBtnToggleDummy(e:MouseEvent) : void
      {
         this.dummyMC.visible = !this.dummyMC.visible;
      }
      
      public function onDummyDown(e:MouseEvent) : void
      {
         this.dummyMC.startDrag();
      }
      
      public function onDummyUp(e:MouseEvent) : void
      {
         this.dummyMC.stopDrag();
      }
      
      public function get isCharHidden() : Boolean
      {
         return this.mcCharHidden;
      }
      
      public function onBtnVisibility(e:MouseEvent) : void
      {
         switch(this.cameratoolUI.primary.cbVisibility.selectedItem.label)
         {
            case "Mainhand":
               this.AvatarDisplay.mcChar.weapon.visible = !this.AvatarDisplay.mcChar.weapon.visible;
               break;
            case "Offhand":
               this.AvatarDisplay.mcChar.weaponOff.visible = !this.AvatarDisplay.mcChar.weaponOff.visible;
               break;
            case "Cape":
               this.AvatarDisplay.mcChar.cape.visible = !this.AvatarDisplay.mcChar.cape.visible;
               break;
            case "Helmet":
               this.AvatarDisplay.mcChar.head.helm.visible = !this.AvatarDisplay.mcChar.head.helm.visible;
               this.AvatarDisplay.mcChar.head.hair.visible = !this.AvatarDisplay.mcChar.head.helm.visible;
               break;
            case "Player":
               this.mcCharHidden = !this.mcCharHidden;
               if(!this.mcCharHidden)
               {
                  this.AvatarDisplay.mcChar.head.visible = true;
                  this.AvatarDisplay.mcChar.chest.visible = true;
                  this.AvatarDisplay.mcChar.frontshoulder.visible = true;
                  this.AvatarDisplay.mcChar.backshoulder.visible = true;
                  this.AvatarDisplay.mcChar.fronthand.visible = true;
                  this.AvatarDisplay.mcChar.backhand.visible = true;
                  this.AvatarDisplay.mcChar.frontthigh.visible = true;
                  this.AvatarDisplay.mcChar.backthigh.visible = true;
                  this.AvatarDisplay.mcChar.frontshin.visible = true;
                  this.AvatarDisplay.mcChar.backshin.visible = true;
                  this.AvatarDisplay.mcChar.idlefoot.visible = true;
                  this.AvatarDisplay.mcChar.backfoot.visible = true;
                  this.AvatarDisplay.mcChar.hip.visible = true;
                  this.AvatarDisplay.mcChar.robe.visible = this.mcCharOptions["robe"];
                  this.AvatarDisplay.mcChar.backrobe.visible = this.mcCharOptions["backrobe"];
                  this.AvatarDisplay.mcChar.backhair.visible = this.mcCharOptions["backhair"];
               }
               else
               {
                  this.AvatarDisplay.mcChar.head.visible = false;
                  this.AvatarDisplay.mcChar.chest.visible = false;
                  this.AvatarDisplay.mcChar.frontshoulder.visible = false;
                  this.AvatarDisplay.mcChar.backshoulder.visible = false;
                  this.AvatarDisplay.mcChar.fronthand.visible = false;
                  this.AvatarDisplay.mcChar.backhand.visible = false;
                  this.AvatarDisplay.mcChar.frontthigh.visible = false;
                  this.AvatarDisplay.mcChar.backthigh.visible = false;
                  this.AvatarDisplay.mcChar.frontshin.visible = false;
                  this.AvatarDisplay.mcChar.backshin.visible = false;
                  this.AvatarDisplay.mcChar.idlefoot.visible = false;
                  this.AvatarDisplay.mcChar.backfoot.visible = false;
                  this.AvatarDisplay.mcChar.hip.visible = false;
                  if(this.AvatarDisplay.mcChar.robe.visible)
                  {
                     this.AvatarDisplay.mcChar.robe.visible = false;
                     this.mcCharOptions["robe"] = true;
                  }
                  if(this.AvatarDisplay.mcChar.backrobe.visible)
                  {
                     this.AvatarDisplay.mcChar.backrobe.visible = false;
                     this.mcCharOptions["backrobe"] = true;
                  }
                  if(this.AvatarDisplay.mcChar.backhair.visible)
                  {
                     this.AvatarDisplay.mcChar.backhair.visible = false;
                     this.mcCharOptions["backhair"] = true;
                  }
               }
               break;
            case "Shadow":
               this.AvatarDisplay.shadow.visible = !this.AvatarDisplay.shadow.visible;
               break;
            case "Head":
               this.AvatarDisplay.mcChar.head.visible = !this.AvatarDisplay.mcChar.head.visible;
               break;
            case "Robe":
               this.AvatarDisplay.mcChar.robe.visible = !this.AvatarDisplay.mcChar.robe.visible;
               break;
            case "Back Robe":
               this.AvatarDisplay.mcChar.backrobe.visible = !this.AvatarDisplay.mcChar.backrobe.visible;
         }
      }
      
      public function onNumScaling(e:Event) : void
      {
         this.scaleAvt = this.cameratoolUI.primary.numScaling.textField.text;
         this.AvatarDisplay.scale(this.scaleAvt);
      }
      
      public function onBtnDeattach(e:MouseEvent) : void
      {
         var wItem:Object = null;
         if(this.weaponDeattached)
         {
            this.weaponDeattached = false;
            this.isMirrored = false;
            this.isMirroredOff = false;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: OFF";
            this.deattachedMain.removeEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponDownDrag);
            this.deattachedMain.removeEventListener(MouseEvent.MOUSE_UP,this.onWeaponUpDrag);
            this.AvatarDisplay.mcChar.weapon.visible = true;
            wItem = this.AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
            if(wItem != null && wItem.sType != null)
            {
               if(wItem.sType == "Dagger")
               {
                  this.AvatarDisplay.mcChar.weaponOff.visible = true;
                  this.deattachedOff.removeEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponOffDownDrag);
                  this.deattachedOff.removeEventListener(MouseEvent.MOUSE_UP,this.onWeaponOffUpDrag);
               }
            }
            this.AvatarDisplay.mcChar.removeChild(this.deattachedMain);
            this.AvatarDisplay.mcChar.removeChild(this.deattachedOff);
            this.deattachedMain = null;
            this.deattachedOff = null;
         }
         else
         {
            this.weaponDeattached = true;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: ON";
            main.Game.world.queueLoad({
               "strFile":main.Game.world.rootClass.getFilePath() + this.AvatarDisplay.pAV.objData.eqp.Weapon.sFile,
               "callBackA":this.onLoadWeaponClones,
               "avt":this.AvatarDisplay.pAV,
               "sES":"weapon"
            });
            this.AvatarDisplay.mcChar.weapon.visible = false;
            this.AvatarDisplay.mcChar.weaponOff.visible = false;
         }
      }
      
      public function onLoadWeaponClones(e:*) : void
      {
         var AssetClass:Class = null;
         try
         {
            AssetClass = main.Game.world.getClass(this.AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            this.deattachedMain = new AssetClass();
         }
         catch(err:Error)
         {
            trace(" Weapon added to display list manually");
            deattachedMain = MovieClip(e.target.content);
         }
         this.AvatarDisplay.mcChar.addChild(this.deattachedMain);
         this.deattachedMain.addEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponDownDrag,false,0,true);
         this.deattachedMain.addEventListener(MouseEvent.MOUSE_UP,this.onWeaponUpDrag,false,0,true);
         this.deattachedMain.scaleX = this.deattachedMain.scaleY = 0.222;
         var wItem:Object = this.AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
         if(wItem != null && wItem.sType != null)
         {
            if(wItem.sType == "Dagger")
            {
               main.Game.world.queueLoad({
                  "strFile":main.Game.world.rootClass.getFilePath() + this.AvatarDisplay.pAV.objData.eqp.Weapon.sFile,
                  "callBackA":this.onLoadWeaponOffClones,
                  "avt":this.AvatarDisplay.pAV,
                  "sES":"weapon"
               });
            }
         }
      }
      
      public function onLoadWeaponOffClones(e:*) : void
      {
         var AssetClass:Class = null;
         try
         {
            AssetClass = main.Game.world.getClass(this.AvatarDisplay.pAV.objData.eqp.Weapon.sLink) as Class;
            this.deattachedOff = new AssetClass();
         }
         catch(err:Error)
         {
            trace(" Weapon added to display list manually");
            deattachedOff = MovieClip(e.target.content);
         }
         this.AvatarDisplay.mcChar.addChild(this.deattachedOff);
         this.deattachedOff.scaleX = this.deattachedOff.scaleY = 0.222;
         this.deattachedOff.addEventListener(MouseEvent.MOUSE_UP,this.onWeaponOffUpDrag,false,0,true);
         this.deattachedOff.addEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponOffDownDrag,false,0,true);
      }
      
      public function onWeaponUpDrag(e:MouseEvent) : void
      {
         this.deattachedMain.stopDrag();
      }
      
      public function onWeaponDownDrag(e:MouseEvent) : void
      {
         this.deattachedMain.startDrag();
      }
      
      public function onWeaponOffUpDrag(e:MouseEvent) : void
      {
         this.deattachedOff.stopDrag();
      }
      
      public function onWeaponOffDownDrag(e:MouseEvent) : void
      {
         this.deattachedOff.startDrag();
      }
      
      public function onBtnShowDeattach(e:MouseEvent) : void
      {
         if(!this.weaponDeattached)
         {
            this.weaponUI.visible = false;
            return;
         }
         this.weaponUI.visible = !this.weaponUI.visible;
         if(this.weaponUI.visible)
         {
            this.setChildIndex(this.weaponUI,this.numChildren - 1);
         }
      }
      
      public function onBtnSetFocus(e:MouseEvent) : void
      {
         if(!this.deattachedOff)
         {
            this.weaponFocus = 0;
            this.weaponUI.txtFocus.text = "Mainhand";
            return;
         }
         ++this.weaponFocus;
         if(this.weaponFocus >= 3)
         {
            this.weaponFocus = 0;
         }
         switch(this.weaponFocus)
         {
            case 0:
               this.weaponUI.txtFocus.text = "Mainhand";
               break;
            case 1:
               this.weaponUI.txtFocus.text = "Offhand";
               break;
            case 2:
               this.weaponUI.txtFocus.text = "Both";
         }
      }
      
      public function onSldrRotation(e:Event) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               this.deattachedMain.rotation = this.weaponUI.sldrRotation.value;
               break;
            case 1:
               this.deattachedOff.rotation = this.weaponUI.sldrRotation.value;
               break;
            case 2:
               this.deattachedMain.rotation = this.weaponUI.sldrRotation.value;
               this.deattachedOff.rotation = this.weaponUI.sldrRotation.value;
         }
      }
      
      public function onBtnAddLayer(e:MouseEvent) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) >= this.AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedMain,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) + 1);
               break;
            case 1:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) >= this.AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedOff,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) + 1);
               break;
            case 2:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) >= this.AvatarDisplay.mcChar.numChildren - 2 || this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) == this.AvatarDisplay.mcChar.numChildren - 2)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedMain,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) + 1);
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedOff,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) + 1);
               break;
         }
      }
      
      public function onBtnDelLayer(e:MouseEvent) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) <= 0)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedMain,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) - 1);
               break;
            case 1:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) <= 0)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedOff,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) - 1);
               break;
            case 2:
               if(this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) <= 0 || this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) <= 0)
               {
                  return;
               }
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedMain,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedMain) - 1);
               this.AvatarDisplay.mcChar.setChildIndex(this.deattachedOff,this.AvatarDisplay.mcChar.getChildIndex(this.deattachedOff) - 1);
               break;
         }
      }
      
      public function onNumWepScale(e:Event) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               this.deattachedMain.scaleX = this.deattachedMain.scaleY = this.weaponUI.numWepScale.textField.text * (!!this.isMirrored ? -1 : 1);
               break;
            case 1:
               this.deattachedOff.scaleX = this.deattachedOff.scaleY = this.weaponUI.numWepScale.textField.text * (!!this.isMirroredOff ? -1 : 1);
               break;
            case 2:
               this.deattachedMain.scaleX = this.deattachedMain.scaleY = this.weaponUI.numWepScale.textField.text * (!!this.isMirrored ? -1 : 1);
               this.deattachedOff.scaleX = this.deattachedOff.scaleY = this.weaponUI.numWepScale.textField.text * (!!this.isMirroredOff ? -1 : 1);
         }
      }
      
      public function onBtnMirror(e:MouseEvent) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               this.isMirrored = !this.isMirrored;
               this.deattachedMain.scaleX *= -1;
               break;
            case 1:
               this.isMirroredOff = !this.isMirroredOff;
               this.deattachedOff.scaleX *= -1;
               break;
            case 2:
               this.isMirrored = !this.isMirrored;
               this.isMirroredOff = !this.isMirroredOff;
               this.deattachedMain.scaleX *= -1;
               this.deattachedOff.scaleX *= -1;
         }
      }
      
      public function onBtnInCombat(e:MouseEvent) : void
      {
         switch(this.weaponFocus)
         {
            case 0:
               if(this.deattachedMain.bAttack == true && this.deattachedMain.currentLabel != "Attack")
               {
                  this.deattachedMain.gotoAndPlay("Attack");
               }
               else
               {
                  this.deattachedMain.gotoAndPlay("Idle");
               }
               break;
            case 1:
               if(this.deattachedOff.bAttack == true && this.deattachedOff.currentLabel != "Attack")
               {
                  this.deattachedOff.gotoAndPlay("Attack");
               }
               else
               {
                  this.deattachedOff.gotoAndPlay("Idle");
               }
               break;
            case 2:
               if(this.deattachedMain.bAttack == true && this.deattachedMain.currentLabel != "Attack")
               {
                  this.deattachedMain.gotoAndPlay("Attack");
               }
               else
               {
                  this.deattachedMain.gotoAndPlay("Idle");
               }
               if(this.deattachedOff.bAttack == true && this.deattachedOff.currentLabel != "Attack")
               {
                  this.deattachedOff.gotoAndPlay("Attack");
               }
               else
               {
                  this.deattachedOff.gotoAndPlay("Idle");
               }
         }
      }
      
      public function onWeaponUIDown(e:MouseEvent) : void
      {
         this.weaponUI.startDrag();
      }
      
      public function onWeaponUIUp(e:MouseEvent) : void
      {
         this.weaponUI.stopDrag();
      }
      
      public function onAvatarDown(e:MouseEvent) : void
      {
         this.AvatarDisplay.startDrag();
      }
      
      public function onAvatarUp(e:MouseEvent) : void
      {
         this.AvatarDisplay.stopDrag();
      }
      
      public function onBtnFreezePlayer(e:MouseEvent) : void
      {
         if(!this.isFrozen)
         {
            this.isFrozen = true;
            this.AvatarDisplay.mcChar.stop();
            this.AvatarDisplay.mcChar.addEventListener(MouseEvent.MOUSE_DOWN,this.onAvatarDown,false,0,true);
            this.AvatarDisplay.mcChar.addEventListener(MouseEvent.MOUSE_UP,this.onAvatarUp,false,0,true);
         }
         else
         {
            this.isFrozen = false;
            this.AvatarDisplay.mcChar.play();
            this.AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_DOWN,this.onAvatarDown);
            this.AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_UP,this.onAvatarUp);
         }
      }
      
      public function onBtnStonePlayer(e:MouseEvent) : void
      {
         if(!this.isStoned)
         {
            this.isStoned = true;
            this.AvatarDisplay.modulateColor(new ColorTransform(-1.3,-1.3,-1.3,0,100,100,100,0),"+");
         }
         else
         {
            this.isStoned = false;
            this.AvatarDisplay.modulateColor(new ColorTransform(-1.3,-1.3,-1.3,0,100,100,100,0),"-");
         }
      }
      
      public function onBtnHitPlayer(e:MouseEvent) : void
      {
         if(!this.isHit)
         {
            this.isHit = true;
            this.AvatarDisplay.modulateColor(new ColorTransform(0,0,0,0,255,255,255,0),"+");
         }
         else
         {
            this.isHit = false;
            this.AvatarDisplay.modulateColor(new ColorTransform(0,0,0,0,255,255,255,0),"-");
         }
      }
      
      public function onBtnResetPlayer(e:MouseEvent) : void
      {
         var wItem:Object = null;
         if(this.isFrozen)
         {
            this.isFrozen = false;
            this.AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_DOWN,this.onAvatarDown);
            this.AvatarDisplay.mcChar.removeEventListener(MouseEvent.MOUSE_UP,this.onAvatarUp);
         }
         this.isStoned = false;
         this.isHit = false;
         this.glowPlayer = false;
         this.glowMain = false;
         this.glowOff = false;
         this.isMirrored = false;
         this.isMirroredOff = false;
         this.mcCharHidden = false;
         this.mcCharOptions = {
            "backhair":false,
            "robe":false,
            "backrobe":false
         };
         if(this.weaponDeattached)
         {
            this.weaponDeattached = false;
            this.cameratoolUI.primary.txtDeattached.text = "Weapon Deattachment: OFF";
            this.deattachedMain.removeEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponDownDrag);
            this.deattachedMain.removeEventListener(MouseEvent.MOUSE_UP,this.onWeaponUpDrag);
            this.AvatarDisplay.mcChar.weapon.visible = true;
            wItem = this.AvatarDisplay.pAV.getItemByEquipSlot("Weapon");
            if(wItem != null && wItem.sType != null)
            {
               if(wItem.sType == "Dagger")
               {
                  this.AvatarDisplay.mcChar.weaponOff.visible = true;
                  this.deattachedOff.removeEventListener(MouseEvent.MOUSE_DOWN,this.onWeaponOffDownDrag);
                  this.deattachedOff.removeEventListener(MouseEvent.MOUSE_UP,this.onWeaponOffUpDrag);
               }
            }
            this.AvatarDisplay.mcChar.removeChild(this.deattachedMain);
            this.AvatarDisplay.mcChar.removeChild(this.deattachedOff);
            this.deattachedMain = null;
            this.deattachedOff = null;
         }
         this.removeChild(this.AvatarDisplay);
         this.AvatarDisplay = new relAvatarMC();
         this.AvatarDisplay.world = main.Game.world;
         this.copyTo(this.AvatarDisplay.mcChar);
         this.AvatarDisplay.x = 650;
         this.AvatarDisplay.y = 450;
         this.AvatarDisplay.hideHPBar();
         this.AvatarDisplay.gotoAndPlay("in2");
         this.AvatarDisplay.mcChar.gotoAndPlay("Idle");
         this.addChild(this.AvatarDisplay);
         this.AvatarDisplay.scale(this.scaleAvt);
      }
      
      public function onColGlow(e:*) : void
      {
         if(!this.glowPlayer)
         {
            return;
         }
         var glowFilter:* = new GlowFilter(e.currentTarget.selectedColor,1,8,8,2,1,false,false);
         this.AvatarDisplay.mcChar.filters = [glowFilter];
      }
      
      public function onColGlowMain(e:*) : void
      {
         if(!this.glowMain)
         {
            return;
         }
         var glowFilter:* = new GlowFilter(e.currentTarget.selectedColor,1,8,8,2,1,false,false);
         if(this.weaponDeattached)
         {
            this.deattachedMain.filters = [glowFilter];
         }
         else
         {
            this.AvatarDisplay.mcChar.weapon.filters = [glowFilter];
         }
      }
      
      public function onColGlowOff(e:*) : void
      {
         if(!this.glowOff)
         {
            return;
         }
         var glowFilter:* = new GlowFilter(e.currentTarget.selectedColor,1,8,8,2,1,false,false);
         if(this.weaponDeattached && this.deattachedOff)
         {
            this.deattachedOff.filters = [glowFilter];
         }
         else
         {
            this.AvatarDisplay.mcChar.weaponOff.filters = [glowFilter];
         }
      }
      
      public function onBtnGlowMain(e:MouseEvent) : void
      {
         var glowFilter:* = new GlowFilter(this.cameratoolUI.primary.colGlowMain.selectedColor,1,8,8,2,1,false,false);
         if(!this.glowMain)
         {
            this.glowMain = true;
            this.AvatarDisplay.mcChar.weapon.filters = [glowFilter];
         }
         else
         {
            this.glowMain = false;
            this.AvatarDisplay.mcChar.weapon.filters = [];
         }
      }
      
      public function onBtnGlowOff(e:MouseEvent) : void
      {
         var glowFilter:* = new GlowFilter(this.cameratoolUI.primary.colGlowOff.selectedColor,1,8,8,2,1,false,false);
         if(!this.glowOff)
         {
            this.glowOff = true;
            this.AvatarDisplay.mcChar.weaponOff.filters = [glowFilter];
         }
         else
         {
            this.glowOff = false;
            this.AvatarDisplay.mcChar.weaponOff.filters = [];
         }
      }
      
      public function onBtnGlowPlayer(e:MouseEvent) : void
      {
         var glowFilter:* = new GlowFilter(this.cameratoolUI.primary.colGlow.selectedColor,1,8,8,2,1,false,false);
         if(!this.glowPlayer)
         {
            this.glowPlayer = true;
            this.AvatarDisplay.mcChar.filters = [glowFilter];
         }
         else
         {
            this.glowPlayer = false;
            this.AvatarDisplay.mcChar.filters = [];
         }
      }
      
      public function onBtnGender(e:MouseEvent) : void
      {
         var _loc7_:* = undefined;
         var _loc3_:* = undefined;
         this.AvatarDisplay.pAV = main.Game.world.myAvatar;
         this.AvatarDisplay.strGender = this.AvatarDisplay.strGender == "M" ? "F" : "M";
         var _loc2_:* = ["cape","backhair","robe","backrobe"];
         for(_loc3_ in _loc2_)
         {
            if(typeof this.AvatarDisplay.mcChar[_loc2_[_loc3_]] != undefined)
            {
               this.AvatarDisplay.mcChar[_loc2_[_loc3_]].visible = false;
            }
         }
         if(!this.AvatarDisplay.pAV.dataLeaf.showHelm || !("he" in this.AvatarDisplay.pAV.objData.eqp) && this.AvatarDisplay.pAV.objData.eqp.he == null)
         {
            this.AvatarDisplay.loadHair();
         }
         for(_loc7_ in main.Game.world.myAvatar.objData.eqp)
         {
            switch(_loc7_)
            {
               case "Weapon":
                  this.AvatarDisplay.loadWeapon(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  break;
               case "he":
                  if(this.AvatarDisplay.pAV.dataLeaf.showHelm)
                  {
                     this.AvatarDisplay.loadHelm(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "ba":
                  if(this.AvatarDisplay.pAV.dataLeaf.showCloak)
                  {
                     this.AvatarDisplay.loadCape(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "ar":
                  if(main.Game.world.myAvatar.objData.eqp.co == null)
                  {
                     this.AvatarDisplay.loadClass(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "co":
                  this.AvatarDisplay.loadArmor(this.AvatarDisplay.pAV.objData.eqp[_loc7_].sFile,this.AvatarDisplay.pAV.objData.eqp[_loc7_].sLink);
                  break;
            }
         }
      }
      
      public function onBtnTurnHead(e:MouseEvent) : void
      {
         if(!this.oldX)
         {
            this.oldX = this.AvatarDisplay.mcChar.head.x;
            this.oldY = this.AvatarDisplay.mcChar.head.y;
         }
         this.AvatarDisplay.mcChar.head.scaleX *= -1;
         if(this.AvatarDisplay.mcChar.head.scaleX < 0)
         {
            this.AvatarDisplay.mcChar.head.x -= 7;
         }
         else
         {
            this.AvatarDisplay.mcChar.head.x = this.oldX;
            this.AvatarDisplay.mcChar.head.y = this.oldY;
         }
      }
   }
}
