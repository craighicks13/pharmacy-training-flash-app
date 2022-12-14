package imobile.controller 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	
	public class iSlider extends MovieClip
	{
		public static var DRAGGING:String = "dragging";
		public static var DROPPED:String = "dropped";
		
		protected static var _instance:iSlider;
		
		protected var _bar:MovieClip;
		protected var _sliderbar:MovieClip;
		protected var _slider:MovieClip;
		
		public function iSlider(singletonEnforcer:SingletonEnforcer) { }
		
		public static function getInstance():iSlider 
		{
			if(iSlider._instance == null) { iSlider._instance = new iSlider(new SingletonEnforcer()); }
			return iSlider._instance;
		}
		
		protected function dragging(e:Event):void 
		{
			e.target.addEventListener(MouseEvent.MOUSE_MOVE, adjustBar);
			dispatchEvent(new Event(iSlider.DRAGGING));
		}
		
		protected function dropped(e:Event):void 
		{
			e.target.removeEventListener(MouseEvent.MOUSE_MOVE, adjustBar);
			doAdjust();
			dispatchEvent(new Event(iSlider.DROPPED));
		}
		
		protected function adjustBar(e:*):void 
		{
			doAdjust();
			e.updateAfterEvent();
		}
		
		protected function doAdjust():void 
		{
			_bar.width = _slider.x - _sliderbar.START;
		}
		
		public function get percentPlayed():Number
		{
			return _bar.width / _sliderbar.SIZE;
		}
		
		public function updatePos(e:TimerEvent,percent:Number):void
		{
			_slider.x = Math.round(_sliderbar.SIZE * percent) + _sliderbar.START;
			adjustBar(e);
		}
		
		public function setup(bar:MovieClip,sliderbar:MovieClip,slider:MovieClip):void 
		{
			_bar = bar;
			_sliderbar = sliderbar;
			_slider = slider;
			doAdjust();
			_slider.getInstance(_sliderbar);
			_slider.addEventListener("SLIDER_DRAG", dragging);
			_slider.addEventListener("SLIDER_DROPPED", dropped);
		}
	}
}

class SingletonEnforcer{}
