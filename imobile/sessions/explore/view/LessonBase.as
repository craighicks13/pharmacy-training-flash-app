package imobile.sessions.explore.view 
{
	import flash.display.MovieClip;
	import fl.managers.StyleManager;
	import flash.events.Event;
	import imobile.controller.LessonsController;
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.explore.controller.Messages;
	
	public class LessonBase extends MovieClip
	{
		public var _currentFrame:int;
		public var _container:MovieClip;
		public var _multiSteps:int = 0;
		public var _step:int = 0;
		
		public function LessonBase()	{ }
		
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
		
		private function showMessage(e:Event):void
		{
			Messages.getInstance().animate();
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
		
		private function centerObject(obj:Object)
		{
			obj.x = stage.stageWidth/2;
			obj.y = stage.stageHeight/2;
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
			
			Messages.getInstance().addEventListener(Messages.MESSAGE_READY, showMessage, false, 0, true);
			centerObject(Messages.getInstance());
			_container.addChild(Messages.getInstance());
			
			addEventListener("enterFrame", checkNewFrame, false, 0, true);
		}
	}
}
