package imobile.sessions.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fl.transitions.Tween;
	import fl.transitions.easing.*; 
	import fl.transitions.TweenEvent;
	
	public class BubbleAnimation extends EventDispatcher
	{		
		static private var _instance:BubbleAnimation;
		private var _animatePos:Tween;
		private var _animateAlpha:Tween;
		private var _pos:Number;
		private var _direction:String;
		private var _clip:Object;
		private var _distance:int = 150;
		private var _time:int = 1;
		
		
		public function BubbleAnimation(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():BubbleAnimation 
		{
			if(BubbleAnimation._instance == null) 
			{
				BubbleAnimation._instance = new BubbleAnimation(new SingletonEnforcer());
			}
			return BubbleAnimation._instance;
		}
		
		public function setAnimation(obj:Object,d:String)
		{
			_clip = obj;
			var axis:String = getAxis(d);
			_pos = _clip[axis];
			_direction = d;
			_animatePos = new Tween(_clip, axis, Strong.easeOut, _pos, _pos, _time, true);
			_animateAlpha = new Tween(_clip, "alpha", Strong.easeOut, 0, 1, _time, true);
			_animatePos.stop();
			_animateAlpha.stop();
			setStartPos();
		}
		
		private function done(e:TweenEvent):void
		{
			_animatePos.removeEventListener(TweenEvent.MOTION_FINISH, done);
			dispatchEvent(new Event("done"));
		}
		
		public function animate():void
		{
			_animatePos.finish = _pos;
			_animatePos.addEventListener(TweenEvent.MOTION_FINISH, done, false, 0, true);
			_animatePos.start();
			_animateAlpha.start();
		}
		
		private function getAxis(d:String):String
		{
			var pos:String;
			switch(d)
			{
				case "left":
				case "right":
					pos = "x";
					break;
				case "up":
				case "down":
				case "none":
					pos =  "y";
					break;
			}
			return pos;
		}
		
		private function setStartPos():void
		{
			switch(_direction)
			{
				case "left":
					_animatePos.begin = _pos + _distance;
					break;
				case "right":
					_animatePos.begin = _pos - _distance;
					break;
				case "up":
					_animatePos.begin = _pos + _distance;
					break;
				case "down":
					_animatePos.begin = _pos - _distance;
					break;
				case "none":
					_animatePos.begin = _pos;
					break;
			}
		}
	}
}

class SingletonEnforcer{}
