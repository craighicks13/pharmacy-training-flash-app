package imobile.controller 
{
	import flash.display.MovieClip;
	import imobile.controller.LessonLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	
	public class LessonsController extends EventDispatcher
	{
		private var _lessonSelected:Object;
		private var _clip:MovieClip;
		private var _clipLength:int;
		static private var _instance:LessonsController;
		static public var LESSON_TYPE:String = "show";
		static public var PLAY_STATUS:String = "stop";
		static public var LESSON_LOAD:String = "lesson_load";
		static public var LESSON_LOADED:String = "lesson_loaded";
		static public var LESSON_ERROR:String = "lesson_error";
		static public var LESSON_UNLOADED:String = "lesson_unloaded";
		static public var REMOVE_LESSON:String = "remove_lesson";
		static public var UPDATE_POSITION:String = "update_position";
		
		public function LessonsController(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():LessonsController 
		{
			if(LessonsController._instance == null) 
			{
				LessonsController._instance = new LessonsController(new SingletonEnforcer());
			}
			return LessonsController._instance;
		}
		
		public function unloadLesson():void 
		{
			LessonLoader.getInstance().addEventListener(LessonLoader.UNLOADED, lessonUnloaded, false, 0, true);	
			LessonLoader.getInstance().unloadLesson();		
		}
		
		function stopMovieClip(e:Event):void{
			SoundMixer.stopAll();
			if(_clip){
				_clip.gotoAndStop(1);
				_clip.visible = false;
			}
		}

		public function getLesson(param:Object):void
		{
			_lessonSelected = param;
			// CHANGE THE PLAY TYPE TO 'SHOW' BECAUSE EVERY SECTION DISPLAYS 'SHOW' FIRST WHEN SELECTED
			changeType("show");
		}
		
		private function sendRemoveLesson():void
		{
			dispatchEvent(new Event(LessonsController.REMOVE_LESSON));
		}
		
		public function loadLesson():void 
		{
			var load_file:String;
			switch(LessonsController.LESSON_TYPE)
			{
				case "explore":
					load_file = _lessonSelected.fileExplore;
					break;
				case "guide":
					load_file = _lessonSelected.fileGuide;
					break;
				case "show":
					load_file = _lessonSelected.fileShow;
					break;
				default:
					load_file = "file not found";
			}
			addLoadEventListeners();
			LessonLoader.getInstance().loadLesson(load_file);
			dispatchEvent(new Event(LessonsController.LESSON_LOAD));
		}
		
		private function lessonLoaded(e:Event):void 
		{
			removeLoadEventListeners();
			_clip = MovieClip(LessonLoader.getInstance().lesson.content);
			_clip.addEventListener(Event.REMOVED_FROM_STAGE,stopMovieClip, false, 0, true);
			getClipLength();
			dispatchEvent(new Event(LessonsController.LESSON_LOADED));
		}
		
		private function loadError(e:Event):void
		{
			removeLoadEventListeners();
			dispatchEvent(new Event(LessonsController.LESSON_ERROR));
		}
		
		private function removeLoadEventListeners():void
		{
			LessonLoader.getInstance().removeEventListener(LessonLoader.LOADED, lessonLoaded);
			LessonLoader.getInstance().removeEventListener(LessonLoader.LOAD_ERROR, loadError);
			
		}
		
		private function addLoadEventListeners():void
		{
			LessonLoader.getInstance().addEventListener(LessonLoader.LOADED, lessonLoaded, false, 0, true);
			LessonLoader.getInstance().addEventListener(LessonLoader.LOAD_ERROR, loadError, false, 0, true);
			
		}
		
		private function getClipLength():void
		{
			_clipLength = _clip ? _clip.totalFrames : 0;
		}
		
		private function lessonUnloaded(e:Event):void 
		{
			LessonLoader.getInstance().removeEventListener(LessonLoader.UNLOADED, lessonUnloaded);
			_clip = null;
			_clip.removeEventListener(Event.REMOVED_FROM_STAGE,stopMovieClip);
			getClipLength();
			dispatchEvent(new Event(LessonsController.LESSON_UNLOADED));
		}
		
		public function get clip():MovieClip 
		{
			return _clip;
		}
		
		public function stop():void 
		{
			LessonsController.PLAY_STATUS = "stop";
			_clip.stop();
		}
		
		public function pause():void 
		{
			_clip.stop();
		}
		
		public function play():void 
		{
			LessonsController.PLAY_STATUS = "play";
			_clip.play();
		}
		
		public function updatePos(percent:Number):void
		{
			if(LessonsController.PLAY_STATUS == "stop")
				_clip.gotoAndStop(Math.round(clipLength * percent));
			else
				_clip.gotoAndPlay(Math.round(clipLength * percent));
			dispatchEvent(new Event(LessonsController.UPDATE_POSITION));
		}
		
		public function rewind():void 
		{
			if(LessonsController.PLAY_STATUS == "play")
				_clip.gotoAndPlay(1);
			else
				_clip.gotoAndStop(1);
		}
		
		public function get clipLength():int
		{
			return _clipLength;
		}
		
		public function get percentPlayed()
		{
			// ROUNDED TO THE WHOLE PERCENT TO CLEAN UP SOME RANDOM MATH RESULTS
			var percent:Number = Math.round(_clip.currentFrame / clipLength * 100) / 100; 
			return percent.toFixed(2);
		}
		
		public function changeType(param:String):void
		{
			LessonsController.LESSON_TYPE = param;
			sendRemoveLesson();
		}
		
	}
}

class SingletonEnforcer{}
