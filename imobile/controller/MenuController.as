package imobile.controller {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class MenuController extends EventDispatcher{
		static private var _instance:MenuController;
		public static const GOT_LESSONS:String = "GOT_LESSONS";
		
		private var _lessonsList:Array;
		
		public function MenuController(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():MenuController {
			if(MenuController._instance == null) {
				MenuController._instance = new MenuController(new SingletonEnforcer());
			}
			return MenuController._instance;
		}
		
		public function addMenuItems(mi:Array):void {
			_lessonsList = new Array();
			for(var i:int = 0; i < mi.length; i++) {
				_lessonsList.push(mi[i]);
			}
			dispatchEvent(new Event(MenuController.GOT_LESSONS));
		}
		
		public function getLessons():Array {
			return _lessonsList;
		}
		
	}
}
class SingletonEnforcer{}
