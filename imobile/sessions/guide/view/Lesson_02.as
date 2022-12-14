package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_02 extends LessonBase
	{
		
		public function Lesson_02()	{ getInstance(); }
		
		public override function updateAppStatus():void
		{
			getCurrentFunctionality();
		}
		
		public override function getCurrentFunctionality():void
		{
			_currentFrame = currentFrame;
			if(_multiSteps == _step) _multiSteps = 0;
			trace("currentFrame: " + String(currentFrame + (_step/10)));
			switch(currentFrame + (_step/10))
			{
				case 1:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_02_01_b1", 30, 590, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("start_butt", 37, 752, true);
					break;
				case 1.1:
					Bubble.getInstance().moveBubble(30, 480);
					InteractionController.getInstance().addPopUpTrigger("start_menu", 0, 616, "START_APP");
					break;
				case 2:
					Bubble.getInstance().newBubble("viz_02_02_b1", 75, 180, Bubble.UP);
					InteractionController.getInstance().addTrigger("enroute_butt", 89, 170);
					break;
				case 3:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_02_03_b1", 149, 105, Bubble.UP);
					InteractionController.getInstance().addTrigger("recall_butt", 555, 88);
					break;
				case 3.1:
					Bubble.getInstance().newBubble("viz_02_03_b2", 17, 468, Bubble.UP);
					InteractionController.getInstance().addTrigger("event_list", 2, 453);
					break;
				case 4:
					Bubble.getInstance().newBubble("viz_02_04_b1", 528, 304, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("msg_list", 521, 453);
					break;
				case 5:
					Bubble.getInstance().newBubble("viz_02_05_b1", 592, 423, Bubble.UP);
					InteractionController.getInstance().addScrollTrigger("mainWindow", 5, 125, "window");
					break;
				case 6:
					Bubble.getInstance().newBubble("viz_02_06_b1", 512, 330, Bubble.NONE);
					break;
			}
		}
	}
}
