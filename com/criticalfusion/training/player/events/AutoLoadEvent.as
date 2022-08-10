package com.criticalfusion.training.player.events
{
	import flash.events.Event;
	
	public class AutoLoadEvent extends Event
	{
		public static const AUTOLOAD_LESSON:String = "autoload lesson";
		public var lesson:String;
		public function AutoLoadEvent(type:String, lesson:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.lesson = lesson;
		}
		
		public override function clone():Event
		{
			return new AutoLoadEvent(type, lesson, bubbles, cancelable);
		}
	}
}