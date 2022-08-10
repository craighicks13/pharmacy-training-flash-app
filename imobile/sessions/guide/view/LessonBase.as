package imobile.sessions.guide.view 
{
	import flash.display.MovieClip;
	import fl.managers.StyleManager;
	import flash.events.Event;
	import imobile.controller.LessonsController;
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	
	public class LessonBase extends MovieClip
	{
		public var _currentFrame:int;
		public var _container:MovieClip;
		public var _multiSteps:int = 0;
		public var _step:int = 0;
		
		public function LessonBase()	{ getInstance() }
		
		public function proceed(e:Event):void
		{
			if(_multiSteps)
			{
				_step++;
			}
			else {
				_step = 0;
				nextFrame();
			}
			getCurrentFunctionality();
		}
		
		public function checkNewFrame(e:Event):void
		{
			if(_currentFrame != currentFrame) {
			
			_step = 0;
			_multiSteps = 0;
			InteractionController.getInstance().clearTriggers();
			updateAppStatus();
			
			}
		}
		
		public function getCurrentFunctionality():void { }
		
		private function animateBubble(e:Event):void
		{
			Bubble.getInstance().animate();
		}
		
		public function setStageListeners():void {}
		
		public function updateAppStatus():void {}
		
		private function bubbleAnimationDone(e:Event):void
		{
			setStageListeners();
		}
		
		public function removeInteractiveItem():void
		{
			
		}
		
		public function getInstance():void
		{
			stop();
			_container = this['container'];
			StyleManager.setStyle("scrollBarWidth", 30);
			StyleManager.setStyle("scrollArrowHeight", 30);
			
			LessonsController.getInstance().addEventListener(LessonsController.UPDATE_POSITION, checkNewFrame, false, 0, true);
			
			InteractionController.getInstance().addEventListener(InteractionController.TRIGGERED, proceed, false, 0, true);
			_container.addChild(InteractionController.getInstance());
			
			Bubble.getInstance().addEventListener(Bubble.BUBBLE_READY, animateBubble, false, 0, true);
			_container.addChild(Bubble.getInstance());
			
			addEventListener("enterFrame", checkNewFrame, false, 0, true);
		}
	}
}
