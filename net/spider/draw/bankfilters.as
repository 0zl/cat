package net.spider.draw
{
   import Game_fla.chkBox_32;
   import Game_fla.searchBtn_664;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.spider.main;
   
   public class bankfilters extends MovieClip
   {
       
      
      public var btnFilter:searchBtn_664;
      
      public var chkLegend:chkBox_32;
      
      public var chkRarity:chkBox_32;
      
      public var chkGold:chkBox_32;
      
      public var chkFree:chkBox_32;
      
      public var chkAC:chkBox_32;
      
      public function bankfilters()
      {
         super();
         this.chkAC.checkmark.visible = false;
         this.chkGold.checkmark.visible = false;
         this.chkLegend.checkmark.visible = false;
         this.chkFree.checkmark.visible = false;
         this.chkRarity.checkmark.visible = false;
         this.chkAC.addEventListener(MouseEvent.CLICK,this.onChkChange,false,0,true);
         this.chkGold.addEventListener(MouseEvent.CLICK,this.onChkChange,false,0,true);
         this.chkLegend.addEventListener(MouseEvent.CLICK,this.onChkChange,false,0,true);
         this.chkFree.addEventListener(MouseEvent.CLICK,this.onChkChange,false,0,true);
         this.chkRarity.addEventListener(MouseEvent.CLICK,this.onChkChange,false,0,true);
         this.btnFilter.addEventListener(MouseEvent.CLICK,this.onBtnFilter,false,0,true);
      }
      
      public function onChkChange(e:MouseEvent) : void
      {
         e.currentTarget.checkmark.visible = !e.currentTarget.checkmark.visible;
         switch(e.currentTarget.name)
         {
            case "chkAC":
               if(e.currentTarget.checkmark.visible)
               {
                  this.chkGold.checkmark.visible = false;
               }
               break;
            case "chkGold":
               if(e.currentTarget.checkmark.visible)
               {
                  this.chkAC.checkmark.visible = false;
               }
               break;
            case "chkLegend":
               if(e.currentTarget.checkmark.visible)
               {
                  this.chkFree.checkmark.visible = false;
               }
               break;
            case "chkFree":
               if(e.currentTarget.checkmark.visible)
               {
                  this.chkLegend.checkmark.visible = false;
               }
         }
      }
      
      public function onFilter(bank:*, index:int, arr:Array) : Boolean
      {
         var filter_result:* = false;
         if(this.chkAC.checkmark.visible)
         {
            filter_result = bank.bCoins == 1;
            if(this.chkLegend.checkmark.visible)
            {
               filter_result = Boolean(filter_result && bank.bUpg == 1);
            }
            if(this.chkFree.checkmark.visible)
            {
               filter_result = Boolean(filter_result && bank.bUpg == 0);
            }
         }
         else if(this.chkGold.checkmark.visible)
         {
            filter_result = bank.bCoins == 0;
            if(this.chkLegend.checkmark.visible)
            {
               filter_result = Boolean(filter_result && bank.bUpg == 1);
            }
            if(this.chkFree.checkmark.visible)
            {
               filter_result = Boolean(filter_result && bank.bUpg == 0);
            }
         }
         else
         {
            if(this.chkLegend.checkmark.visible)
            {
               filter_result = bank.bUpg == 1;
            }
            if(this.chkFree.checkmark.visible)
            {
               filter_result = bank.bUpg == 0;
            }
         }
         if(this.chkRarity.checkmark.visible)
         {
            filter_result = bank.iRty == 30;
         }
         if(!this.chkAC.checkmark.visible && !this.chkGold.checkmark.visible && !this.chkLegend.checkmark.visible && !this.chkFree.checkmark.visible && !this.chkRarity.checkmark.visible)
         {
            filter_result = true;
         }
         return filter_result;
      }
      
      public function onBtnFilter(e:MouseEvent) : void
      {
         var mcFocus:MovieClip = MovieClip(main.Game.ui.mcPopup.getChildByName("mcBank")).bankPanel.frames[1].mc;
         mcFocus.fOpen({
            "fData":{
               "list":main.Game.world.bankinfo.items.filter(this.onFilter),
               "itemsB":main.Game.world.bankinfo.items,
               "itemsI":main.Game.world.myAvatar.items,
               "objData":main.Game.world.myAvatar.objData,
               "isBank":true
            },
            "r":{
               "x":21,
               "y":46,
               "w":265,
               "h":304
            },
            "sMode":"bank",
            "refreshTabs":true
         });
      }
   }
}
