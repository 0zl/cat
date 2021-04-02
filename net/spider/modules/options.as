package net.spider.modules
{
   import Game_fla.chkBox_29;
   import Game_fla.chkBox_69;
   import Game_fla.mcRecount_88;
   import Game_fla.mcRecount_89;
   import Game_fla.mcRecount_90;
   import Game_fla.mcRecount_97;
   import fl.controls.List;
   import fl.controls.TextInput;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public dynamic class options extends MovieClip
   {
       
      
      public var btnLeftDisWepAnim:MovieClip;
      
      public var btnRightDisableFX:MovieClip;
      
      public var btnClear:SimpleButton;
      
      public var txtGreen:TextInput;
      
      public var btnRightCSkillAnim:MovieClip;
      
      public var txtQPin:TextField;
      
      public var btnRightQPrev:MovieClip;
      
      public var btnRightDraggable:MovieClip;
      
      public var btnRightDisWepAnim:MovieClip;
      
      public var btnLeftEscSelf:MovieClip;
      
      public var txtEscSelf:TextField;
      
      public var txtSkillAnim:TextField;
      
      public var chkInvertDrop:chkBox_29;
      
      public var txtCDrops:TextField;
      
      public var btnRightChat:MovieClip;
      
      public var txtDisMonAnim:TextField;
      
      public var txtEsc:TextField;
      
      public var txtSkill:TextField;
      
      public var txtDetailQuest:TextField;
      
      public var btnRightQLog:MovieClip;
      
      public var txtQLog:TextField;
      
      public var txtHideP:TextField;
      
      public var btnLeftChat:MovieClip;
      
      public var btnLeftEsc:MovieClip;
      
      public var btnRightSkill:MovieClip;
      
      public var btnRightBitmap:MovieClip;
      
      public var btnRightSBPCDrops:MovieClip;
      
      public var txtDisWepAnim:TextField;
      
      public var btnLeftMType:MovieClip;
      
      public var btnLeftSkill:MovieClip;
      
      public var btnLeftQLog:MovieClip;
      
      public var btnLeftBitmap:MovieClip;
      
      public var txtHex:TextInput;
      
      public var txtChat:TextField;
      
      public var btnLeftDisMonAnim:MovieClip;
      
      public var btnClose:SimpleButton;
      
      public var txtBitmap:TextField;
      
      public var colorPreview:MovieClip;
      
      public var txtRed:TextInput;
      
      public var btnColor:SimpleButton;
      
      public var chkRed:MovieClip;
      
      public var btnLeftBoosts:MovieClip;
      
      public var btnCombat:mcRecount_89;
      
      public var txtSBPCDrops:TextField;
      
      public var btnClearBlacklist:SimpleButton;
      
      public var txtBlue:TextInput;
      
      public var btnLeftSkillAnim:MovieClip;
      
      public var txtDisMapAnim:TextField;
      
      public var btnLeftSBPCDrops:MovieClip;
      
      public var btnRemoveBlacklist:SimpleButton;
      
      public var btnRightDisMonAnim:MovieClip;
      
      public var btnRightEsc:MovieClip;
      
      public var btnRightSkillAnim:MovieClip;
      
      public var btnLeftQPin:MovieClip;
      
      public var txtDetailDrop:TextField;
      
      public var btnGeneral:mcRecount_97;
      
      public var btnMisc:mcRecount_90;
      
      public var txtVersion:TextField;
      
      public var chkBlue:chkBox_69;
      
      public var frame:MovieClip;
      
      public var btnRightQPin:MovieClip;
      
      public var btnLeftQAccept:MovieClip;
      
      public var btnLeftDetailQuest:MovieClip;
      
      public var btnRightDetailDrop:MovieClip;
      
      public var btnLeftQPrev:MovieClip;
      
      public var btnLeftQRates:MovieClip;
      
      public var txtDraggable:TextField;
      
      public var bg:MovieClip;
      
      public var chkName:chkBox_29;
      
      public var txtMType:TextField;
      
      public var btnFPS:SimpleButton;
      
      public var btnLeftDisableFX:MovieClip;
      
      public var txtDisableFX:TextField;
      
      public var btnRightQAccept:MovieClip;
      
      public var txtQPrev:TextField;
      
      public var txtQRates:TextField;
      
      public var btnGraphics:mcRecount_88;
      
      public var btnLeftDisMapAnim:MovieClip;
      
      public var btnRightMType:MovieClip;
      
      public var btnRightLockM:MovieClip;
      
      public var btnRightDetailQuest:MovieClip;
      
      public var btnLeftDraggable:MovieClip;
      
      public var btnLeftCDrops:MovieClip;
      
      public var txtBlacklist:TextInput;
      
      public var btnRightEscSelf:MovieClip;
      
      public var txtLockM:TextField;
      
      public var chkDisWepAnim:chkBox_29;
      
      public var btnAddBlacklist:SimpleButton;
      
      public var btnRightBoosts:MovieClip;
      
      public var listBlack:List;
      
      public var chkSelfOnly:chkBox_29;
      
      public var btnLeftLockM:MovieClip;
      
      public var txtQAccept:TextField;
      
      public var btnLeftDetailDrop:MovieClip;
      
      public var btnRightQRates:MovieClip;
      
      public var btnRightDisMapAnim:MovieClip;
      
      public var btnRightCDrops:MovieClip;
      
      public var btnRightHideP:MovieClip;
      
      public var btnLeftHideP:MovieClip;
      
      public var btnLeftCSkillAnim:MovieClip;
      
      public var txtCSkillAnim:TextField;
      
      public var txtBoosts:TextField;
      
      public var __setPropDict:Dictionary;
      
      public function options()
      {
         this.__setPropDict = new Dictionary(true);
         super();
      }
      
      function __setProp_txtRed_sprite575_Layer5_2() : *
      {
         if(this.__setPropDict[this.txtRed] == undefined || int(this.__setPropDict[this.txtRed]) != 3)
         {
            this.__setPropDict[this.txtRed] = 3;
            try
            {
               this.txtRed["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.txtRed.displayAsPassword = false;
            this.txtRed.editable = true;
            this.txtRed.enabled = true;
            this.txtRed.maxChars = 0;
            this.txtRed.restrict = "";
            this.txtRed.text = "255";
            this.txtRed.visible = true;
            try
            {
               this.txtRed["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      function __setProp_txtGreen_sprite575_Layer5_2() : *
      {
         if(this.__setPropDict[this.txtGreen] == undefined || int(this.__setPropDict[this.txtGreen]) != 3)
         {
            this.__setPropDict[this.txtGreen] = 3;
            try
            {
               this.txtGreen["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.txtGreen.displayAsPassword = false;
            this.txtGreen.editable = true;
            this.txtGreen.enabled = true;
            this.txtGreen.maxChars = 0;
            this.txtGreen.restrict = "";
            this.txtGreen.text = "255";
            this.txtGreen.visible = true;
            try
            {
               this.txtGreen["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      function __setProp_txtBlue_sprite575_Layer5_2() : *
      {
         if(this.__setPropDict[this.txtBlue] == undefined || int(this.__setPropDict[this.txtBlue]) != 3)
         {
            this.__setPropDict[this.txtBlue] = 3;
            try
            {
               this.txtBlue["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.txtBlue.displayAsPassword = false;
            this.txtBlue.editable = true;
            this.txtBlue.enabled = true;
            this.txtBlue.maxChars = 0;
            this.txtBlue.restrict = "";
            this.txtBlue.text = "255";
            this.txtBlue.visible = true;
            try
            {
               this.txtBlue["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      function __setProp_txtHex_sprite575_Layer5_2() : *
      {
         if(this.__setPropDict[this.txtHex] == undefined || int(this.__setPropDict[this.txtHex]) != 3)
         {
            this.__setPropDict[this.txtHex] = 3;
            try
            {
               this.txtHex["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            }
            this.txtHex.displayAsPassword = false;
            this.txtHex.editable = true;
            this.txtHex.enabled = true;
            this.txtHex.maxChars = 0;
            this.txtHex.restrict = "";
            this.txtHex.text = "#ffffff";
            this.txtHex.visible = true;
            try
            {
               this.txtHex["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            }
         }
      }
   }
}
