package imobile.controller {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import imobile.model.Lesson;
	
	public class LessonManager extends EventDispatcher{
		public static const LESSONS_READY:String = "READY";
		static private var _instance:LessonManager;
		
		private var XMLFile:String = "lessons.xml";
		private var _menuList:Array;
		
		public function LessonManager(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():LessonManager {
			if(LessonManager._instance == null) {
				LessonManager._instance = new LessonManager(new SingletonEnforcer());
			}
			return LessonManager._instance;
		}
		
		public function loadLessons():void {
			_menuList = new Array();
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadedMenu, false, 0, true);
			loader.load(new URLRequest(XMLFile));
		}
		
		private function onLoadedMenu(e:Event):void {
			XML.ignoreWhitespace = true;
			var xml:XML = new XML(e.target.data);
			parseLessons(xml.children());
		}
		
		private function parseLessons(xml:XMLList):void {
			var i:int;
			for(i=0;i<xml.length(); i++) {
				var lesson:Lesson = new Lesson();
				lesson.setID(Number(xml[i].@id.toString()));
				lesson.setLabel(xml[i].@title.toString());
				lesson.setShowFile(xml[i].@show.toString());
				lesson.setGuideFile(xml[i].@guide.toString());
				lesson.setExploreFile(xml[i].@explore.toString());
				_menuList.push(lesson);
			}
			dispatchEvent(new Event(LessonManager.LESSONS_READY));
		}
		
		public function lessonsList():Array {
			return _menuList;
		}
	}
}

class SingletonEnforcer{}
