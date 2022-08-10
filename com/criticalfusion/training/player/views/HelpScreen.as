package com.criticalfusion.training.player.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class HelpScreen extends Sprite
	{
		public static const CLOSE_HELP:String = "close help";
		public var close_button:MovieClip;
		public function HelpScreen()
		{
			super();
			init();
		}
		
		protected function onCloseButton(event:MouseEvent):void
		{
			dispatchEvent(new Event(HelpScreen.CLOSE_HELP));
		}
		
		protected function init():void
		{
			close_button.addEventListener(MouseEvent.CLICK, onCloseButton, false, 0, true);
		}
	}
}
