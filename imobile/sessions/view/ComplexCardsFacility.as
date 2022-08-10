﻿package imobile.sessions.view{	import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.ui.Mouse;	import flash.events.Event;	import flash.text.TextField;		public class ComplexCardsFacility extends MovieClip	{		private var _map:MovieClip;        private var _cursor:MagnifyInCursor;				public function ComplexCardsFacility() 		{			addEventListener(Event.ADDED_TO_STAGE, setupInstance, false, 0, true);		}				private function setupInstance(e:Event):void		{			removeEventListener(Event.ADDED_TO_STAGE, setupInstance);			facilityWindow.source = "complex_cards_scrollmap";			_map = facilityWindow.content;			magnify_button.addEventListener("click", toggleMagnify, false, 0, true);		}				private function contentZoom(e:Event):void		{			mouseOutHandler(e);			magnifyOff();			facilityWindow.source = "complex_cards_scrollmap_zoom";			_map = facilityWindow.content;			magnify_button.upState();			dispatchEvent(new Event("MAP_ZOOMED"));		}				private function toggleMagnify(e:Event)		{			if(magnify_button.STATE) magnifyOn(); else magnifyOff();		}				private function magnifyOff():void		{			_map.removeEventListener("click", contentZoom);            _map.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);            _map.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);			stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);            _map.removeChild(_cursor);		}				private function magnifyOn():void		{			_map.addEventListener("click", contentZoom, false, 0, true);            _map.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);            _map.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);            _cursor = new MagnifyInCursor();            _cursor.visible = false;            _map.addChild(_cursor);            stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);        }        private function mouseOverHandler(event:MouseEvent):void 		{            Mouse.hide();            _map.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true);        }        private function mouseOutHandler(event:MouseEvent):void 		{            Mouse.show();            _map.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);            _cursor.visible = false;        }        private function mouseMoveHandler(event:MouseEvent):void 		{            _cursor.x = event.localX + 15;            _cursor.y = event.localY + 15;            event.updateAfterEvent();            _cursor.visible = true;        }        private function mouseLeaveHandler(event:Event):void 		{            mouseOutHandler(new MouseEvent(MouseEvent.MOUSE_MOVE));        }	}}