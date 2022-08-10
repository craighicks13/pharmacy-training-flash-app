package com.criticalfusion.training.player.model
{
	import flash.utils.Dictionary;

	public class TextItems
	{
		protected var items:Dictionary;
		public function TextItems()
		{
			items = new Dictionary();
		}
		
		public function addItem(id:String, content:String):void
		{
			items[id] = content;
		}
		
		public function getItem(id:String):String
		{
			return items[id];
		}
	}
}