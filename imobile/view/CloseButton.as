package imobile.view {
	import imobile.controller.iButton;
	import flash.events.Event;
	
	public class CloseButton extends iButton{
		private static const _TYPE:String = "CLOSE";
		
		public function CloseButton() { }
		
		public function get TYPE():String 
		{
			return _TYPE;
		}
		
		public function getInstance():void 
		{
			
		}
	}
}
