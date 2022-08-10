package imobile.sessions.controller
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;
	import fl.events.ScrollEvent;
	import fl.controls.ScrollBarDirection;
	
	import imobile.sessions.view.ZoneDropDown;
	
	public class InteractionController extends MovieClip
	{
		public static const TIMER_DONE:String = "timer_done";
		public static const TRIGGERED:String = "triggered";
		static private var _instance:InteractionController;
		
		private var _trigger:MovieClip;
		private var _timer:Timer;
		private var _childTrigger:String;
		private var _scrollDirection:String;
		
		public function InteractionController(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():InteractionController 
		{
			if(InteractionController._instance == null) 
			{
				InteractionController._instance = new InteractionController(new SingletonEnforcer());
			}
			return InteractionController._instance;
		}
		
		public function addTriggerClip(linkage:String, xpos:int, ypos:int, listenFor:String, matchString:String = undefined):void
		{
			removeTrigger();
			
			_childTrigger = listenFor;
			var TriggerClass:Class = getDefinitionByName(linkage) as Class;
			_trigger = new TriggerClass();
			_trigger.x = xpos;
			_trigger.y = ypos;
			if(matchString) _trigger.matchString = matchString;
			_trigger.addEventListener(_childTrigger, clipTriggered, false, 0, true);
			addChild(_trigger);
		}
		
		public function updateTriggerClip(listenFor:String):void
		{
			_childTrigger = listenFor;
			_trigger.addEventListener(_childTrigger, clipTriggered, false, 0, true);
		}
		
		public function setTriggerSize(w:int, h:int):void
		{
			_trigger.width = w;
			_trigger.height = h;
		}
		
		private function clipTriggered(e:Event):void
		{
			_trigger.removeEventListener(_childTrigger, clipTriggered);
			hitTrigger(e);
		}
		
		public function addDropDownTrigger(dropDownType:String, xpos:int, ypos:int, mustSelect:uint = undefined):void
		{
			removeTrigger();
			
			_trigger = new ZoneDropDown(dropDownType);
			_trigger.x = xpos;
			_trigger.y = ypos;
			if(mustSelect) _trigger.mustSelect = mustSelect;
			_trigger.addEventListener("zone_selected", zoneTriggered, false, 0, true);
			addChild(_trigger);
		}
		
		private function zoneTriggered(e:Event):void
		{
			_trigger.removeEventListener("zone_selected", zoneTriggered);
			hitTrigger(e);
		}
		
		public function addScrollTrigger(linkage:String, xpos:int, ypos:int, childTrigger:String):void
		{
			removeTrigger();
			
			_childTrigger = childTrigger;
			var TriggerClass:Class = getDefinitionByName(linkage) as Class;
			_trigger = new TriggerClass();
			_trigger.x = xpos;
			_trigger.y = ypos;
			addEventListener(Event.ADDED, scrollClipCreated, false, 0, true);
			addChild(_trigger);
		}
		
		private function scrollClipCreated(e:Event):void
		{
			removeEventListener(Event.ADDED, scrollClipCreated);
			setScrollTriggerDirection();
		}
		
		private function createScrollChildListener():void
		{
			_trigger[_childTrigger].addEventListener(ScrollEvent.SCROLL, scrollHandler, false, 0, true);
		}
		
		public function setScrollTriggerDirection(dir:String = undefined):void
		{
			_scrollDirection = dir ? ScrollBarDirection.HORIZONTAL : ScrollBarDirection.VERTICAL;
			createScrollChildListener();
		}
			
		public function addPopUpTrigger(linkage:String, xpos:int, ypos:int, childTrigger:String, matchString:String = undefined):void
		{
			removeTrigger();
			
			_childTrigger = childTrigger;			
			var TriggerClass:Class = getDefinitionByName(linkage) as Class;
			_trigger = new TriggerClass();
			_trigger.x = xpos;
			_trigger.y = ypos;
			addEventListener(Event.ADDED, createChildListener, false, 0, true);
			addChild(_trigger);
		}
		
		private function createChildListener(e:Event):void
		{
			removeEventListener(Event.ADDED, createChildListener);
			_trigger[_childTrigger].addEventListener(MouseEvent.CLICK, hitTrigger, false, 0, true);
		}
		
		public function updateTrigger(childTrigger:String):void
		{
			_childTrigger = childTrigger;
			_trigger[_childTrigger].addEventListener(MouseEvent.CLICK, hitTrigger, false, 0, true);
		}
			
		public function addTrigger(linkage:String, xpos:int, ypos:int, toggleButton:Boolean = false, toggleUpState = true):void
		{
			removeTrigger();
			
			var TriggerClass:Class = getDefinitionByName(linkage) as Class;
			_trigger = new TriggerClass();
			_trigger.x = xpos;
			_trigger.y = ypos;
			addChild(_trigger);
			
			if(!toggleUpState) _trigger.downState();
			
			if(toggleButton)
			{
				_trigger.addEventListener(MouseEvent.MOUSE_DOWN, hitTrigger, false, 0, true);
			}
			else
			{
				_trigger.addEventListener(MouseEvent.CLICK, hitTrigger, false, 0, true);
			}
		}
		
		public function clearTriggers():void
		{
			removeTrigger();
		}
		
		private function hitTrigger(e:*)
		{
			trace(e);
			dispatchEvent(new Event(InteractionController.TRIGGERED));
		}
		
		private function removeTrigger():void
		{
			try
			{
				removeChild(_trigger);
			}catch(e:*) { }
			if(_timer && _timer.running) clearTimer();
		}
		
		private function scrollHandler(e:ScrollEvent):void
		{
			if(_scrollDirection == e.direction)
			{
				switch(e.direction)
				{
					case ScrollBarDirection.VERTICAL:
						scrollVertical(e);
						break;
					case ScrollBarDirection.HORIZONTAL:
						scrollHorizontal(e);
						break;
				}
			}
		}
		
		private function scrollHorizontal(e:ScrollEvent):void
		{
			 if(e.position >= e.currentTarget.maxHorizontalScrollPosition)
			 {
				 scrollTrigger(e);
			 }			
		}
		
		private function scrollVertical(e:ScrollEvent):void
		{
			 if(e.position >= e.currentTarget.maxVerticalScrollPosition)
			 {
				 scrollTrigger(e);
			 }
		}
		
		private function scrollTrigger(e:ScrollEvent):void
		{
			removeScrollListener(e);
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			hitTrigger(e);			
		}
		
		private function removeScrollListener(e:ScrollEvent):void
		{
			try
			{
				e.currentTarget.removeEventListener(ScrollEvent.SCROLL, scrollHandler);
			}catch(e:*) { trace(e); }
		}
		
		private function timerDone(e:TimerEvent):void
		{
			clearTimer();
			hitTrigger(e);
		}
		
		private function clearTimer():void
		{
			trace("CLEARING TIMER");
			_timer.stop();
			_timer.removeEventListener("timer", timerDone);
		}
		
		public function setTimer(seconds:int):void
		{
			_timer = new Timer(seconds * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER, timerDone, false, 0, true);
			_timer.start();
		}
	}
}

class SingletonEnforcer{}
