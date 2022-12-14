package imobile.sessions.controller
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class ApplicationController extends EventDispatcher
	{
		public static const TIMER_DONE:String = "timer_done";
		static private var _instance:ApplicationController;
		private var _app:Object;
		private var _custom:Object;
		private var _timer:Timer;
		
		public function ApplicationController(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():ApplicationController 
		{
			if(ApplicationController._instance == null) 
			{
				ApplicationController._instance = new ApplicationController(new SingletonEnforcer());
			}
			return ApplicationController._instance;
		}
		
		public function registerApplication(param:Object):void
		{
			_app = param;
			_app.addEventListener("click", checkUserInput, false, 0, true);
		}
		
		public function registerCustom(param:Object):void
		{
			_custom = param;
			_custom.addEventListener("click", customClick, false, 0, true);
		}
		
		public function unRegisterCustom():void
		{
			try
			{
				_custom.removeEventListener("click", customClick);
			}catch(e:*) {}
		}
		
		private function customClick(e:Event):void
		{
			checkUserInput(e);
		}
		
		private function checkUserInput(e:Event):void
		{
			// IF THE TARGET DOESN'T HAVE A TYPE IT'S NOT A BUTTON I WANT TO LISTEN FOR
			try
			{
				e.target.TYPE;
			}catch(e:ReferenceError) { return; }
			
			if(e.target.ENABLED)
			{
				manageScreens(e.target);
			}
		}
		
		public function manageScreens(t:Object)
		{
			switch(t.TYPE)
			{
				case "START":
					_app.toggleStartMenu(t.STATE);
					break;
				case "HIDE_SHOW":
					_app.toggleMap(t.STATE);
					break;
				case "START_APP":
				case "MB_IM":
					_app.changeScreen("i-mobile");
					break;
				case "MB_CC":
					_app.changeScreen("complex_cards");
					break;
				case "NIGHT":
					_app.toggleNight(t.STATE);
					break;
			}
			dispatchEvent(new Event(t.TYPE));
		}
		
		public function enableButtons(param:Array):void
		{
			_app.enableButtons(param);
		}
		
		public function disableAllButtons():void
		{
			_app.disableAllButtons();
		}
		
		private function timerDone(e:TimerEvent):void
		{
			_timer.removeEventListener("timer", timerDone);
			dispatchEvent(new Event(ApplicationController.TIMER_DONE));
		}
		
		public function setTimer(seconds:int):void
		{
			_timer = new Timer(seconds * 1000, 1);
			_timer.addEventListener("timer", timerDone, false, 0, true);
			_timer.start();
		}
	}
}

class SingletonEnforcer{}
