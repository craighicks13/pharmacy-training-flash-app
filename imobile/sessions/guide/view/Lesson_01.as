package imobile.sessions.guide.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.controller.Bubble;
	import flash.display.MovieClip;
	
	public class Lesson_01 extends LessonBase
	{
		
		public function Lesson_01()	{ getInstance(); }
		
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
					Bubble.getInstance().newBubble("viz_01_01_b1", 10, 90, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 2:
					Bubble.getInstance().newBubble("viz_01_02_b1", 285, 586, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("erd_butt", 310, 752, true);
					break;
				case 3:
					Bubble.getInstance().newBubble("viz_01_03_b1", 128, 553, Bubble.DOWN);
					InteractionController.getInstance().addTrigger("imobile_butt", 154, 752, true);
					break;
				case 4:
					Bubble.getInstance().newBubble("viz_01_04_b1", 10, 90, Bubble.UP);
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true, false);
					break;
				case 5:
					Bubble.getInstance().newBubble("viz_01_05_b1", 58, 140, Bubble.UP);
					InteractionController.getInstance().addTrigger("acknowledge_butt", 88.5, 124);
					break;
				case 6:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_01_06_b1", 55, 108, Bubble.UP);
					InteractionController.getInstance().addTrigger("enr_butt", 77, 88);
					break;
				case 6.1:
					Bubble.getInstance().newBubble("viz_01_06_b2", 460, 570, Bubble.DOWN);
					InteractionController.getInstance().setTimer(6);
					break;
				case 7:
					Bubble.getInstance().newBubble("viz_01_07_b1", 101, 110, Bubble.UP);
					InteractionController.getInstance().addTrigger("arr_butt", 124, 88);
					break;
				case 8:
					Bubble.getInstance().newBubble("viz_01_08_b1", 288, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("clr_butt", 312, 88);
					break;
				case 9:
					Bubble.getInstance().newBubble("viz_01_09_b1", 148, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("recall_butt", 555, 88);
					break;
				case 10:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_01_10_b1", 305, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("emergency_butt", 712, 88);
					break;
				case 10.1:
					Bubble.getInstance().newBubble("viz_01_10_b2", 165, 380, Bubble.UP);
					InteractionController.getInstance().addPopUpTrigger("emergency_pop", 507, 334, "SEND");
					break;
				case 11:
					Bubble.getInstance().newBubble("viz_01_11_b1", 508, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("night_butt", 916, 88);
					break;
				case 12:
					Bubble.getInstance().newBubble("viz_01_11_b2", 508, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("night2_butt", 916, 86);
					break;
				case 13:
					_multiSteps = 1;
					Bubble.getInstance().newBubble("viz_01_12_b1", 149, 111, Bubble.UP);
					InteractionController.getInstance().addTrigger("trn_butt", 171, 88);
					break;
				case 13.1:
					Bubble.getInstance().newBubble("viz_01_12_b2", 180, 171, Bubble.DOWN);
					InteractionController.getInstance().addTriggerClip("transport_unit", 500, 335, "hospital_selected");
					break;
				case 14:
					Bubble.getInstance().newBubble("viz_01_14_b1", 512, 330, Bubble.NONE);
					InteractionController.getInstance().clearTriggers();
					break;
			}
		}
	}
}
