package imobile.sessions.controller
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
    import flash.display.LineScaleMode;
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.Shape;
	
	public class DrawSelectBox extends Sprite
	{
		static private var _instance:DrawSelectBox;
		private var startX:int;
		private var startY:int;
		private var _dobj:MovieClip;
		private var _box:Shape;
		
		public function DrawSelectBox(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():DrawSelectBox 
		{
			if(DrawSelectBox._instance == null) 
			{
				DrawSelectBox._instance = new DrawSelectBox(new SingletonEnforcer());
			}
			return DrawSelectBox._instance;
		}
		
		public function startDraw(obj:MovieClip, sx:int, sy:int):void
		{
			trace("got 3");
			_dobj = obj;
			startX = sx;
			startY = sy;
			_dobj.addEventListener(MouseEvent.MOUSE_MOVE, drawBox, false, 0, true);
		}
		
		private function drawBox(e:MouseEvent):void
		{
            removeBox();
			_box = new Shape();
            _box.graphics.beginFill(0x000000, 0);
            _box.graphics.lineStyle(1, 0xFFD700, 1, false, LineScaleMode.VERTICAL, CapsStyle.NONE, JointStyle.MITER, 10);
            _box.graphics.drawRect(startX, startY, e.localX - startX, e.localY - startY);
            _box.graphics.endFill();
            _dobj.addChild(_box);
		}
		
		private function removeBox():void
		{
			try
			{
				_dobj.removeChild(_box);
			}catch(e:*){}
		}
		
		public function endDraw():Boolean
		{
			_dobj.removeEventListener(MouseEvent.MOUSE_MOVE, drawBox);
			var goodBox:Boolean;
			if(_box && _box.width > 25 && _box.height > 15) goodBox = true; else goodBox = false;
            removeBox();
			return goodBox;
		}
	}
}

class SingletonEnforcer{}
