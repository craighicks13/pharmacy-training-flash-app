package com.criticalfusion.training.player.views
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gs.TweenLite;
	import gs.easing.Strong;
	
	public class MenuHeaderItem extends MovieClip
	{
		public var open:Boolean = false;
		public var sublist:Vector.<MenuItem> = new Vector.<MenuItem>();
		public var onMenuToggled:Function;
		public var onSectionSelected:Function;
		public var file:String;
		
		private var hitBox:Sprite;
		
		public function MenuHeaderItem()
		{
			super();
			
			this.cacheAsBitmap = true;
			
			hitBox = new Sprite();
			hitBox.graphics.beginFill(0xFF0000, 0);
			hitBox.graphics.drawRect(0, 0, 289, 43);
			addChild(hitBox);
			
			hitBox.buttonMode = true;
			hitBox.useHandCursor = true;
			
			hitBox.addEventListener(MouseEvent.ROLL_OVER, onRollOverBox, false, 0, true);
			hitBox.addEventListener(MouseEvent.ROLL_OUT, onRollOutBox, false, 0, true);
			hitBox.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownBox, false, 0, true);
			hitBox.addEventListener(MouseEvent.MOUSE_UP, onRollOverBox, false, 0, true);
			
			hitBox.addEventListener(MouseEvent.CLICK, onToggleState, false, 0, true);
		}
		
		public function addMenuItem(value:MenuItem):void
		{
			value.x = (value.subsection) ? 70 : 35;
			value.defaultY = openHeight;
			value.visible = false;
			addChild(value);
			
			sublist.push(value);
		}
		
		public function get openHeight():int
		{
			var h:int = 43;
			var num:int = sublist.length;
			while(num-- > 0)
			{
				h += sublist[num].height;
			}
			
			return h;
		}
		
		protected function onRollOverBox(event:MouseEvent):void
		{
			this.gotoAndStop(2);
		}
		
		protected function onRollOutBox(event:MouseEvent):void
		{
			this.gotoAndStop(1);
		}
		
		protected function onMouseDownBox(event:MouseEvent):void
		{
			this.gotoAndStop(3);
		}
		
		protected function onToggleState(event:MouseEvent):void
		{
			if(sublist.length)
				open ? closeMenu() : openMenu();
			else
				onSectionSelected(file);
		}
		
		public function closeMenu():void
		{
			open = false;
			var num:int = sublist.length;
			while(num-- > 0)
			{
				sublist[num].visible = false;
				sublist[num].y = 0;
				if(num == 0) onMenuToggled();
			}
		}
		
		public function openMenu():void
		{
			open = true;
			var num:int = sublist.length;
			while(num-- > 0)
			{
				sublist[num].y = sublist[num].defaultY;
				sublist[num].visible = true;
			}
			onMenuToggled();
		}
	}
}