package imobile.sessions.explore.view 
{
	import imobile.sessions.controller.InteractionController;
	import imobile.sessions.explore.controller.Messages;
	import imobile.sessions.explore.view.LessonBase;
	import flash.display.MovieClip;
	
	public class Lesson_01 extends LessonBase
	{
		
		public function Lesson_01()	{ getInstance(); }
		
		public override function updateAppStatus():void
		{
			switch(currentFrame)
			{
				case 2:
				case 3:
				case 4:
				case 5:
					Messages.getInstance().instructionMessage("viz01_01");
					break;
				case 7:
				case 8:
				case 9:
					Messages.getInstance().instructionMessage("viz01_05");
					break;
				
			}
			getCurrentFunctionality();
		}
		
		public override function getCurrentFunctionality():void
		{
			_currentFrame = currentFrame;
			if(_multiSteps == _step) _multiSteps = 0;
			switch(currentFrame + (_step/10))
			{
				case 1:
					_multiSteps = 1;
					Messages.getInstance().instructionMessage("viz01_01");
					Messages.getInstance().showInstructions();
					InteractionController.getInstance().addTrigger("start_butt", 37, 752, true);
					break;
				case 1.1:
					Messages.getInstance().errorMessage("viz01_02");
					InteractionController.getInstance().addPopUpTrigger("start_menu", 0, 616, "START_APP");
					break;
				case 2:
					Messages.getInstance().errorMessage("viz01_03");
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true);
					break;
				case 3:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addTrigger("erd_butt", 310, 752, true);
					break;
				case 4:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addTrigger("imobile_butt", 154, 752, true);
					break;
				case 5:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addTrigger("display_hide", 30, 88, true, false);
					break;
				case 6:
					Messages.getInstance().clearMessages();
					Messages.getInstance().instructionMessage("viz01_05");
					Messages.getInstance().showInstructions();
					InteractionController.getInstance().clearTriggers();
					InteractionController.getInstance().setTimer(1);
					break;
				case 7:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addPopUpTrigger("new_event", 170, 208, "ACKNOWLEDGE");
					break;
				case 8:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addTrigger("enr_butt", 77, 88);
					break;
				case 9:
					Messages.getInstance().errorMessage("viz01_01");
					InteractionController.getInstance().addTrigger("send_msg", 521, 455);
					break;
				case 10:
					Messages.getInstance().errorMessage("viz01_07");
					InteractionController.getInstance().addTrigger("event_list", 2, 453);
					break;
				case 11:
					Messages.getInstance().errorMessage("viz01_07a");
					InteractionController.getInstance().addScrollTrigger("mainWindow", 5, 125, "window");
					break;
				default:
					InteractionController.getInstance().clearTriggers();
					break;
			}
		}
	}
}
