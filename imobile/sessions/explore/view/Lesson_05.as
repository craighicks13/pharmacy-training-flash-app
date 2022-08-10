﻿package imobile.sessions.guide.view {	import fl.events.ScrollEvent;	import fl.controls.ScrollBarDirection;	import imobile.sessions.guide.view.LessonBase;	import imobile.sessions.controller.ApplicationController;	import imobile.sessions.controller.DrawSelectBox;    import flash.text.TextField;    import flash.text.TextFieldType;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.ui.Mouse;		public class Lesson_05 extends LessonBase	{		private var _popup1:MovieClip;		private var _popup2:MovieClip;				public function Lesson_05()	{ getInstance(); }				public override function updateAppStatus():void		{			/* 	CHANGING THE APPLICATION STATE TO THE PROPER 			*   _application.resetState(			*							changeScreen:String="i-mobile", 	// i-mobile, complex_cards, blank			*							showMap:Boolean=false,				// true, false			*							changeStatus:String="available",	// available, enroute, dispatched, arrive, avstation			*							changeStatusNumbers:String="0",		// 0, 1, 2 			*							mainWindow:String="",				//			*							dispatchReportWindow:String="",		//			*							eventListWindow:String=""			//			*						   )			*/			//removeScrollDownListener();			getCurrentFunctionality();		}				public override function getCurrentFunctionality():void		{			trace("LESSON 5 CURRENT FRAME: " + String(currentFrame + (_step/10)));			if(_multiSteps == _step) _multiSteps = 0;			ApplicationController.getInstance().disableAllButtons();			switch(currentFrame + (_step/10))			{				case 1:					bubbles.gotoAndStop(2);					_application.visible = false;					//ApplicationController.getInstance().registerCustom(route_tab_clip);					//setInteractListener("ROUTE_TAB");					break;				case 2:					_multiSteps = 2;					//PICK_ROUTE.addEventListener("click", pickRouteProceed, false, 0, true);					//PICK_ROUTE.enable();					break;				case 2.1:					bubbles.gotoAndStop(2);					_popup1 = new active_route();					_popup1.x = 515;					_popup1.y = 380;					addChildAt(_popup1,2);					_popup1['NEW'].addEventListener("click", pop1proceed, false, 0, true);					break;				case 2.2:					bubbles.gotoAndStop(3);					_popup2 = new route_name();					_popup2.x = 555;					_popup2.y = 350;					addChildAt(_popup2,3);					_popup2['OK'].addEventListener("click", pop2proceed, false, 0, true);					break;				case 3:					//GREEN_FLAG.addEventListener("click", proceed, false, 0, true);					break;				case 4:					_multiSteps = 1;					//location_tf.addEventListener("change", checkLocationString, false, 0, true);					break;				case 4.1:					bubbles.gotoAndStop(2);					//loc_popup['OK'].addEventListener("click", loc_proceed, false, 0, true);					break;				case 5:					ApplicationController.getInstance().setTimer(5);					setInteractListener(ApplicationController.TIMER_DONE);					break;				case 6:					//RED_FLAG.addEventListener("click", proceed, false, 0, true);					break;				case 7:					_multiSteps = 1;					//location_red_tf.addEventListener("change", checkLocationRedString, false, 0, true);					break;				case 7.1:					bubbles.gotoAndStop(2);					//loc_popup['OK'].addEventListener("click", loc_proceed, false, 0, true);					break;				case 8:					_multiSteps = 1;					//verifyName.verifyWindow.content.VERIFY_PLACE.addEventListener("click", proceed, false, 0, true);					break;				case 8.1:					bubbles.gotoAndStop(2);					//verifyName.verifyWindow.content.VERIFY_PLACE.removeEventListener("click", proceed);					//verifyName.nameMask.visible = false;					//verifyName['OK'].addEventListener("click", vn_proceed, false, 0, true);					break;				case 9:					ApplicationController.getInstance().setTimer(6);					setInteractListener(ApplicationController.TIMER_DONE);					break;				case 10:					//ROUTE.addEventListener(MouseEvent.MOUSE_DOWN, routeSelected, false, 0, true);					break;				case 11:					//FIT_ROUTE.addEventListener(MouseEvent.MOUSE_DOWN, fitRouteSelected, false, 0, true);					break;				case 12:					ApplicationController.getInstance().setTimer(8);					setInteractListener(ApplicationController.TIMER_DONE);					break;							}		}				public override function setStageListeners():void		{			switch(currentFrame + (_step/10))			{				case 1:					ApplicationController.getInstance().registerCustom(route_tab_clip);					setInteractListener("ROUTE_TAB");					break;				case 2:					PICK_ROUTE.addEventListener("click", pickRouteProceed, false, 0, true);					PICK_ROUTE.enable();					break;				case 3:					GREEN_FLAG.addEventListener("click", proceed, false, 0, true);					break;				case 4:					location_tf.addEventListener("change", checkLocationString, false, 0, true);					break;				case 4.1:					loc_popup['OK'].addEventListener("click", loc_proceed, false, 0, true);					break;				case 6:					RED_FLAG.addEventListener("click", proceed, false, 0, true);					break;				case 7:					location_red_tf.addEventListener("change", checkLocationRedString, false, 0, true);					break;				case 7.1:					loc_popup['OK'].addEventListener("click", loc_proceed, false, 0, true);					break;				case 8:					verifyName.verifyWindow.content.VERIFY_PLACE.addEventListener("click", proceed, false, 0, true);					break;				case 8.1:					verifyName.verifyWindow.content.VERIFY_PLACE.removeEventListener("click", proceed);					verifyName.nameMask.visible = false;					verifyName['OK'].addEventListener("click", vn_proceed, false, 0, true);					break;				case 10:					ROUTE.addEventListener(MouseEvent.MOUSE_DOWN, routeSelected, false, 0, true);					break;				case 11:					FIT_ROUTE.addEventListener(MouseEvent.MOUSE_DOWN, fitRouteSelected, false, 0, true);					break;							}		}				private function routeSelected(e:MouseEvent):void		{			ROUTE.removeEventListener(MouseEvent.MOUSE_DOWN, routeSelected);			proceed(e);		}				private function fitRouteSelected(e:MouseEvent):void		{			FIT_ROUTE.removeEventListener(MouseEvent.MOUSE_DOWN, fitRouteSelected);			proceed(e);		}				private function pickRouteProceed(e:Event):void		{			PICK_ROUTE.removeEventListener("click", pickRouteProceed);			PICK_ROUTE.disable();			proceed(e);		}				private function pop1proceed(e:Event):void		{			_popup1['NEW'].removeEventListener("click", pop1proceed);			proceed(e);		}				private function pop2proceed(e:Event):void		{			_popup2['OK'].removeEventListener("click", pop2proceed);			removeChild(_popup1);			removeChild(_popup2);			proceed(e);		}				private function vn_proceed(e:Event):void		{			verifyName['OK'].removeEventListener("click", vn_proceed);			proceed(e);		}				private function loc_proceed(e:Event):void		{			loc_popup['OK'].removeEventListener("click", loc_proceed);			proceed(e);		}				private function checkLocationString(e:Event):void		{			if(location_tf.text == "@12")			{				location_tf.type = TextFieldType.DYNAMIC;				location_tf.removeEventListener("change", checkLocationString);				proceed(e);			}		}				private function checkLocationRedString(e:Event):void		{			location_red_tf.text = location_red_tf.text.toUpperCase();			if(location_red_tf.text == "@WEM%")			{				location_red_tf.type = TextFieldType.DYNAMIC;				location_red_tf.removeEventListener("change", checkLocationRedString);				proceed(e);			}		}	}}