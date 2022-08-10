package com.criticalfusion.training.player.events
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const VALUE_CHANGED = "value changed";
		public var scroll_percent:Number;
		
		public function ScrollBarEvent(type:String, scroll_percent:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.scroll_percent = scroll_percent;
		}
		
		override public function clone():Event
		{
			return new ScrollBarEvent(type, scroll_percent, bubbles, cancelable);
		}
	}
}
