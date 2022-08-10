package imobile.sessions.controller {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.*;
	
	
	public class ApplicationLoader extends MovieClip
	{
		static private var _instance:ApplicationLoader;
		static public var LOADED:String = "loaded";
		static public var LOAD_ERROR:String = "load_error";
		static public var LOADING_UPDATE:String = "load_update";
		static public var UNLOADED:String = "unloaded";
		static private var APP_FILE:String = "imobile_application.swf";
		
		public var _bytesloaded:int;
		public var _bytestotal:int;
		
		private var _application:Loader;
		
		public function ApplicationLoader(singletonEnforcer:SingletonEnforcer) {
			
		}
		
		public static function getInstance():ApplicationLoader {
			if(ApplicationLoader._instance == null) {
				ApplicationLoader._instance = new ApplicationLoader(new SingletonEnforcer());
			}
			return ApplicationLoader._instance;
		}
		
		public function loadApplication():void 
		{
			trace("ApplicationLoader:loadApplicationn -> " + ApplicationLoader.APP_FILE);
			_application = new Loader();
            configureListeners(_application.contentLoaderInfo);
			_application.load(new URLRequest(ApplicationLoader.APP_FILE));
		}
		
		public function unloadApplication():void 
		{
			trace("ApplicationLoader:unloadApplicationn -> " + _application.content);
			//_application.unload();
		}
		
		public function get application():Loader 
		{
			return _application;
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
			dispatchEvent(new Event(ApplicationLoader.LOADED));
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event.target.content);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
			if(ApplicationLoader.APP_FILE == "imobile_application.swf")
			{
				ApplicationLoader.APP_FILE = "sessions/imobile_application.swf";
				loadApplication();
			}
			else
				dispatchEvent(new Event(ApplicationLoader.LOAD_ERROR));
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
			_bytesloaded = event.bytesLoaded;
			_bytestotal = event.bytesTotal;
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			dispatchEvent(new Event(ApplicationLoader.LOADING_UPDATE));
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
			dispatchEvent(new Event(ApplicationLoader.UNLOADED));
        }
	}
}
class SingletonEnforcer{}
