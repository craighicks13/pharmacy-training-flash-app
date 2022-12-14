package com.criticalfusion.training.player.controllers
{
	import com.criticalfusion.training.player.events.OpenCategoryEvent;
	import com.criticalfusion.training.player.events.SetTextEvent;
	
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class LessonsController extends EventDispatcher
	{		
		public static const LESSON_LOAD:String = "lesson_load";
		public static const LESSON_LOADED:String = "lesson_loaded";
		public static const LESSON_ERROR:String = "lesson_error";
		public static const LESSON_UNLOADED:String = "lesson_unloaded";
		public static const REMOVE_LESSON:String = "remove_lesson";
		public static const UPDATE_POSITION:String = "update_position";
		public static const CHANGE_STATE:String = "change state";
		public static const CLIP_COMPLETED:String = "clip completed";

		protected static var _instance:LessonsController;
		public static var PLAY_STATUS:String = "stop";
		public static var LESSON_TYPE:String = "show";
		
		protected var _clip:MovieClip;
		protected var _currentScene:int = 0;
		protected var _currentLesson:String;
		protected var setScene:String;
		
		public var percentPlayed:Number;
		
		public function LessonsController(singletonEnforcer:SingletonEnforcer) { }
		
		public static function get instance():LessonsController 
		{
			if(LessonsController._instance == null) LessonsController._instance = new LessonsController(new SingletonEnforcer());
			return LessonsController._instance;
		}
		
		public function unloadLesson():void 
		{
			sendRemoveLesson();
			LessonLoader.instance.addEventListener(LessonLoader.UNLOADED, lessonUnloaded, false, 0, true);	
			LessonLoader.instance.unloadLesson();		
		}
		
		protected function stopMovieClip(e:Event):void
		{
			SoundMixer.stopAll();
			if(_clip)
			{
				_clip.gotoAndStop(1);
				_clip.visible = false;
			}
		}
		
		public function setupLessonScene(file:String, scene:String):void
		{
			if(_currentLesson == file)
			{
				playScene(scene);
			}
			else
			{
				setScene = scene;
				unloadLesson();
				getLesson(file);
			}
		}

		public function getLesson(param:String):void
		{
			_currentLesson = param;
			addLoadEventListeners();
			LessonLoader.instance.loadLesson(_currentLesson);
			dispatchEvent(new Event(LessonsController.LESSON_LOAD));
		}
		
		protected function sendRemoveLesson():void
		{
			dispatchEvent(new Event(LessonsController.REMOVE_LESSON));
		}
		
		protected function lessonLoaded(e:Event):void 
		{
			removeLoadEventListeners();
			_clip = MovieClip(LessonLoader.instance.lesson.content);
			_clip.setItemText = setItemText;
			_clip.pauseMovie = forceStop;
			_clip.resumeMovie = forceResume; 
			_clip.jumpToSection = jumpToSection;
			_clip.launchURL = launchURL;
			_clip.addEventListener(Event.ENTER_FRAME, checkClipComplete, false, 0, true);
			_clip.addEventListener(Event.REMOVED_FROM_STAGE, stopMovieClip, false, 0, true);
			
			if(setScene != null)
			{
				playScene(setScene);
				setScene = null;
			}
			
			dispatchEvent(new Event(LessonsController.LESSON_LOADED));
		}
		
		final protected function checkClipComplete(event:Event):void
		{
			var frameCount:int = 0;
			for each(var s:Scene in _clip.scenes)
			{
				if(s.name == _clip.currentScene.name) break;
				frameCount += s.numFrames;
			}
			percentPlayed = (_clip.currentFrame + frameCount) / length;
			if(percentPlayed >= 1)
			{
				forceStop();
				dispatchEvent(new Event(LessonsController.CLIP_COMPLETED));
			}
		}
		
		protected function loadError(e:Event):void
		{
			removeLoadEventListeners();
			dispatchEvent(new Event(LessonsController.LESSON_ERROR));
		}
		
		protected function removeLoadEventListeners():void
		{
			LessonLoader.instance.removeEventListener(LessonLoader.LOADED, lessonLoaded);
			LessonLoader.instance.removeEventListener(LessonLoader.LOAD_ERROR, loadError);		
		}
		
		protected function addLoadEventListeners():void
		{
			LessonLoader.instance.addEventListener(LessonLoader.LOADED, lessonLoaded, false, 0, true);
			LessonLoader.instance.addEventListener(LessonLoader.LOAD_ERROR, loadError, false, 0, true);
		}
		
		protected function get length():int
		{
			return _clip ? _clip.totalFrames : 0;
		}
		
		protected function lessonUnloaded(e:Event):void 
		{
			LessonLoader.instance.removeEventListener(LessonLoader.UNLOADED, lessonUnloaded);
			_clip = null;
			_clip.removeEventListener(Event.ENTER_FRAME, checkClipComplete);
			_clip.removeEventListener(Event.REMOVED_FROM_STAGE,stopMovieClip);
			dispatchEvent(new Event(LessonsController.LESSON_UNLOADED));
		}
		
		protected function launchURL(value:String):void
		{
			pause();
			navigateToURL(new URLRequest(value));
		}
		
		protected function jumpToSection(file:String, scene:String = null, category_id:String = null):void
		{
			if(category_id != null)
				dispatchEvent(new OpenCategoryEvent(OpenCategoryEvent.OPEN_CATEGORY, category_id));
			setupLessonScene(file, scene);
		}
		
		protected function setItemText(code:String):void
		{
			dispatchEvent(new SetTextEvent(SetTextEvent.SET_TEXT_COMMAND, code));
		}
		
		protected function forceResume():void
		{
			play();
			dispatchEvent(new Event(LessonsController.CHANGE_STATE));
		}
		
		protected function forceStop():void
		{
			stop();
			dispatchEvent(new Event(LessonsController.CHANGE_STATE));
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
		
		public function nextScene():void
		{
			_clip.nextScene();
			if(LessonsController.PLAY_STATUS == "play") _clip.play(); else _clip.stop();
		}
		
		public function prevScene():void
		{
			_clip.prevScene();
			if(LessonsController.PLAY_STATUS == "play") _clip.play(); else _clip.stop();
		}
		
		public function playScene(value:String):void
		{
			_clip.stop();
			SoundMixer.stopAll();
			_clip.gotoAndPlay(1, value);
		}
		
		public function updatePos(percent:Number):void
		{
			var targetFrame:int = Math.round(length * percent);
			var frameCount:int = 0;
			for each(var s:Scene in _clip.scenes)
			{
				frameCount += s.numFrames;
				if(frameCount >= targetFrame)
				{
					_clip.gotoAndStop(s.numFrames - (frameCount - targetFrame), s.name);
					break;
				}
			}
			if(LessonsController.PLAY_STATUS == "play") _clip.play();
			dispatchEvent(new Event(LessonsController.UPDATE_POSITION));
		}
		
		public function rewind():void 
		{
			_clip.gotoAndStop(1);
			if(LessonsController.PLAY_STATUS == "play") _clip.play();
		}
		
		public function get scenes():Array
		{
			return _clip.scenes;
		}
		
		public function get clipLength():int
		{
			return length;
		}
		
		public function get pageStatus():Point
		{
			var status:Point = new Point();
			status.y = _clip.scenes.length;
			var num:uint = 1;
			for(var i:uint = 0; i < status.y; i++)
			{
				if(_clip.currentScene.name == _clip.scenes[i].name) break;
				num++;
			}
			status.x = num;
			return status;
		}
		
		public function changeType(param:String):void
		{
			LessonsController.LESSON_TYPE = param;
			sendRemoveLesson();
		}
		
	}
}

class SingletonEnforcer{}
