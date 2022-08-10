package com.criticalfusion.training.player.views
{
	import com.criticalfusion.training.player.controllers.LessonManager;
	import com.criticalfusion.training.player.controllers.LessonsController;
	import com.criticalfusion.training.player.controllers.MenuController;
	import com.criticalfusion.training.player.events.ScrollBarEvent;
	import com.criticalfusion.training.player.model.Category;
	import com.criticalfusion.training.player.model.Lesson;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gs.TweenLite;
	import gs.easing.Strong;
	
	import imobile.controller.OpenCloseMenu;
	
	public class MainMenu extends MovieClip
	{
		protected var _status:String;
		protected var _control:OpenCloseMenu;
		protected var _openY:Number = 450;
		protected var _closeY:Number = 565;
		protected var currentLesson:MenuHeaderItem;
		
		public var bg:MovieClip;
		public var scrollbar:ScrollBar;
		public var masker:Sprite;
		public var content:MovieClip;
		public var unloadCurrentLesson:Function;
		
		public var headerList:Vector.<MenuHeaderItem> = new Vector.<MenuHeaderItem>();
		
		public function MainMenu() 
		{
			
			headerList.push(
								content.item0,
								content.item1, 
								content.item2,
								content.item3,
								content.item4,
								content.item5,
								content.item6,
								content.item7,
								content.item8,
								content.item9,
								content.item10,
								content.item11,
								content.item12
							);
			
			_control = new OpenCloseMenu(this, this.y, _closeY);
			content.mask = masker;
			if(content.height < masker.height) scrollbar.visible = false;
			this.gotoAndStop(1);
			scrollbar.addEventListener(ScrollBarEvent.VALUE_CHANGED, scrollChange, false, 0, true);
			//this.y = _control.closeY;
			MenuController.instance.addEventListener(MenuController.GOT_LESSONS, addMenuItems);
		}
		
		public function openMenu():void 
		{
			_status = OpenCloseMenu.OPENED;
			TweenLite.to(masker, .3, {height:658, ease:Strong.easeOut, overwrite:2, onComplete:invalidate});
			TweenLite.to(scrollbar, .3, {sbHeight:654, ease:Strong.easeOut, overwrite:2});
			//_control.openMenu();
		}
		
		public function closeMenu():void 
		{
			_status = OpenCloseMenu.CLOSED;
			TweenLite.to(masker, .3, {height:284, ease:Strong.easeOut, overwrite:2, onComplete:invalidate});
			TweenLite.to(scrollbar, .3, {sbHeight:280, ease:Strong.easeOut, overwrite:2});
			//_control.closeMenu();
		}
		
		public function invalidate():void
		{
			scrollbar.visible = (content.height > masker.height);
			if(!scrollbar.visible)
			{
				scrollbar.reset();
				TweenLite.to(content, .5, {y:0, ease:Strong.easeOut});
			}
			else
			{
				TweenLite.to(content, .5, {y:-scrollbar.percent * (content.height - masker.height), ease:Strong.easeOut});
			}
		}
		
		public function addMenuItems(e:Event):void 
		{
			//var mi:Array = MenuController.instance.lessons;
			var mi:Vector.<Category> = LessonManager.instance.categories;
			for(var i:int = 0; i < mi.length; i++) 
			{
				addCategoryItems(mi[i]);
			}
			onAdjustMenu();
			var prevItem:MenuHeaderItem;
			var item:MenuHeaderItem;
			for(i = 0; i < headerList.length; i++)
			{
				headerList[i].onMenuToggled = onAdjustMenu;
				headerList[i].onSectionSelected = onSectionSelected;
			}
			invalidate();
		}
		
		public function openCategory(value:String):void
		{
			var num:uint = headerList.length;
			while(num-- > 0)
			{
				if(headerList[num].name == value)
				{
					headerList[num].openMenu();
					break;
				}
			}
		}
		
		public function nextLesson():void
		{
			var num:uint = headerList.length - 1;
			while(num-- > 0)
			{
				if(currentLesson == headerList[num])
				{
					currentLesson = headerList[num + 1];
					currentLesson.openMenu();
					LessonsController.instance.setupLessonScene(currentLesson.file, currentLesson.sublist[0].scene);
				}
			}
		}
		
		protected function onAdjustMenu():void
		{
			var prevItem:MenuHeaderItem;
			var item:MenuHeaderItem;
			for(var i:int = 0; i < headerList.length; i++)
			{
				item = headerList[i];
				if(prevItem)
				{
					
					headerList[i].y = prevItem.open ? prevItem.y + prevItem.openHeight : prevItem.y + 43;
				}
				prevItem = item;
			}
			invalidate();
		}
		
		protected function addCategoryItems(category:Category):void
		{
			for(var i:int = 0; i < category.sublist.length; i++) 
			{
				addItem(i, category.sublist[i], content[category.id]);
				content[category.id].file = category.file;
			}
		}
		
		protected function scrollChange(event:ScrollBarEvent):void
		{
			content.y = -event.scroll_percent * (content.height - masker.height);
		}
		
		protected function addItem(num:int, session:Lesson, category:MenuHeaderItem):void 
		{
			var mi:MenuItem = new MenuItem();
			mi.label = session.label;
			mi.scene = session.scene;
			mi.name = "lesson" + String(num);
			mi.subsection = session.subsection;
			mi.addEventListener(MenuItem.SESSION_SELECTED, menuItemClicked, false, 0, true);
			category.addMenuItem(mi);
			
			_control.openY = _closeY - (mi.height + mi.y) - 10;
			//bg.height = (mi.height + mi.y) + 15;
		}
		
		protected function onSectionSelected(value:String):void
		{
			unloadCurrentLesson();
			LessonsController.instance.getLesson(value);
		}
		
		protected function menuItemClicked(e:Event):void 
		{
			currentLesson = MenuHeaderItem(e.target.parent);
			LessonsController.instance.setupLessonScene(currentLesson.file, MenuItem(e.target).scene);
		}
		
		public function get STATUS():String 
		{
			return _status;
		}
	}
}
