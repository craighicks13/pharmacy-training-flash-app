package imobile.sessions.view 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BasicButton extends MovieClip
	{
		private var _TYPE:String;		
		public var ENABLED:Boolean;
		
		public function BasicButton() { getInstance(); }
		
		public function set TYPE(n:String):void 
		{
			_TYPE = n;
		}
		
		public function get TYPE():String 
		{
			return _TYPE;
		}
		
		public function enable():void 
		{
			ENABLED = true;
			setListeners();
		}
		
		public function disable():void 
		{
			ENABLED = false;
			removeListeners();			
		}
		
		public function set setObjectName(n:String):void
		{
			this.name = n;
			TYPE = n;
		}
		
		public function over(e:MouseEvent):void 
		{
			this.gotoAndStop("over");
		}
		
		public function up(e:MouseEvent):void 
		{
			this.gotoAndStop(1);
		}
		
		public function down(e:MouseEvent):void 
		{
			this.gotoAndStop(2);
		}
		
		public function click(e:MouseEvent):void
		{
			dispatchEvent(new Event("proceed"));
		}
		
		private function setListeners():void 
		{
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, down, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, over, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_UP, up, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, up, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, click, false, 0, true);
		}
		
		private function removeListeners():void 
		{
			this.buttonMode = false;
			this.removeEventListener(MouseEvent.MOUSE_OVER, over);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, down);
			this.removeEventListener(MouseEvent.MOUSE_UP, up);
			this.removeEventListener(MouseEvent.MOUSE_OUT, up);
			this.removeEventListener(MouseEvent.CLICK, click);
		}
		
		public function getInstance():void 
		{
			this.gotoAndStop(1);
			TYPE = this.name;
			enable();
		}
	}
}
