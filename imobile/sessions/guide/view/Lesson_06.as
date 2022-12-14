package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_06 extends LessonBase
	{
		public function Lesson_06()	{ getInstance(); }
		
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
					_multiSteps = 3;
					Bubble.getInstance().newBubble("viz06_01a", 375, 279, Bubble.DOWN);
					InteractionController.getInstance().addTriggerClip("send_closures", 766, 465, "item_selected");
					break;
				case 1.1:
					Bubble.getInstance().newBubble("viz06_01b", 385, 347, Bubble.NONE);
					InteractionController.getInstance().updateTriggerClip("item_deleted");
					break;
				case 1.2:
					Bubble.getInstance().newBubble("viz06_01c", 552, 522, Bubble.NONE);
					InteractionController.getInstance().addTriggerClip("arrive", 766, 486, "item_deleted");
					arrive_clip.visible = false;
					break;
				case 1.3:
					InteractionController.getInstance().addTriggerClip("unit_data", 766, 507, "item_deleted");
					break;
				case 2:
					Bubble.getInstance().newBubble("viz06_02a", 15, 129, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 3:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz06_02b", 360, 38, Bubble.UP);
					InteractionController.getInstance().addTrigger("invisible_button", 650, 25, true);
					break;
				case 3.1:
					Bubble.getInstance().newBubble("viz06_02c", 560, 165, Bubble.UP);
					InteractionController.getInstance().addPopUpTrigger("nav_menu", 830, 250, "RESET_BUTTON");
					break;
				case 4:
					Bubble.getInstance().newBubble("viz06_03", 362, 337, Bubble.NONE);
					InteractionController.getInstance().clearTriggers();
					break;
			}
		}
	}
}
