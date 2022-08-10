package com.criticalfusion.training.player.events
{
	import flash.events.Event;
	
	public class SetTextEvent extends Event
	{
		public static const SET_TEXT_COMMAND:String = "set text command";
		public var code:String;
		public function SetTextEvent(type:String, code:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.code = code;
		}
		
		public override function clone() : Event
		{
			return new SetTextEvent(type, code, bubbles, cancelable);
		}
	}
}