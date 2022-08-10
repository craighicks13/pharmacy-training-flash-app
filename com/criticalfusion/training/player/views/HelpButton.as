package com.criticalfusion.training.player.views 
{
	import com.criticalfusion.training.player.controllers.StandardButton;
	
	public class HelpButton extends StandardButton
	{
		public static const NAME:String = "HelpButton";
		public function HelpButton() 
		{
			this.cacheAsBitmap = true;
			this.visible = false;
		}
	}
}
