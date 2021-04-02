package aqlite_fla
{
   import fl.controls.NumericStepper;
   import fl.controls.Slider;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   public dynamic class CameraToolWD_A_510 extends MovieClip
   {
       
      
      public var background:MovieClip;
      
      public var btnMirror:SimpleButton;
      
      public var numWepScale:NumericStepper;
      
      public var txtFocus:TextField;
      
      public var btnSetFocus:SimpleButton;
      
      public var sldrRotation:Slider;
      
      public var btnAddLayer:SimpleButton;
      
      public var btnDelLayer:SimpleButton;
      
      public var btnInCombat:SimpleButton;
      
      public function CameraToolWD_A_510()
      {
         super();
         this.__setProp_sldrRotation_CameraToolWD_A_Layer1_0();
         this.__setProp_numWepScale_CameraToolWD_A_Layer1_0();
      }
      
      function __setProp_sldrRotation_CameraToolWD_A_Layer1_0() : *
      {
         try
         {
            this.sldrRotation["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldrRotation.direction = "horizontal";
         this.sldrRotation.enabled = true;
         this.sldrRotation.liveDragging = true;
         this.sldrRotation.maximum = 360;
         this.sldrRotation.minimum = 0;
         this.sldrRotation.snapInterval = 0;
         this.sldrRotation.tickInterval = 0;
         this.sldrRotation.value = 0;
         this.sldrRotation.visible = true;
         try
         {
            this.sldrRotation["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_numWepScale_CameraToolWD_A_Layer1_0() : *
      {
         try
         {
            this.numWepScale["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.numWepScale.enabled = true;
         this.numWepScale.maximum = 10;
         this.numWepScale.minimum = 0;
         this.numWepScale.stepSize = 0.001;
         this.numWepScale.value = 0.222;
         this.numWepScale.visible = true;
         try
         {
            this.numWepScale["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}
