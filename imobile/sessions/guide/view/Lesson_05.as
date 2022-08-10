package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_05 extends LessonBase
	{
		private var _popup1:MovieClip;
		private var _popup2:MovieClip;
		
		public function Lesson_05()	{ getInstance(); }
		
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
					Bubble.getInstance().newBubble("viz05_01", 52, 148, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("invisiblebutton", 0, 170, true);
					InteractionController.getInstance().setTriggerSize(27, 54);
					break;
				case 2:
					_multiSteps = 3;
					Bubble.getInstance().newBubble("viz05_02a", 110, 73, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("pick_route", 138, 137);
					break;
				case 2.1:
					Bubble.getInstance().newBubble("viz05_02b", 395, 414, Bubble.DOWN);
					InteractionController.getInstance().addPopUpTrigger("active_route", 515, 380, "NEW");
					break;
				case 2.2:
					Bubble.getInstance().newBubble("viz05_02c", 256, 150, Bubble.DOWN);
					InteractionController.getInstance().addPopUpTrigger("route_name", 555, 350, "OK");
					break;
				case 2.3:
					Bubble.getInstance().newBubble("viz05_06c", 300, 410, Bubble.DOWN);
					InteractionController.getInstance().addPopUpTrigger("active_route_w_name", 515, 380, "OK");
					break;
				case 3:
					Bubble.getInstance().newBubble("viz05_03", 205, 95, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("green_flag", 225, 210);
					break;
				case 4:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz05_04a", 342, 314, Bubble.UP);
					InteractionController.getInstance().addTriggerClip("loc_start", 512, 383, "input_correct", "@12");
					break;
				case 4.1:
					Bubble.getInstance().newBubble("viz05_04b", 430, 460, Bubble.DOWN);
					InteractionController.getInstance().updateTrigger("OK");
					break;
				case 5:
					Bubble.getInstance().newBubble("viz05_05", 606, 378, Bubble.UP);
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(5);
					break;
				case 6:
					Bubble.getInstance().newBubble("viz05_06a", 203, 117, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("red_flag", 225, 246);
					break;
				case 7:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz05_06b", 190, 110, Bubble.DOWN);
					InteractionController.getInstance().addTriggerClip("loc_start", 512, 383, "input_correct", "@WEM%");
					break;
				case 7.1:
					Bubble.getInstance().newBubble("viz05_06c", 413, 449, Bubble.DOWN);
					InteractionController.getInstance().updateTrigger("OK");
					break;
				case 8:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz05_07", 525, 178, Bubble.NONE);
					InteractionController.getInstance().addTriggerClip("verify_name", 538, 370, "name_selected");
					break;
				case 8.1:
					Bubble.getInstance().newBubble("viz05_06c", 479, 410, Bubble.DOWN);
					InteractionController.getInstance().updateTrigger("OK");
					break;
				case 9:
					Bubble.getInstance().newBubble("viz05_08", 566, 253, Bubble.DOWN);
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(6);
					break;
				case 10:
					Bubble.getInstance().newBubble("viz05_09a", 648, 134, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("route_butt", 996, 144, true);
					break;
				case 11:
					Bubble.getInstance().newBubble("viz05_09b", 611, 371, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("fit_route_butt", 996, 434, true);
					break;
				case 12:
					Bubble.getInstance().newBubble("viz05_10", 167, 198, Bubble.UP);
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(8);
					break;
				case 13:
					Bubble.getInstance().newBubble("viz05_11", 377, 390, Bubble.NONE);
					break;
				
			}
		}
	}
}
