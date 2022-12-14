package com.criticalfusion.training.player.controllers
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.*;
	
	
	public class LessonLoader extends MovieClip{
		static private var _instance:LessonLoader;
		static public var LOADED:String = "loaded";
		static public var LOAD_ERROR:String = "load_error";
		static public var LOADING_UPDATE:String = "load_update";
		static public var UNLOADED:String = "unloaded";
		
		public var _bytesloaded:int;
		public var _bytestotal:int;
		
		private var _lesson:Loader;
		
		public function LessonLoader(singletonEnforcer:SingletonEnforcer) {
			
		}
		
		public static function get instance():LessonLoader {
			if(LessonLoader._instance == null) {
				LessonLoader._instance = new LessonLoader(new SingletonEnforcer());
			}
			return LessonLoader._instance;
		}
		
		public function loadLesson(lesson:String):void {
			trace("LESSONLOADER:loadLesson -> " + lesson);
			_lesson = new Loader();
            configureListeners(_lesson.contentLoaderInfo);
			_lesson.load(new URLRequest(lesson));
		}
		
		public function unloadLesson():void {
			if(!_lesson) return;
			trace("LESSONLOADER:unloadLesson -> " + _lesson.content);
			_lesson.unload();
		}
		
		public function get lesson():Loader {
			return _lesson;
		}

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
            dispatcher.addEventListener(Event.INIT, initHandler, false, 0, true);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
            dispatcher.addEventListener(Event.OPEN, openHandler, false, 0, true);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler, false, 0, true);
        }

        private function completeHandler(event:Event):void {
			_bytesloaded = undefined;
			_bytestotal = undefined;
			dispatchEvent(new Event(LessonLoader.LOADED));
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event.target.content);
			event.target.content.stop();
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
			dispatchEvent(new Event(LessonLoader.LOAD_ERROR));
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
			_bytesloaded = event.bytesLoaded;
			_bytestotal = event.bytesTotal;
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			dispatchEvent(new Event(LessonLoader.LOADING_UPDATE));
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
			//dispatchEvent(new Event(LessonLoader.UNLOADED));
        }
	}
}
class SingletonEnforcer{}
