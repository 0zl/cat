package net.spider.handlers
{
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import net.spider.draw.ToolTipMC;
   import net.spider.main;
   import net.spider.modules.*;
   
   public class targetskills extends MovieClip
   {
       
      
      public var toolTip:ToolTipMC;
      
      public var eventInitialized:Boolean = false;
      
      public var lastSkill:Object;
      
      public var icons:Object;
      
      public var scalar:Number = 0.6;
      
      var iconPriority:Vector.<String>;
      
      public var auras:Object;
      
      public var dateObj:Date;
      
      public function targetskills()
      {
         var i:* = undefined;
         var j:* = undefined;
         super();
         this.visible = false;
         if(this.toolTip == null)
         {
            this.toolTip = new ToolTipMC();
            main._stage.addChild(this.toolTip);
         }
         if(optionHandler.skill)
         {
            if(main.Game.ui)
            {
               if(!this.eventInitialized)
               {
                  for(i = 2; i < 6; i++)
                  {
                     if(main.Game.ui.mcInterface.actBar.getChildByName("i" + i))
                     {
                        main.Game.ui.mcInterface.actBar.getChildByName("i" + i).addEventListener(MouseEvent.CLICK,this.actIconClick,false,0,true);
                     }
                  }
                  this.eventInitialized = true;
               }
            }
            main._stage.addEventListener(KeyboardEvent.KEY_UP,this.key_actBar,false,0,true);
            main.Game.ui.addEventListener(MouseEvent.MOUSE_OVER,this.onOver,false,0,true);
            main.Game.ui.addEventListener(MouseEvent.MOUSE_OUT,this.onExit,false,0,true);
            main.Game.sfc.addEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler,false,0,true);
            this.auras = new Object();
         }
         else
         {
            main.Game.ui.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            main.Game.ui.removeEventListener(MouseEvent.MOUSE_OUT,this.onExit);
            main._stage.removeEventListener(KeyboardEvent.KEY_UP,this.key_actBar);
            main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
            if(this.eventInitialized)
            {
               for(j = 2; j < 6; j++)
               {
                  if(main.Game.ui.mcInterface.actBar.getChildByName("i" + j))
                  {
                     main.Game.ui.mcInterface.actBar.getChildByName("i" + j).removeEventListener(MouseEvent.CLICK,this.actIconClick);
                  }
               }
               this.eventInitialized = false;
            }
            this.auras = null;
            this.toolTip.close();
         }
      }
      
      public function actIconClick(e:*) : void
      {
         this.lastSkill = MovieClip(e.currentTarget).actObj;
      }
      
      public function key_actBar(param1:KeyboardEvent) : *
      {
         if(main._stage.focus == null || main._stage.focus != null && !("text" in main._stage.focus))
         {
            if(param1.charCode > 49 && param1.charCode < 55)
            {
               switch(param1.charCode)
               {
                  case 50:
                     this.lastSkill = main.Game.world.actions.active[1];
                     break;
                  case 51:
                     this.lastSkill = main.Game.world.actions.active[2];
                     break;
                  case 52:
                     this.lastSkill = main.Game.world.actions.active[3];
                     break;
                  case 53:
                     this.lastSkill = main.Game.world.actions.active[4];
               }
            }
         }
      }
      
      public function createIconMC(auraName:String, auraStacks:Number, isEnemy:Boolean) : void
      {
         var auraUI:MovieClip = null;
         var icon:Class = null;
         var ico:MovieClip = null;
         var skillIcon:Class = null;
         var base:MovieClip = null;
         var visual:MovieClip = null;
         if(this.icons == null)
         {
            this.icons = new Object();
            this.iconPriority = new Vector.<String>();
         }
         if(main.Game.ui.mcPortraitTarget)
         {
            if(!main.Game.ui.mcPortraitTarget.getChildByName("auraUI"))
            {
               auraUI = main.Game.ui.mcPortraitTarget.addChild(new MovieClip());
               auraUI.name = "auraUI";
               auraUI.x = 16;
               auraUI.y = 85;
            }
         }
         if(!this.icons.hasOwnProperty(auraName))
         {
            if(!isEnemy)
            {
               if(this.lastSkill.icon.indexOf(",") > -1)
               {
                  icon = main.Game.world.getClass(this.lastSkill.icon.split(",")[this.lastSkill.icon.split(",").length - 1]) as Class;
               }
               else
               {
                  icon = main.Game.world.getClass(this.lastSkill.icon) as Class;
               }
            }
            else
            {
               icon = main.Game.world.getClass("isp2") as Class;
            }
            ico = new icon();
            skillIcon = main.gameDomain.getDefinition("ib2") as Class;
            base = new skillIcon();
            this.icons[auraName] = main.Game.ui.mcPortraitTarget.getChildByName("auraUI").addChild(base);
            this.icons[auraName].auraName = auraName;
            this.icons[auraName].width = 42;
            this.icons[auraName].height = 39;
            this.icons[auraName].icon2 = null;
            this.icons[auraName].cnt.removeChildAt(0);
            this.icons[auraName].scaleX = this.scalar;
            this.icons[auraName].scaleY = this.scalar;
            this.icons[auraName].tQty.visible = false;
            visual = this.icons[auraName].cnt.addChild(ico);
            if(visual.width > visual.height)
            {
               visual.scaleX = visual.scaleY = 34 / visual.width;
            }
            else
            {
               visual.scaleX = visual.scaleY = 31 / visual.height;
            }
            visual.x = this.icons[auraName].bg.width / 2 - visual.width / 2;
            visual.y = this.icons[auraName].bg.height / 2 - visual.height / 2;
            this.icons[auraName].mouseChildren = false;
            this.iconPriority.push(auraName);
         }
         this.icons[auraName].auraStacks = auraStacks;
      }
      
      public function onOver(e:MouseEvent) : void
      {
         var auraObj:* = undefined;
         if(this.toolTip.isOpen)
         {
            this.toolTip.close();
         }
         if(e.target.name.indexOf("auraUI") <= -1)
         {
            return;
         }
         for each(auraObj in this.icons)
         {
            if(auraObj.hitTestPoint(e.stageX,e.stageY))
            {
               this.toolTip.openWith({"str":auraObj.auraName + " (" + auraObj.auraStacks + ")"});
               break;
            }
         }
      }
      
      public function onExit(e:MouseEvent) : void
      {
         if(e.target.name.indexOf("auraUI") > -1)
         {
            this.toolTip.close();
         }
      }
      
      public function rearrangeIconMC() : void
      {
         var nextRow:Number = 0;
         var rowCtr:Number = 0;
         for(var i:int = 0; i < this.iconPriority.length; i++)
         {
            if(i != 0 && i % 6 == 0)
            {
               nextRow += 28;
               rowCtr++;
            }
            this.icons[this.iconPriority[i]].x = 32 * (i - 6 * rowCtr) + 3;
            this.icons[this.iconPriority[i]].y = nextRow;
         }
      }
      
      public function clearMCs() : void
      {
         if(!main.Game)
         {
            return;
         }
         if(!main.Game.ui)
         {
            return;
         }
         if(!main.Game.ui.mcPortraitTarget)
         {
            return;
         }
         while(main.Game.ui.mcPortraitTarget.getChildByName("auraUI").numChildren > 0)
         {
            main.Game.ui.mcPortraitTarget.getChildByName("auraUI").removeChildAt(0);
         }
         this.toolTip.close();
         this.icons = new Object();
         this.iconPriority = new Vector.<String>();
      }
      
      public function onExtensionResponseHandler(e:*) : void
      {
         var aura:* = undefined;
         var resObj:* = undefined;
         var cmd:* = undefined;
         var i:* = undefined;
         var j:* = undefined;
         var a:* = undefined;
         var b:* = undefined;
         var k:* = undefined;
         if(!main.Game.sfc.isConnected)
         {
            main._stage.removeEventListener(KeyboardEvent.KEY_UP,this.key_actBar);
            main.Game.sfc.removeEventListener(SFSEvent.onExtensionResponse,this.onExtensionResponseHandler);
            return;
         }
         var protocol:* = e.params.type;
         if(protocol == "json")
         {
            resObj = e.params.dataObj;
            cmd = resObj.cmd;
            switch(cmd)
            {
               case "ct":
                  if(resObj.a == null)
                  {
                     return;
                  }
                  if(!main.Game.world.myAvatar.target)
                  {
                     return;
                  }
                  for each(i in resObj.a)
                  {
                     if(main.Game.world.myAvatar.target)
                     {
                        if(main.Game.world.myAvatar.target.dataLeaf.MonID)
                        {
                           if(i.tInf != "m:" + main.Game.world.myAvatar.target.dataLeaf.MonMapID.toString())
                           {
                              continue;
                           }
                        }
                        else if(i.tInf != "p:" + main.Game.world.myAvatar.target.dataLeaf.entID.toString())
                        {
                           continue;
                        }
                     }
                     if(i.auras)
                     {
                        for each(j in i.auras)
                        {
                           if(i.cmd.indexOf("+") > -1)
                           {
                              if(!this.auras.hasOwnProperty(j.nam))
                              {
                                 this.auras[j.nam] = 1;
                                 this.createIconMC(j.nam,1,i.cInf.substring(2) != main.Game.sfc.myUserId);
                                 this.coolDownAct(this.icons[j.nam],j.dur * 1000,new Date().getTime());
                              }
                              else
                              {
                                 this.auras[j.nam] += 1;
                                 if(!main.Game.world.myAvatar.target)
                                 {
                                    this.auras = new Object();
                                    this.clearMCs();
                                 }
                                 for each(a in main.Game.world.myAvatar.target.dataLeaf.auras)
                                 {
                                    if(a.nam == j.nam)
                                    {
                                       a.ts = j.ts;
                                       this.createIconMC(j.nam,this.auras[j.nam],i.cInf.substring(2) != main.Game.sfc.myUserId);
                                       this.coolDownAct(this.icons[j.nam],j.dur * 1000,a.ts);
                                       break;
                                    }
                                 }
                              }
                           }
                           else if(i.cmd.indexOf("-") > -1)
                           {
                              this.auras[j.nam] = null;
                           }
                        }
                     }
                     else if(i.cmd.indexOf("+") > -1)
                     {
                        if(!this.auras.hasOwnProperty(i.aura.nam))
                        {
                           this.auras[i.aura.nam] = 1;
                           this.createIconMC(i.aura.nam,1,i.cInf.substring(2) != main.Game.sfc.myUserId);
                           this.coolDownAct(this.icons[i.aura.nam],i.aura.dur * 1000,new Date().getTime());
                        }
                        else
                        {
                           this.auras[i.aura.nam] += 1;
                           if(!main.Game.world.myAvatar.target)
                           {
                              this.auras = new Object();
                              this.clearMCs();
                           }
                           for each(b in main.Game.world.myAvatar.target.dataLeaf.auras)
                           {
                              if(b.nam == i.aura.nam)
                              {
                                 b.ts = i.aura.ts;
                                 this.auras[i.aura.nam] = 1;
                                 this.createIconMC(i.aura.nam,this.auras[i.aura.nam],i.cInf.substring(2) != main.Game.sfc.myUserId);
                                 this.coolDownAct(this.icons[i.aura.nam],i.aura.dur * 1000,b.ts);
                                 break;
                              }
                           }
                        }
                     }
                     else if(i.cmd.indexOf("-") > -1)
                     {
                        this.auras[i.aura.nam] = null;
                     }
                  }
                  this.lastSkill = main.Game.world.actions.active[0];
                  break;
               case "sAct":
                  for(k = 2; k < 6; k++)
                  {
                     if(main.Game.ui.mcInterface.actBar.getChildByName("i" + k))
                     {
                        main.Game.ui.mcInterface.actBar.getChildByName("i" + k).addEventListener(MouseEvent.CLICK,this.actIconClick,false,0,true);
                     }
                  }
                  this.lastSkill = main.Game.world.actions.active[0];
            }
         }
      }
      
      public function coolDownAct(actIcon:*, cd:int = -1, ts:Number = 127) : *
      {
         var icon1:MovieClip = null;
         var j:int = 0;
         var icon2:* = undefined;
         var iMask:MovieClip = null;
         var bmd:* = undefined;
         var bm:* = undefined;
         var k:int = 0;
         var iconF:DisplayObject = null;
         var stackQty:TextField = null;
         var tf:TextFormat = null;
         var ActMask:Class = main.gameDomain.getDefinition("ActMask") as Class;
         var iconCT:ColorTransform = new ColorTransform(0.5,0.5,0.5,1,-50,-50,-50,0);
         icon1 = actIcon;
         icon2 = null;
         iMask = null;
         if(icon1.icon2 == null)
         {
            bmd = new BitmapData(50,50,true,0);
            bmd.draw(icon1,null,iconCT);
            bm = new Bitmap(bmd);
            icon2 = actIcon.addChild(bm);
            icon1.icon2 = icon2;
            icon2.transform = icon1.transform;
            icon2.scaleX = 1;
            icon2.scaleY = 1;
            icon1.ts = ts;
            icon1.cd = cd;
            icon1.auraName = icon1.auraName;
            iMask = actIcon.addChild(new ActMask()) as MovieClip;
            iMask.scaleX = 0.33;
            iMask.scaleY = 0.33;
            iMask.x = int(icon2.x + icon2.width / 2 - iMask.width / 2);
            iMask.y = int(icon2.y + icon2.height / 2 - iMask.height / 2);
            k = 0;
            while(k < 4)
            {
               iMask["e" + k + "oy"] = iMask["e" + k].y;
               k++;
            }
            icon2.mask = iMask;
            stackQty = new TextField();
            tf = new TextFormat();
            tf.size = 12;
            tf.bold = true;
            tf.font = "Arial";
            tf.color = 16777215;
            stackQty.defaultTextFormat = tf;
            icon1.stacks = icon1.addChild(stackQty);
            icon1.stacks.x = 32;
            icon1.stacks.y = 27;
         }
         else
         {
            icon2 = icon1.icon2;
            iMask = icon2.mask;
            icon1.ts = ts;
            icon1.cd = cd;
            icon1.auraName = icon1.auraName;
         }
         icon1.stacks.text = icon1.auraStacks;
         iMask.e0.stop();
         iMask.e1.stop();
         iMask.e2.stop();
         iMask.e3.stop();
         icon1.removeEventListener(Event.ENTER_FRAME,this.countDownAct);
         icon1.addEventListener(Event.ENTER_FRAME,this.countDownAct,false,0,true);
         this.rearrangeIconMC();
      }
      
      public function countDownAct(e:Event) : void
      {
         var dat:* = undefined;
         var ti:* = undefined;
         var ct1:* = undefined;
         var ct2:* = undefined;
         var cd:* = undefined;
         var tp:* = undefined;
         var mc:* = undefined;
         var fr:* = undefined;
         var i:* = undefined;
         var iMask:* = undefined;
         if(!main.Game.world.myAvatar.target)
         {
            this.auras = new Object();
            this.clearMCs();
            return;
         }
         dat = new Date();
         ti = dat.getTime();
         ct1 = MovieClip(e.target);
         ct2 = ct1.icon2;
         cd = ct1.cd + 350;
         tp = (ti - ct1.ts) / cd;
         mc = Math.floor(tp * 4);
         fr = int(tp * 360 % 90) + 1;
         if(this.auras[ct1.auraName] == null)
         {
            tp = 1;
         }
         if(tp < 0.99)
         {
            i = 0;
            while(i < 4)
            {
               if(i < mc)
               {
                  ct2.mask["e" + i].y = -300;
               }
               else
               {
                  ct2.mask["e" + i].y = ct2.mask["e" + i + "oy"];
                  if(i > mc)
                  {
                     ct2.mask["e" + i].gotoAndStop(0);
                  }
               }
               i++;
            }
            MovieClip(ct2.mask["e" + mc]).gotoAndStop(fr);
         }
         else
         {
            try
            {
               iMask = ct2.mask;
               ct2.mask = null;
               ct2.parent.removeChild(iMask);
               ct1.removeEventListener(Event.ENTER_FRAME,this.countDownAct);
               main.Game.ui.mcPortraitTarget.getChildByName("auraUI").stopDrag();
               this.toolTip.close();
               ct2.parent.removeChild(ct2);
               ct2.bitmapData.dispose();
               ct1.icon2 = null;
               main.Game.ui.mcPortraitTarget.getChildByName("auraUI").removeChild(this.icons[ct1.auraName]);
               this.iconPriority.splice(this.iconPriority.indexOf(ct1.auraName),1);
               delete this.icons[ct1.auraName];
               this.rearrangeIconMC();
            }
            catch(exception:*)
            {
               trace("Skills Target UI Error: " + exception);
            }
         }
      }
      
      private function onHold(e:MouseEvent) : void
      {
         main.Game.ui.mcPortraitTarget.getChildByName("auraUI").startDrag();
      }
      
      private function onMouseRelease(e:MouseEvent) : void
      {
         main.Game.ui.mcPortraitTarget.getChildByName("auraUI").stopDrag();
      }
   }
}
