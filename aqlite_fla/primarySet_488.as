package aqlite_fla
{
   import fl.controls.ColorPicker;
   import fl.controls.ComboBox;
   import fl.controls.NumericStepper;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public dynamic class primarySet_488 extends MovieClip
   {
       
      
      public var btnGlowOff:SimpleButton;
      
      public var btnVisibility:SimpleButton;
      
      public var txtClassName:TextField;
      
      public var colGlowOff:ColorPicker;
      
      public var btnResetPlayer:SimpleButton;
      
      public var btnToggleDummy:SimpleButton;
      
      public var cbVisibility:ComboBox;
      
      public var btnClass5:SimpleButton;
      
      public var btnEmote:SimpleButton;
      
      public var colGlow:ColorPicker;
      
      public var cbEmotes:ComboBox;
      
      public var btnClass4:SimpleButton;
      
      public var btnGlowPlayer:SimpleButton;
      
      public var btnStonePlayer:SimpleButton;
      
      public var btnFreezePlayer:SimpleButton;
      
      public var btnHitPlayer:SimpleButton;
      
      public var btnGlowMain:SimpleButton;
      
      public var btnClass1:SimpleButton;
      
      public var colGlowMain:ColorPicker;
      
      public var btnShowDeattach:SimpleButton;
      
      public var btnClass3:SimpleButton;
      
      public var numScaling:NumericStepper;
      
      public var btnClass2:SimpleButton;
      
      public var btnDeattach:SimpleButton;
      
      public var txtDeattached:TextField;
      
      public var colBG:ColorPicker;
      
      public function primarySet_488()
      {
         super();
         this.__setProp_colBG_primarySet_Layer1_0();
         this.__setProp_numScaling_primarySet_Layer1_0();
         this.__setProp_colGlow_primarySet_Layer1_0();
         this.__setProp_colGlowMain_primarySet_Layer1_0();
         this.__setProp_colGlowOff_primarySet_Layer1_0();
      }
      
      function __setProp_colBG_primarySet_Layer1_0() : *
      {
         try
         {
            this.colBG["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.colBG.enabled = true;
         this.colBG.selectedColor = 16777215;
         this.colBG.showTextField = true;
         this.colBG.visible = true;
         try
         {
            this.colBG["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_numScaling_primarySet_Layer1_0() : *
      {
         try
         {
            this.numScaling["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.numScaling.enabled = true;
         this.numScaling.maximum = 10;
         this.numScaling.minimum = 0;
         this.numScaling.stepSize = 0.1;
         this.numScaling.value = 3;
         this.numScaling.visible = true;
         try
         {
            this.numScaling["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_colGlow_primarySet_Layer1_0() : *
      {
         try
         {
            this.colGlow["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.colGlow.enabled = true;
         this.colGlow.selectedColor = 16777215;
         this.colGlow.showTextField = true;
         this.colGlow.visible = true;
         try
         {
            this.colGlow["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_colGlowMain_primarySet_Layer1_0() : *
      {
         try
         {
            this.colGlowMain["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.colGlowMain.enabled = true;
         this.colGlowMain.selectedColor = 16777215;
         this.colGlowMain.showTextField = true;
         this.colGlowMain.visible = true;
         try
         {
            this.colGlowMain["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_colGlowOff_primarySet_Layer1_0() : *
      {
         try
         {
            this.colGlowOff["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.colGlowOff.enabled = true;
         this.colGlowOff.selectedColor = 16777215;
         this.colGlowOff.showTextField = true;
         this.colGlowOff.visible = true;
         try
         {
            this.colGlowOff["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
