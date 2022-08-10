package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_07 extends LessonBase
	{
		public function Lesson_07()	{ getInstance(); }
		
		public override function updateAppStatus():void
		{
			getCurrentFunctionality();
		}
		
		public override function getCurrentFunctionality():void
		{
			_currentFrame = currentFrame;
			if(_multiSteps == _step) _multiSteps = 0;
			switch(currentFrame + (_step/10))
			{
				case 1:
					Bubble.getInstance().newBubble("viz07_01", 18, 93, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 2:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz07_02a", 328, 274, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("msg_remark", 521, 455);
					break;
				case 2.1:
					Bubble.getInstance().newBubble("viz07_02b", 124, 110, Bubble.DOWN);
					dispatch_report.gotoAndStop(2);
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(6);
					break;
				case 3:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz07_03", 79, 141, Bubble.UP);
					InteractionController.getInstance().addPopUpTrigger("new_event", 170, 174, "acknowledge");
					break;
				case 3.1:
					Bubble.getInstance().newBubble("viz07_04a", 10, 72, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 4:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz07_04b", 42, 305, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("event2", 2, 476);
					break;
				case 4.1:
					dispatch_report.gotoAndStop(2);
					Bubble.getInstance().newBubble("viz07_04c", 269, 617, Bubble.DOWN);
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(6);
					break;
				case 5:
					Bubble.getInstance().newBubble("viz07_05", 348, 318, Bubble.NONE);
			}
		}
	}
}
