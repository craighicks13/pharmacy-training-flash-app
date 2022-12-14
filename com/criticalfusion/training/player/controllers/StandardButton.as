package com.criticalfusion.training.player.controllers
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class StandardButton extends MovieClip 
	{
		public var ENABLED:Boolean;
		
		public function StandardButton() 
		{
			enable();
		}
		
		public function enable():void 
		{
			this.gotoAndStop(1);
			ENABLED = true;
			setListeners();
		}
		
		public function disable():void 
		{
			this.gotoAndStop(4);
			ENABLED = false;
			removeListeners();			
		}
		
		public function over(e:MouseEvent):void 
		{
			this.gotoAndStop(2);
		}
		
		public function out(e:MouseEvent):void 
		{
			this.gotoAndStop(1);
		}
		
		public function up(e:MouseEvent):void 
		{
			this.gotoAndStop(2);
		}
		
		public function down(e:MouseEvent):void 
		{
			this.gotoAndStop(3);
		}
		
		private function setListeners():void 
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, down, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, up, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, over, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, out, false, 0, true);
		}
		
		private function removeListeners():void 
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, down);
			this.removeEventListener(MouseEvent.MOUSE_UP, up);
			this.removeEventListener(MouseEvent.MOUSE_OVER, over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, out);			
		}
	}
}
