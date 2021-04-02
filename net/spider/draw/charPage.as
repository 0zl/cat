package net.spider.draw
{
   import characterA_fla.movFaction_73;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.net.SecureSocket;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import net.spider.avatar.relAvatarMC;
   import net.spider.main;
   
   public class charPage extends MovieClip
   {
       
      
      public var txtClassName:TextField;
      
      public var btClose:SimpleButton;
      
      public var mcCharUI:MovieClip;
      
      public var txtWeapon:TextField;
      
      public var movFaction:movFaction_73;
      
      public var txtArmor:TextField;
      
      public var btCharPage:MovieClip;
      
      public var txtGuildName:TextField;
      
      public var txtHelm:TextField;
      
      public var txtLvl:TextField;
      
      public var txtPet:TextField;
      
      public var txtAlignment:TextField;
      
      public var txtUserName:TextField;
      
      public var txtCape:TextField;
      
      var socket:SecureSocket;
      
      var userName:String;
      
      var flashvars:URLVariables;
      
      var _tempMC:relAvatarMC;
      
      private var petMC;
      
      var htmlContent:String;
      
      public function charPage(_userName:String)
      {
         super();
         this.x = 205;
         this.y = 80;
         this.visible = false;
         this.userName = _userName;
         this.socket = new SecureSocket();
         this.socket.addEventListener(Event.CLOSE,this.closeHandler);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.onCharPageLoad);
         try
         {
            this.socket.connect("account.aq.com",443);
            this.socket.writeUTFBytes("GET /CharPage?id=" + this.userName.split(" ").join("+") + " HTTP/1.1\r\n");
            this.socket.writeUTFBytes("User-Agent: Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) ArtixGameLauncher/2.0.4 Chrome/73.0.3683.121 Electron/5.0.11 Safari/537.36\r\n");
            this.socket.writeUTFBytes("Host: account.aq.com\r\n");
            this.socket.writeUTFBytes("Connection: close\r\n\r\n");
            this.socket.flush();
         }
         catch(error:Error)
         {
            socket.close();
         }
         this.btCharPage.addEventListener(MouseEvent.CLICK,this.onBtCharPage,false,0,true);
         this.btClose.addEventListener(MouseEvent.CLICK,this.onBtClose,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onDrag,false,0,true);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag,false,0,true);
      }
      
      public function onDrag(e:MouseEvent) : void
      {
         this.startDrag();
      }
      
      public function onStopDrag(e:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      public function closeHandler(e:*) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         if(this.htmlContent.indexOf("FlashVars") == -1)
         {
            modalClass = main.Game.world.getClass("ModalMC");
            modal = new modalClass();
            modalO = {};
            modalO.strBody = "User not found: " + this.userName;
            modalO.params = {};
            modalO.glow = "red,medium";
            modalO.btns = "mono";
            main._stage.addChild(modal);
            modal.init(modalO);
            return;
         }
         this.htmlContent = this.htmlContent.split("<param name=\"FlashVars\" value=\"&amp;")[1];
         this.htmlContent = this.htmlContent.split("\" />")[0];
         this.htmlContent = this.htmlContent.split("&amp;").join("&");
         this.htmlContent = this.htmlContent.split("&quot;").join("\"");
         this.htmlContent = this.htmlContent.split(" ").join("+");
         trace(this.htmlContent);
         this.flashvars = new URLVariables(this.htmlContent);
         this.txtUserName.text = this.flashvars.strName.split("+").join(" ");
         this.txtLvl.text = this.flashvars.intLevel.split("+").join(" ").split(" -")[0];
         if(this.flashvars.intLevel.split("+").join(" ").indexOf(" Guild") > -1)
         {
            this.txtGuildName.text = this.flashvars.intLevel.split("+").join(" ").split("--- ")[1].substring(0,this.flashvars.intLevel.split("+").join(" ").split("--- ")[1].length - 6);
         }
         else
         {
            this.txtGuildName.text = "None";
         }
         this.txtClassName.text = this.flashvars.strClassName.split("+").join(" ");
         if(this.txtClassName.text == "")
         {
            this.txtClassName.text = "None";
         }
         this.txtWeapon.text = this.flashvars.strWeaponName.split("+").join(" ");
         if(this.txtWeapon.text == "")
         {
            this.txtWeapon.text = "None";
         }
         this.txtArmor.text = this.flashvars.strArmorName.split("+").join(" ");
         if(this.txtArmor.text == "")
         {
            this.txtArmor.text = "None";
         }
         this.txtHelm.text = this.flashvars.strHelmName.split("+").join(" ");
         if(this.txtHelm.text == "")
         {
            this.txtHelm.text = "None";
         }
         this.txtCape.text = this.flashvars.strCapeName.split("+").join(" ");
         if(this.txtCape.text == "")
         {
            this.txtCape.text = "None";
         }
         this.txtPet.text = this.flashvars.strPetName.split("+").join(" ");
         if(this.txtPet.text == "")
         {
            this.txtPet.text = "None";
         }
         var strFaction:String = this.flashvars.strFaction.split("+").join(" ");
         this.txtAlignment.text = strFaction;
         if(strFaction == "Neutral")
         {
            this.movFaction.gotoAndStop(2);
         }
         if(strFaction == "Good")
         {
            this.movFaction.gotoAndStop(3);
         }
         if(strFaction == "Evil")
         {
            this.movFaction.gotoAndStop(4);
         }
         if(strFaction == "Chaos")
         {
            this.movFaction.gotoAndStop(5);
         }
         this._tempMC = new relAvatarMC();
         this._tempMC.world = main.Game.world;
         this.copyTo(this._tempMC.mcChar);
         this._tempMC.hideHPBar();
         this._tempMC.name = "DisplayMC";
         this.mcCharUI.mcBG.addChild(this._tempMC);
         this._tempMC.x = 250;
         this._tempMC.y = -30;
         this._tempMC.scaleX *= -3;
         this._tempMC.scaleY *= 3;
         this.visible = true;
      }
      
      public function getAchievement(index:int) : int
      {
         if(index < 0 || index > 31)
         {
            return -1;
         }
         var iA:* = this.flashvars.ia1;
         if(iA == null)
         {
            return -1;
         }
         return (iA & Math.pow(2,index)) == 0 ? 0 : 1;
      }
      
      public function copyTo(param1:MovieClip) : void
      {
         var _loc7_:* = undefined;
         var class_petMC:Class = null;
         var _loc3_:* = undefined;
         var Avatar:Class = main.Game.world.getClass("Avatar") as Class;
         var _tempAvt:* = new Avatar(main.Game);
         _tempAvt.pnm = main.Game.world.myAvatar.pnm;
         _tempAvt.objData = main.Game.copyObj(main.Game.world.myAvatar.objData);
         this._tempMC.pAV = _tempAvt;
         this._tempMC.pAV.pMC = this._tempMC;
         this._tempMC.pAV.objData.intColorHair = this.flashvars.intColorHair;
         this._tempMC.pAV.objData.intColorSkin = this.flashvars.intColorSkin;
         this._tempMC.pAV.objData.intColorEye = this.flashvars.intColorEye;
         this._tempMC.pAV.objData.intColorBase = this.flashvars.intColorBase;
         this._tempMC.pAV.objData.intColorTrim = this.flashvars.intColorTrim;
         this._tempMC.pAV.objData.intColorAccessory = this.flashvars.intColorAccessory;
         this._tempMC.pAV.objData.strHairFilename = this.flashvars.strHairFile;
         this._tempMC.pAV.objData.strHairName = this.flashvars.strHairName;
         this._tempMC.pAV.objData.eqp.co["sFile"] = this.flashvars.strClassFile;
         this._tempMC.pAV.objData.eqp.co["sLink"] = this.flashvars.strClassLink;
         this._tempMC.pAV.objData.eqp.Weapon["sFile"] = this.flashvars.strWeaponFile;
         this._tempMC.pAV.objData.eqp.Weapon["sLink"] = this.flashvars.strWeaponLink;
         this._tempMC.pAV.objData.eqp.Weapon["sType"] = this.flashvars.strWeaponType;
         this._tempMC.pAV.objData.eqp.ba["sFile"] = this.flashvars.strCapeFile;
         this._tempMC.pAV.objData.eqp.ba["sLink"] = this.flashvars.strCapeLink;
         this._tempMC.pAV.objData.eqp.he["sFile"] = this.flashvars.strHelmFile;
         this._tempMC.pAV.objData.eqp.he["sLink"] = this.flashvars.strHelmLink;
         this._tempMC.pAV.objData.strGender = this.flashvars.strGender;
         this._tempMC.strGender = this.flashvars.strGender;
         this._tempMC.pAV.dataLeaf.showHelm = this.flashvars.strHelmFile != "none" && this.getAchievement(1) == 0;
         this._tempMC.pAV.dataLeaf.showCloak = this.flashvars.strCapeFile != "none" && this.getAchievement(0) == 0;
         var _loc2_:* = ["cape","backhair","robe","backrobe"];
         for(_loc3_ in _loc2_)
         {
            if(typeof param1[_loc2_[_loc3_]] != undefined)
            {
               param1[_loc2_[_loc3_]].visible = false;
            }
         }
         if(!this._tempMC.pAV.dataLeaf.showHelm || this._tempMC.pAV.objData.eqp.he.sFile == "none")
         {
            this._tempMC.loadHair();
         }
         for(_loc7_ in main.Game.world.myAvatar.objData.eqp)
         {
            switch(_loc7_)
            {
               case "Weapon":
                  this._tempMC.loadWeapon(this._tempMC.pAV.objData.eqp[_loc7_].sFile,null);
                  break;
               case "he":
                  if(this._tempMC.pAV.dataLeaf.showHelm && this._tempMC.pAV.objData.eqp.he.sFile != "none")
                  {
                     this._tempMC.loadHelm(this._tempMC.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "ba":
                  if(this._tempMC.pAV.dataLeaf.showCloak && this._tempMC.pAV.objData.eqp.ba.sFile != "none")
                  {
                     this._tempMC.loadCape(this._tempMC.pAV.objData.eqp[_loc7_].sFile,null);
                  }
                  break;
               case "co":
                  this._tempMC.loadArmor(this._tempMC.pAV.objData.eqp[_loc7_].sFile,this._tempMC.pAV.objData.eqp[_loc7_].sLink);
                  break;
            }
         }
         if(this.flashvars.strPetFile != "none" && this.getAchievement(2) == 0)
         {
            class_petMC = main.Game.world.getClass("PetMC") as Class;
            this.petMC = new class_petMC();
            this.petMC.mouseEnabled = this.petMC.mouseChildren = false;
            this.petMC.pAV = this._tempMC.pAV;
            main.Game.world.queueLoad({
               "strFile":main.Game.getFilePath() + this.flashvars.strPetFile,
               "callBackA":this.onLoadPetComplete,
               "avt":this._tempMC.pAV,
               "sES":"Pet"
            });
         }
      }
      
      public function onLoadPetComplete(param1:Event) : void
      {
         var pet:Class = main.Game.world.getClass(this.flashvars.strPetLink) as Class;
         this.petMC.removeChildAt(1);
         this.petMC.mcChar = MovieClip(this.petMC.addChildAt(new pet(),1));
         this.mcCharUI.mcBG.addChild(this.petMC);
         this.petMC.scale(2);
         this.petMC.turn("left");
         this.petMC.x = 50;
         this.petMC.y = -150;
         this.petMC.shadow.visible = false;
         this.mcCharUI.mcBG.setChildIndex(this.petMC,this.mcCharUI.mcBG.numChildren - 2);
      }
      
      public function ioErrorHandler(e:*) : void
      {
         var modalClass:Class = null;
         var modal:* = undefined;
         var modalO:* = undefined;
         modalClass = main.Game.world.getClass("ModalMC");
         modal = new modalClass();
         modalO = {};
         modalO.strBody = "Connection Error";
         modalO.params = {};
         modalO.glow = "red,medium";
         modalO.btns = "mono";
         main._stage.addChild(modal);
         modal.init(modalO);
      }
      
      public function onCharPageLoad(e:Event) : *
      {
         this.htmlContent += this.socket.readUTFBytes(this.socket.bytesAvailable);
      }
      
      public function onBtCharPage(e:*) : void
      {
         navigateToURL(new URLRequest("http://www.aq.com/character.asp?id=" + this.userName),"_blank");
      }
      
      public function onBtClose(e:*) : void
      {
         this.parent.removeChild(this);
      }
   }
}
