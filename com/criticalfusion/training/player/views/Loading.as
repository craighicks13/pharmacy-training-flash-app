package com.criticalfusion.training.player.views
{
	import com.criticalfusion.training.player.controllers.LessonLoader;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Loading extends MovieClip
	{
		public var display_percent:TextField;
		public var loading_bar:MovieClip;
		
		function Loading()
		{
			LessonLoader.instance.addEventListener(LessonLoader.LOADING_UPDATE, updateLoading, false, 0, true);
			reset();
		}
		
		private function updateLoading(e:Event):void
		{
			var percent:Number = Math.round(LessonLoader.instance._bytesloaded / LessonLoader.instance._bytestotal * 100);
			display_percent.text = String(percent) + "%";
			loading_bar.scaleX = percent/100;
		}
		
		public function reset():void
		{
			display_percent.text = "0%";
			loading_bar.scaleX = 0;
		}
	}
}
