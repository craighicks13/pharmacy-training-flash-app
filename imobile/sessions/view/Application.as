package imobile.sessions.view
{
	import flash.display.MovieClip;
	import fl.managers.StyleManager;
	import flash.events.Event;
	import imobile.sessions.controller.ApplicationController;
	
	public class Application extends MovieClip
	{
		public static const INFORMATION:String = "info";
		public static const MAP:String = "map";
		public static const COMPLEX_CARDS:String = "cc";
		public static const BLANK_SCREEN:String = "blank";
		public static const NIGHT:String = "night";
		
		private var _showMap:Boolean = false;
		private var _infoWinList:Array;
		private var _interfaceButtons:Array;
		private var _menuBarButtons:Array;
		private var _popup:MovieClip;
		
		public function Application() 
		{ 
			stop();
			// SET THE SCROLLBAR SIZE TO MATCH THE APP INTERFACE
			StyleManager.setStyle("scrollBarWidth", 30);
			StyleManager.setStyle("scrollArrowHeight", 30);
			// REGISTER THE FLA WITH THE CONTROLLER
			ApplicationController.getInstance().registerApplication(this);
			// SET THE SCROLLPANE LIST FOR THE INFORMATION VIEW
			_infoWinList = [mainWindow,dispatchReportWindow,eventListWindow];
			// COMMENTED OUT THE BUTTONS THAT ARE IN THE MENU BUT NOT YET CREATED IN THE FLA
			_interfaceButtons = [
									 "HIDE_SHOW",
									 "ENR",
									 "ARR",
									 "TRN",
									 "TRA",
									 "SBY",
									 "CLR",
									 "AVL",
									 "MOV",
									 "LOC",
									 "STN",
									 "RECALL",
									 "MSG",
									 "SND",
									 "E",
									 "ON",
									 "OFF",
									 "CHAT",
									 "NIGHT",
									 "LAST_FORM"
								];
			_menuBarButtons = 	[
									"MB_IM",
									"MB_CC",
									"START"
								];
			toggleStartMenu(false);
		}
		
		public function disableAllButtons():void
		{
			disableAllInterfaceButtons();
			disableMenuBarButtons();
			disableMessageArea();
		}
		
		public function disableMessageArea():void
		{
			try
			{
				eventListWindow.content.disable();
				dispatchReportWindow.content.disable();
			}catch(e:*) {}
		}
		
		public function disableMenuBarButtons():void
		{
			var num:int = _menuBarButtons.length;
			while(num-- > 0)
			{
				try {
					this[_menuBarButtons[num]].disable();
				}catch(e:*){}
			}
		}
		
		public function disableAllInterfaceButtons():void
		{
			var num:int = _interfaceButtons.length;
			while(num-- > 0)
			{
				try {
					imobile_interface[_interfaceButtons[num]].disable();
				}catch(e:*){}
			}
		}
		
		public function enableButtons(buttons:Array):void
		{
			var num:int = buttons.length;
			while(num-- > 0)
			{
				buttons[num].enable();
			}
		}
		
		public function disableButtons(buttons:Array):void
		{
			var num:int = buttons.length;
			while(num-- > 0)
			{
				buttons[num].disable();
			}
		}
		
		public function closeStart():void
		{
			START.upState();
			toggleStartMenu(false);
		}
		
		public function changeStatus(s:String):void
		{
			imobile_interface.status_change.gotoAndStop(s);
		}
		
		public function changeStatusNumbers(s:String):void
		{
			imobile_interface.status_numbers.gotoAndStop(s);
		}
		
		public function changeScreen(s:String):void
		{
			closeStart();
			switch(s)
			{
				case "night":
					showNight();
					break;
				case "complex_cards":
					showComplexCards();
					break;
				case "i-mobile":
					toggleMap(_showMap);
					break;
				case "blank":
					showBlankScreen();
					break;
			}
		}
		
		public function toggleMap(map:Boolean):void
		{
			MB_IM.downState();
			MB_CC.upState();
			showInterfaceButtons(true);
			if(map)	showMap(); else	showInfo();
		}
		
		public function toggleStartMenu(sm:Boolean):void
		{
			start_menu.visible = sm;
		}
		
		public function toggleNight(n:Boolean):void
		{
			showInterfaceButtons(true);
			if(n) showNight(); else toggleMap(_showMap);
		}
		
		public function newTransportUnitPopup():MovieClip
		{
			_popup = new TRANSPORT_UNIT();
			_popup.x = 513;
			_popup.y = 385;
			addChild(_popup);
			return _popup;
		}
		
		public function newConfirmEmergencyPopup():MovieClip
		{
			_popup = new CONFIRM_EMERGENCY();
			_popup.x = 540;
			_popup.y = 360;
			addChild(_popup);
			return _popup;
		}
		
		public function newEventPopup():MovieClip
		{
			_popup = new NEW_EVENT();
			_popup.x = 155;
			_popup.y = 155;
			addChild(_popup);
			return _popup;
		}
		
		public function removePopup():void
		{
			try
			{
				removeChild(_popup);
			}catch(e:*) {}
		}
		
		private function showMap():void
		{
			gotoAndStop(Application.MAP);
			showInfoWindows(false);
			imobile_interface.HIDE_SHOW.downState();
			_showMap = true;
		}
		
		private function showInfo():void
		{
			gotoAndStop(Application.INFORMATION);
			showInfoWindows(true);
			imobile_interface.HIDE_SHOW.upState();
			_showMap = false;
		}
		
		private function showNight():void
		{
			gotoAndStop(Application.NIGHT);
			showInterfaceButtons(false, false, false, true);
			showInfoWindows(false);
		}
		
		private function showComplexCards():void
		{
			gotoAndStop(Application.COMPLEX_CARDS);
			showInterfaceButtons(false);
			MB_IM.upState();
			MB_CC.downState();
			showInfoWindows(false);
		}
		
		private function showBlankScreen():void
		{
			gotoAndStop(Application.BLANK_SCREEN);
			showInterfaceButtons(false, false);
			showInfoWindows(false);
		}
		
		private function showInterfaceButtons(main:Boolean, menuBar:Boolean = true, menuStart:Boolean = true, intAlpha:Boolean = false):void
		{
			if(intAlpha)
				imobile_interface.alpha = 0;
			else {
				imobile_interface.alpha = 1;
				imobile_interface.visible = main;
			}
			MB_CC.visible = menuBar;
			MB_IM.visible = menuBar;
			START.visible = menuStart;
		}
		
		private function showInfoWindows(param:Boolean):void
		{
			var num:int = _infoWinList.length;
			while(num-- > 0)
			{
				_infoWinList[num].visible = param;
			}
		}
		
		public function addMainWindowItem(mc:Object):void
		{
			mainWindow.source = mc;
			mainWindow.content.setObjectName = "MAIN_CONTENT";
		}
		
		public function addDispatchReportItem(mc:Object):void
		{
			dispatchReportWindow.source = mc;
			dispatchReportWindow.content.setObjectName = "DISPATCH_CONTENT";
			dispatchReportWindow.content.disable();
		}
		
		public function addEventListItem(mc:Object):void
		{
			eventListWindow.source = mc;
			eventListWindow.content.setObjectName = "EVENT_CONTENT";
			eventListWindow.content.disable();
		}
		
		public function addMapWindowItem(mc:Object):void
		{
			mapWindow.source = mc;
			mapWindow.content.setObjectName = "MAP_CONTENT";			
			mapWindow.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
		}
		
		private function completeHandler(e:Event):void
		{
			mapWindow.removeEventListener(Event.COMPLETE, completeHandler);
			mapWindow.update();
			trace("content load complete: " + e.target);
		}
		
		public function resetState(cs:String="i-mobile",sm:Boolean=false,cst:String="available",cstn:String="0",mw:String="",drw:String="",elw:String="")
		{
			mainWindow.source = mw;
			dispatchReportWindow.source = drw;
			eventListWindow.source = elw;
			_showMap = sm;
			changeScreen(cs);
			changeStatus(cst);
			changeStatusNumbers(cstn);
			removePopup();
		}
		
	}
	
}
