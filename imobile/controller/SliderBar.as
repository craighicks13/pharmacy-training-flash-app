package imobile.controller 
{
	import flash.display.MovieClip;
	
	public class SliderBar extends MovieClip
	{
		private var _size:Number;
		private var _start:Number;
		private var _end:Number;
		private static const _cap_size:Number = 9;
		
		public function SliderBar(){ getInstance() }
		
		public function get SIZE():Number 
		{
			return _size;
		}
		
		public function get START():Number 
		{
			return _start;
		}
		
		public function get END():Number 
		{
			return _end;
		}
		
		public function getInstance():void 
		{
			_size = this.width - (_cap_size * 2);
			_start = Math.round(this.x + _cap_size);
			_end = Math.round(this.x + this.width - _cap_size);
		}
	}
}
