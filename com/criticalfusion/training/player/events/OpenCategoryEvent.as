package com.criticalfusion.training.player.events
{
	import flash.events.Event;
	
	public class OpenCategoryEvent extends Event
	{
		public static const OPEN_CATEGORY:String = "open category";
		public var category_id:String;
		public function OpenCategoryEvent(type:String, category_id:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.category_id = category_id;
		}
		
		public override function clone() : Event
		{
			return new OpenCategoryEvent(type, category_id, bubbles, cancelable);
		}
	}
}