package com.criticalfusion.training.player.views
{
	import com.criticalfusion.training.player.events.ScrollBarEvent;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class DescriptionBox extends Sprite
	{
		public var scrollbar:ScrollBar;
		public var open:Boolean = false;
		public var appText:TextField;
		
		public function DescriptionBox()
		{
			super();
			scrollbar.sbHeight = 365;
			scrollbar.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollChange, false, 0, true);
			scrollbar.visible = (appText.maxScrollV > 1);
		}
		
		public function setAppText(value:String):void
		{
			appText.htmlText = value;
			appText.scrollV = 0;
			if(appText.maxScrollV > 1)
			{
				scrollbar.reset();
				scrollbar.visible = true;
			}
			else
			{
				scrollbar.visible = false;
			}
		}
		
		protected function scrollChange(event:ScrollBarEvent):void
		{
			appText.scrollV = appText.maxScrollV * event.scroll_percent;
		}
	}
}