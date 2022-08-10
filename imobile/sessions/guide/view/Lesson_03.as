package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_03 extends LessonBase
	{
		
		public function Lesson_03()	{ getInstance(); }
		
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
					Bubble.getInstance().newBubble("viz_03_01_b1", 275, 597, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("erd_butt", 310, 752, true);
					break;
				case 2:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_03_02a", 235, 150, Bubble.LEFT);
					InteractionController.getInstance().addDropDownTrigger("zone", 12, 147, 18);
					break;
				case 2.1:
					Bubble.getInstance().newBubble("viz_03_02b", 202, 140, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("click_go_small", 92, 190);
					break;
				case 3:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_03_03a", 550, 148, Bubble.LEFT);
					InteractionController.getInstance().addDropDownTrigger("complex_card", 272, 143, 9);
					break;
				case 3.1:
					Bubble.getInstance().newBubble("viz_03_02b", 528, 135, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("click_go_small", 427, 186);
					break;
				case 4:
					Bubble.getInstance().newBubble("viz_03_04a", 713, 527, Bubble.DOWN);
					InteractionController.getInstance().addScrollTrigger("facilityMap", 286, 107, "facilityWindow");
					break;
				case 5:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_03_05a", 506, 95, Bubble.UP);
					InteractionController.getInstance().addTrigger("zoom_mag", 534, 87, true);
					break;
				case 5.1:
					InteractionController.getInstance().addTriggerClip("zoom_map", 286, 73, "done_zoom");
					break;
				case 6:
					Bubble.getInstance().newBubble("viz_03_06_b1", 135, 595, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("imobile_butt", 154, 752, true);
					break;
				case 7:
					Bubble.getInstance().newBubble("viz_03_06_b2", 282, 599, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("erd_butt", 310, 752, true);
					break;
				case 8:
					Bubble.getInstance().newBubble("viz_03_07", 344, 318, Bubble.NONE);
					break;
			}
		}
	}
}
