﻿package imobile.sessions.view {	import flash.display.MovieClip;	import imobile.sessions.controller.BubbleAnimation;		public class BubbleUp extends MovieClip	{		private static var DIRECTION:String = "up";				public function BubbleUp() 		{			alpha = 0;			BubbleAnimation.getInstance().setAnimation(this, DIRECTION);			BubbleAnimation.getInstance().animate();		}	}}