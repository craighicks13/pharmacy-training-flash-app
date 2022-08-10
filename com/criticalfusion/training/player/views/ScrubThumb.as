package com.criticalfusion.training.player.views
{
	import com.criticalfusion.training.player.controllers.StandardButton;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class ScrubThumb extends StandardButton
	{
		public static const TYPE:String = "SLIDER";
		protected static const DRAG_AREA_SIZE:Number = 100;
		
		protected var _bounds:Rectangle;
		protected var _drag_area:Shape;
		
		public function ScrubThumb(){}
		
		protected function createDragArea():void 
		{
			_drag_area = new Shape();
            _drag_area.graphics.beginFill(0x00000, 0);
            _drag_area.graphics.lineStyle(0, 0x000000, 0);
            _drag_area.graphics.drawRect( -(DRAG_AREA_SIZE/2),-(DRAG_AREA_SIZE/2), DRAG_AREA_SIZE, DRAG_AREA_SIZE);
            _drag_area.graphics.endFill();
			addChild(_drag_area);
		}
		
		protected function destroyDragArea():void {
			removeChild(_drag_area);
		}
		
		protected function addSliderListeners():void {
			addEventListener(MouseEvent.ROLL_OUT, dropSlider);
			addEventListener(MouseEvent.MOUSE_UP, dropSlider);			
		}
		
		protected function removeSliderListeners():void {
			removeEventListener(MouseEvent.ROLL_OUT, dropSlider);
			removeEventListener(MouseEvent.MOUSE_UP, dropSlider);	
		}
		
		public function dragSlider(e:Event):void {
			createDragArea();
			addSliderListeners();
			this.startDrag(true, _bounds);
			dispatchEvent(new Event("SLIDER_DRAG"));
		}
		
		public function dropSlider(e:Event):void {
			destroyDragArea();
			removeSliderListeners();
			this.stopDrag();
			dispatchEvent(new Event("SLIDER_DROPPED"));
		}
		
		public function getInstance(sb:MovieClip):void {
			_bounds = new Rectangle(sb.START,this.y,sb.SIZE,0);
			addEventListener(MouseEvent.MOUSE_DOWN, dragSlider);
		}
	}
}
