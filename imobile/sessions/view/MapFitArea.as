package imobile.sessions.view
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;
	import imobile.sessions.controller.DrawSelectBox;
	
	public class MapFitArea extends MovieClip
	{
		private var _cursor:DisplayObject;
		private var CURSOR:String;
		
		public function MapFitArea() 
		{ 
			cursorID = "MagnifyInCursor";
			getInstance(); 
		}
			
		public function getInstance()
		{
			stop();
			addEventListener(Event.ADDED, fitAreaOn, false, 0, true);
		}
		
		public function set cursorID(param:String):void
		{
			this.CURSOR = param;
		}
		
		private function endDrawBox(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_UP, endDrawBox);
			if(DrawSelectBox.getInstance().endDraw())
			{
				fitAreaOff();
				dispatchEvent(new Event("done_fit_area"));
			}
			else
			{
				addEventListener(MouseEvent.MOUSE_DOWN, drawBox, false, 0, true);
			}
		}
		
		private function dragArea():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, drawBox, false, 0, true);
		}
		
		private function drawBox(e:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, drawBox);
			addEventListener(MouseEvent.MOUSE_UP, endDrawBox, false, 0, true);
			DrawSelectBox.getInstance().startDraw(this, e.localX, e.localY);
		}
		
		private function fitAreaOff():void
		{
            Mouse.show();
            removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
            removeChild(_cursor);
		}
		
		private function fitAreaOn(e:Event):void
		{
			removeEventListener(Event.ADDED, fitAreaOn);
            addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);

			var Cursor:Class = getDefinitionByName(CURSOR) as Class;
            _cursor = new Cursor();
            _cursor.visible = false;
            addChild(_cursor);

            stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
			dragArea();
        }

        private function mouseOverHandler(event:MouseEvent):void 
		{
            Mouse.hide();
            addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);
        }

        private function mouseOutHandler(event:MouseEvent):void 
		{
            Mouse.show();
            removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
            _cursor.visible = false;
        }

        private function mouseMoveHandler(event:MouseEvent):void 
		{
            _cursor.x = event.localX + 15;
            _cursor.y = event.localY + 15;
            event.updateAfterEvent();
            _cursor.visible = true;
        }

        private function mouseLeaveHandler(event:Event):void 
		{
            mouseOutHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));
        }
	}
	
}
