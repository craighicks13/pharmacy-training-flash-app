package com.criticalfusion.training.player.views
{	
	import com.criticalfusion.training.player.events.ScrollBarEvent;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ScrollBar extends MovieClip
	{
		public var thumb:MovieClip;
		public var track:MovieClip;
		public var background:Sprite;
		public var down_button:SimpleButton;
		public var up_button:SimpleButton;
		
		private var yOffset:Number;
		private var yMin:int = 0;
		private var yMax:Number;
		private var scroll_percent:Number = 0;
		
		public function ScrollBar():void
		{
			yMax = track.height - thumb.height;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbDown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, thumbUp, false, 0, true);
			down_button.addEventListener(MouseEvent.CLICK, onScrollDown, false, 0, true);
			up_button.addEventListener(MouseEvent.CLICK, onScrollUp, false, 0, true);
		}
		
		public function reset():void
		{
			thumb.y = yMin;
		}
		
		public function set percent(value:Number):void
		{
			thumb.y = yMax * value;
		}
		
		public function get percent():Number
		{
			return (thumb.y / yMax);
		}
		
		public function set sbHeight(value:int):void
		{
			background.height = value;
			background.y = -19;
			track.height = value - 38;
			down_button.y = value - 27;
			yMax = track.height - thumb.height;
			percent = scroll_percent;
		}
		
		public function get sbHeight():int
		{
			return background.height;
		}
		
		protected function onScrollDown(event:MouseEvent):void
		{
			thumb.y += track.height * 0.25;
			if(thumb.y <= yMin)
				thumb.y = yMin;
			if(thumb.y >= yMax)
				thumb.y = yMax;
			scroll_percent = (thumb.y / yMax);
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VALUE_CHANGED, (thumb.y / yMax)));
		}
		
		protected function onScrollUp(event:MouseEvent):void
		{
			thumb.y -= track.height * 0.25;
			if(thumb.y <= yMin)
				thumb.y = yMin;
			if(thumb.y >= yMax)
				thumb.y = yMax;
			scroll_percent = (thumb.y / yMax);
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VALUE_CHANGED, (thumb.y / yMax)));
		}
		
		protected function thumbDown(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, thumbMove, false, 0, true);
			yOffset = mouseY - thumb.y;
		}

		protected function thumbUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, thumbMove);
		}

		protected function thumbMove(event:MouseEvent):void
		{
			thumb.y = mouseY - yOffset;
			if(thumb.y <= yMin)
				thumb.y = yMin;
			if(thumb.y >= yMax)
				thumb.y = yMax;
			scroll_percent = (thumb.y / yMax);
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VALUE_CHANGED, (thumb.y / yMax)));
			event.updateAfterEvent();
		}
	}
}
