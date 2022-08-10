package com.criticalfusion.training.player.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MenuItem extends MovieClip 
	{
		public static const SESSION_SELECTED:String = "session_selected";
		
		protected static var overFormat:TextFormat;
		protected static var defaultFormat:TextFormat;
		protected var _label:String;		// LABEL FOR THIS MENU ITEM
		protected var _subsection:Boolean = false;
		
		public var lbl:TextField;
		public var defaultY:int;
		public var scene:String;		// SCENE WE WANT TO JUMP TO
		
		public function MenuItem() { init(); }
		
		public function set label(param:String):void {
			_label = param;
			lbl.text = _label;
			lbl.autoSize = "left";
			adjustTextY();
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function set subsection(value:Boolean):void
		{
			_subsection = value;
			lbl.width = _subsection? 200 : 230;
			drawBackground();
		}
		
		public function get subsection():Boolean
		{
			return _subsection;
		}
		
		protected function adjustTextY() {
			lbl.y = height/2 - lbl.height/2;	// ADJUST THE TEXT TO VERTICALLY ALIGN WITH THE CENTER OF THE CLIP
			drawBackground();
		}
		
		protected function itemClicked(e:MouseEvent):void {
			dispatchEvent(new Event(MenuItem.SESSION_SELECTED));
		}
		
		protected function drawBackground():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xFF0000, 0);
			this.graphics.drawRect(lbl.x, lbl.y, lbl.width, lbl.height + 5);
		}
		
		protected function onOverItem(event:MouseEvent):void
		{
			lbl.setTextFormat(overFormat);
		}
		
		protected function onOutItem(event:MouseEvent):void
		{
			lbl.setTextFormat(defaultFormat);
		}
		
		// INSTANCE TRIGGERED BY SELF ON CREATION
		protected function init() {
			this.buttonMode = true;			// WE WANT THE HAND CURSOR TO SHOW UP ON ROLLOVER OF THE MOVIECLIP
			this.useHandCursor = true;
			
			overFormat = new TextFormat();
			overFormat.color = 0xB10049;
			
			defaultFormat = new TextFormat();
			defaultFormat.color = 0x000000;
			
			lbl.mouseEnabled = false;	// TURN OFF THE CLICK LISTENER FOR THE TEXTFIELD ON THE CLIP
			//btn.getInstance(this);		// SET UP THE ARROW BUTTON INSTANCE WITHIN THIS CLIP
			this.addEventListener(MouseEvent.ROLL_OVER, onOverItem, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, onOutItem, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, itemClicked, false, 0, true);
		}
	}
}
