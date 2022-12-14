package imobile.controller {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fl.transitions.Tween;
	import fl.transitions.easing.*; 
	import fl.transitions.TweenEvent;
	
	public class OpenCloseMenu {
		
		public static const OPENED:String = "OPENED";
		public static const CLOSED:String = "CLOSED";
		
		private var _animate:Tween;
		private var _openY:Number;
		private var _closeY:Number;
		private var _clip:Object;
		
		public function OpenCloseMenu(obj:Object,o:Number,c:Number) {
			_clip = obj;
			openY = o;
			closeY = c;
			_animate = new Tween(_clip, "y", Strong.easeOut, _clip.y, _closeY, 0.5, true);
			_animate.stop();
		}
		
		private function opened(e:TweenEvent):void {
			_animate.removeEventListener(TweenEvent.MOTION_FINISH, opened);
			_clip.dispatchEvent(new Event(OpenCloseMenu.OPENED));
		}
		
		private function closed(e:TweenEvent):void {
			_animate.removeEventListener(TweenEvent.MOTION_FINISH, closed);
			_clip.dispatchEvent(new Event(OpenCloseMenu.CLOSED));
		}
		
		public function openMenu():void {
			if(_animate.isPlaying) {
				_animate.stop();
				_animate.removeEventListener(TweenEvent.MOTION_FINISH, closed);
			}
			_animate.begin = _clip.y;
			_animate.finish = _openY;
			_animate.addEventListener(TweenEvent.MOTION_FINISH, opened);
			_animate.start();
		}
		
		public function closeMenu():void {
			if(_animate.isPlaying) {
				_animate.stop();
				_animate.removeEventListener(TweenEvent.MOTION_FINISH, opened);
			}
			_animate.begin = _clip.y;
			_animate.finish = _closeY;
			_animate.addEventListener(TweenEvent.MOTION_FINISH, closed);
			_animate.start();
		}
		
		public function get openY():Number 
		{
			return _openY;
		}
		
		public function set openY(param:Number):void 
		{
			_openY = param;
		}
		
		public function get closeY():Number 
		{
			return _closeY;
		}
		
		public function set closeY(param:Number):void 
		{
			_closeY = param;
		}
	}
}
