package imobile.sessions.controller
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import fl.transitions.Tween;
	import fl.transitions.easing.*; 
	import fl.transitions.TweenEvent;
	import flash.utils.getDefinitionByName;
	
	public class Bubble extends Sprite
	{		
		public static var NONE:String = "none";
		public static var UP:String = "up";
		public static var DOWN:String = "down";
		public static var LEFT:String = "left";
		public static var RIGHT:String = "right";
		
		public static var BUBBLE_READY:String = "bubble_ready";
		
		static private var _instance:Bubble;
		private var _animatePos:Tween;
		private var _animateAlpha:Tween;
		private var _pos:Number;
		private var _direction:String;
		private var _clip:Sprite;
		private var _distance:int = 250;
		private var _time:int = 1;
		
		
		public function Bubble(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():Bubble 
		{
			if(Bubble._instance == null) 
			{
				Bubble._instance = new Bubble(new SingletonEnforcer());
			}
			return Bubble._instance;
		}
		
		public function newBubble(linkage:String, xpos:int, ypos:int, dir:String):void
		{
			removeBubble();
			var BubbleClass:Class = getDefinitionByName(linkage) as Class;
			_clip = new BubbleClass();
			_clip.x = xpos;
			_clip.y = ypos;
			addChild(_clip);
			_direction = dir;
			setAnimation();
		}
		
		public function moveBubble(xpos:int, ypos:int):void
		{
			_clip.x = xpos;
			_clip.y = ypos;
		}
		
		private function removeBubble():void
		{
			try
			{
				removeChild(_clip);
			}catch(e:*) {}
		}
		
		private function setAnimation()
		{
			var axis:String = getAxis(_direction);
			_pos = _clip[axis];
			var sp:int = getStartPos();
			_animatePos = new Tween(_clip, axis, Strong.easeOut, sp, _pos, _time, true);
			_animateAlpha = new Tween(_clip, "alpha", Strong.easeOut, 0, 1, _time, true);
			_animatePos.stop();
			_animateAlpha.stop();
			dispatchEvent(new Event(Bubble.BUBBLE_READY));
		}
		
		private function done(e:TweenEvent):void
		{
			_animatePos.removeEventListener(TweenEvent.MOTION_FINISH, done);
			
			trace(_clip.y);
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
				case Bubble.LEFT:
				case Bubble.RIGHT:
					pos = "x";
					break;
				case Bubble.UP:
				case Bubble.DOWN:
				case Bubble.NONE:
					pos =  "y";
					break;
			}
			return pos;
		}
		
		private function getStartPos():int
		{
			var start_position:int;
			switch(_direction)
			{
				case Bubble.LEFT:
					start_position = _pos + _distance;
					break;
				case Bubble.RIGHT:
					start_position = _pos - _distance;
					break;
				case Bubble.UP:
					start_position = _pos + _distance;
					break;
				case Bubble.DOWN:
					start_position = _pos - _distance;
					break;
				case Bubble.NONE:
					start_position = _pos;
					break;
			}
			return start_position;
		}
	}
}

class SingletonEnforcer{}
