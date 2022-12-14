package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import imobile.sessions.controller.DrawSelectBox;
	import flash.display.MovieClip;
	
	public class Lesson_04 extends LessonBase
	{
		
		public function Lesson_04()	{ getInstance(); }
		
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
					Bubble.getInstance().newBubble("viz_04_01", 42, 152, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 2:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_04_02a", 56, 136, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("invisiblebutton", 1, 115, true);
					InteractionController.getInstance().setTriggerSize(27, 58);
					break;
				case 2.1:
					Bubble.getInstance().newBubble("viz_04_02b", 61, 91, Bubble.LEFT);
					expand_map_clip.gotoAndStop(2);
					break;
				case 3:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_04_03", 594, 90, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("zoom_in", 996, 143, true);
					break;
				case 3.1:
					InteractionController.getInstance().addTriggerClip("zoom_map", 595, 393, "done_zoom");
					break;
				case 4:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_04_04", 552, 137, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("zoom_out", 996, 191, true);
					break;
				case 4.1:
					InteractionController.getInstance().addTriggerClip("zoom_map_out", 595, 393, "done_zoom");
					break;
				case 5:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_04_05a", 589, 229, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("fit_area", 996, 285, true);
					break;
				case 5.1:
					Bubble.getInstance().newBubble("viz_04_05b", 199, 229, Bubble.DOWN);
					InteractionController.getInstance().addTriggerClip("map_fit_area", 595, 393, "done_fit_area");
					break;
				case 6:
					_multiSteps = 2;
					Bubble.getInstance().newBubble("viz_04_06a", 656, 490, Bubble.DOWN);
					InteractionController.getInstance().addScrollTrigger("mapWindow", 258, 118, "window");
					break;
				case 6.1:
					Bubble.getInstance().newBubble("viz_04_06b", 630, 580, Bubble.DOWN);
					InteractionController.getInstance().setScrollTriggerDirection("horizontal");
					break;
				case 6.2:
					Bubble.getInstance().newBubble("viz_04_06c", 685, 320, Bubble.RIGHT);
					InteractionController.getInstance().addTrigger("fit_all", 996, 332, true);
					break;
				case 7:
					Bubble.getInstance().newBubble("viz_04_07a", 51, 237, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("invisiblebutton", 1, 223, true);
					InteractionController.getInstance().setTriggerSize(27, 55);
					break;
				case 8:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_04_07b", 186, 270, Bubble.UP);
					InteractionController.getInstance().setTimer(12);
					break;
				case 8.1:
					Bubble.getInstance().newBubble("viz_04_08", 59, 252, Bubble.LEFT);
					InteractionController.getInstance().addTrigger("invisiblebutton", 1, 279, true);
					InteractionController.getInstance().setTriggerSize(27, 55);
					break;
				case 9:
					Bubble.getInstance().newBubble("viz_04_09", 344, 318, Bubble.NONE);
					InteractionController.getInstance().clearTriggers();
					break;
			}
		}
	}
}
