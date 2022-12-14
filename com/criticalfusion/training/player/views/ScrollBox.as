package com.criticalfusion.training.player.views
{
	import com.criticalfusion.training.player.events.ScrollBarEvent;
	
	import flash.display.MovieClip;
	
	public class ScrollBox extends MovieClip
	{		
		public function ScrollBox():void
		{
			sb.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollChange);
		}
		
		private function scrollChange(event:ScrollBarEvent):void
		{
			content.y = -event.scroll_percent * (content.height - masker.height);
		}
	}
}
