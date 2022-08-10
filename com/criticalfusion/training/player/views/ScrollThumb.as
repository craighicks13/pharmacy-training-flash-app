package com.criticalfusion.training.player.views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ScrollThumb extends MovieClip
	{
		public function ScrollThumb()
		{
			super();
			this.gotoAndStop(1);
			this.buttonMode = true;
			this.useHandCursor = true;
			
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
		}
		
		final protected function onRollOut(event:MouseEvent):void
		{
			this.gotoAndStop(1);
		}
		
		final protected function onRollOver(event:MouseEvent):void
		{
			this.gotoAndStop(2);
		}
		
		final protected function onMouseDown(event:MouseEvent):void
		{
			this.gotoAndStop(3);
		}
	}
}