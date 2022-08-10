package com.criticalfusion.training.player
{
	import com.criticalfusion.training.player.controllers.LessonManager;
	import com.criticalfusion.training.player.controllers.LessonsController;
	import com.criticalfusion.training.player.controllers.MenuController;
	import com.criticalfusion.training.player.events.AutoLoadEvent;
	import com.criticalfusion.training.player.events.OpenCategoryEvent;
	import com.criticalfusion.training.player.events.SetTextEvent;
	import com.criticalfusion.training.player.views.AudioTextButton;
	import com.criticalfusion.training.player.views.BackButton;
	import com.criticalfusion.training.player.views.HelpButton;
	import com.criticalfusion.training.player.views.HelpScreen;
	import com.criticalfusion.training.player.views.Loading;
	import com.criticalfusion.training.player.views.MainMenu;
	import com.criticalfusion.training.player.views.PauseButton;
	import com.criticalfusion.training.player.views.PlayButton;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import gs.TweenLite;
	import gs.easing.Strong;
	
	import imobile.controller.iSlider;
	
	public class ApplicationMain extends MovieClip 
	{
		public var main_menu:MainMenu;
		public var page_info:TextField;
		
		private var _syncTimer:Timer;
		private var _loading:Loading;
		private var _errorMessage:MovieClip;
		
		protected var page_status:Point;
		protected var _helpScreen:HelpScreen;
		protected var lesson_loaded:Boolean = false;
		
		public function ApplicationMain() 
		{
			this.cacheAsBitmap = true;
			init();
		}
		
		public function loadMenues(e:Event):void 
		{
			LessonManager.instance.removeEventListener(LessonManager.LESSONS_READY, loadMenues);
			MenuController.instance.addMenuItems(LessonManager.instance.lessons);
		}
		
		protected function onAutoLoadLesson(event:AutoLoadEvent):void
		{
			LessonManager.instance.removeEventListener(AutoLoadEvent.AUTOLOAD_LESSON, onAutoLoadLesson);
			LessonsController.instance.getLesson(event.lesson);
		}
		
		protected function loadLesson(e:Event):void
		{
			//checkMenu(e.target);
			displayLoading();
		}
		
		public function lessonLoaded(e:Event):void 
		{
			lesson_loaded = true;
			LessonManager.instance.menuFromScenes(LessonsController.instance.scenes);
			removeLoading();
			lessonContainer.addChildAt(LessonsController.instance.clip, 0);
			showHomeScreen(false);
			//nav_panel.enableButtons();
			LessonsController.instance.rewind();
			if(LessonsController.LESSON_TYPE == "show") doPlay(); else doStop();
			setSyncTimer();
		}
		
		protected function displayLoading():void
		{
			_loading.reset();
			lessonContainer.addChild(_loading);
		}
		
		protected function removeLoading():void
		{
			lessonContainer.removeChild(_loading);
		}
		
		protected function displayError():void
		{
			removeLoading();
		//	_errorMessage = new error_message();
			addChild(_errorMessage);
			_errorMessage.addEventListener(MouseEvent.CLICK, removeError, false, 0, true);
		}
		
		protected function removeError(e:Event = undefined):void
		{
			_errorMessage.removeEventListener(MouseEvent.CLICK, removeError);
			removeChild(_errorMessage);
		}
		
		protected function removeLesson(e:Event):void 
		{
			//LessonsController.instance.removeEventListener(LessonsController.REMOVE_LESSON, removeLesson);
			try {
				doRemove();
			}catch(e:RangeError) { }
			if(e == null) showHomeScreen(true);
		}
		
		protected function lessonError(e:Event):void
		{
			showHomeScreen(true);
			displayError();
			//Alert.show("There was an error loading the selected file.");
		}
		
		protected function unloadCurrentLesson():void 
		{
			if(!lesson_loaded) return;
			LessonsController.instance.stop();
			removeLesson(null);
		}
		/*
		public function toggleMenu():void 
		{
			if(main_menu.STATUS == 'OPENED')
				main_menu.closeMenu();
			else
				main_menu.openMenu();
		}
		*/
		protected function switchType(param:String):void
		{
			LessonsController.instance.changeType(param.toLowerCase());
		}
		
		protected function showHomeScreen(param:Boolean):void
		{
		//	homeScreen.visible = param;
		}
		
		protected function doRemove():void
		{
			lessonContainer.removeChildAt(0);
			LessonsController.instance.unloadLesson();
			unSetSyncTimer();
			//nav_panel.disableButtons();
		}
		
		protected function doPlay():void
		{
			LessonsController.instance.play();
			play_button.visible = false;
			pause_button.visible = true;
			//nav_panel.showPlay(false);
		}
		
		protected function doStop():void
		{
			LessonsController.instance.stop();
			play_button.visible = true;
			pause_button.visible = false;
			//nav_panel.showPlay(true);
		}
		/*
		public function checkMenu(target:Object):void 
		{
			// CHECK TO SEE IF THE POPUP MENU IS OPEN AND CLOSE IT IF THE 
			if(main_menu.STATUS == 'OPENED' && target != "session_btn") toggleMenu();
		}
		*/
		public function onNavigationClicked(e:MouseEvent):void 
		{
			//checkMenu(e.target.name); // CLOSE MENU IF OPEN
			// RETURN ON NAV PANEL ITEMS WE DON'T WANT TO HEAR FROM
			if(e.target.name == "nav_panel" || e.target.name == "slider_bar" || e.target.name == "bar" || !e.target.ENABLED) return;
			// FIND OUT WHICH NAV ITEM WAS CLICKED AND PREFORM THE APPROPRIATE ACTION
			switch(getQualifiedClassName(e.target).split("::")[1]) 
			{
				case PlayButton.NAME:
					doPlay();
					break;
				case PauseButton.NAME:
					doStop();
					break;
				case ForwardButton.NAME:
					LessonsController.instance.nextScene();
					break;
				case BackButton.NAME:
					LessonsController.instance.prevScene();
					break;
				case AudioTextButton.NAME:
					textbox.open = !textbox.open;
					var transform:SoundTransform = new SoundTransform();
					if(textbox.open)
					{
						transform.volume = 0;
						TweenLite.to(textbox, .5, {y:nav_panel.y, ease:Strong.easeOut, overwrite:2});
						main_menu.closeMenu();
					}
					else
					{
						transform.volume = 1;
						TweenLite.to(textbox, .5, {y:nav_panel.y + 372, ease:Strong.easeOut, overwrite:2});
						main_menu.openMenu();
					}
					SoundMixer.soundTransform = transform;
					break;
				case HelpButton.NAME:
					LessonsController.instance.pause();
					_helpScreen = new HelpScreen();
					_helpScreen.x = stage.stageWidth * .5;
					_helpScreen.y = stage.stageHeight * .5;
					_helpScreen.addEventListener(HelpScreen.CLOSE_HELP, onCloseHelp, false, 0, true);
					addChild(_helpScreen);
					break;
				case "SLIDER":
					// TRIGGER UPDATE MOVIE
					break;
				case "GUIDE":
				case "EXPLORE":
				case "SHOW":
					switchType(e.target.TYPE);
					break;
				default:
					trace("clicked: " + e.target + " : " + e.target.name);
					break;
			}
		}
		
		protected function onCloseHelp(event:Event):void
		{
			_helpScreen.removeEventListener(HelpScreen.CLOSE_HELP, onCloseHelp);
			removeChild(_helpScreen);
			_helpScreen = null;
			LessonsController.instance.play();
		}
		/*
		protected function toggleMenuClicked(event:MouseEvent):void
		{
			toggleMenu();
		}
		*/
		protected function sliderReleased(e:Event):void
		{
			setSyncTimer();
			iSlider.getInstance().removeEventListener(iSlider.DROPPED, sliderReleased);
			iSlider.getInstance().addEventListener(iSlider.DRAGGING, sliderPressed, false, 0, true);
			LessonsController.instance.updatePos(iSlider.getInstance().percentPlayed);
		}
		
		protected function sliderPressed(e:Event):void
		{
			unSetSyncTimer();
			iSlider.getInstance().removeEventListener(iSlider.DRAGGING, sliderPressed);
			iSlider.getInstance().addEventListener(iSlider.DROPPED, sliderReleased, false, 0, true);
			LessonsController.instance.pause();
		}
		
		protected function init():void 
		{
			LessonManager.instance.loadLessons();
			LessonManager.instance.addEventListener(LessonManager.LESSONS_READY, loadMenues, false, 0, true);
			LessonManager.instance.addEventListener(AutoLoadEvent.AUTOLOAD_LESSON, onAutoLoadLesson, false, 0, true);
			
			LessonsController.instance.addEventListener(LessonsController.LESSON_LOAD, loadLesson, false, 0, true);
			LessonsController.instance.addEventListener(LessonsController.LESSON_LOADED, lessonLoaded, false, 0, true);
			LessonsController.instance.addEventListener(LessonsController.LESSON_ERROR, lessonError, false, 0, true);
			LessonsController.instance.addEventListener(LessonsController.REMOVE_LESSON, removeLesson, false, 0, true);
			LessonsController.instance.addEventListener(SetTextEvent.SET_TEXT_COMMAND, onSetText, false, 0, true);
			LessonsController.instance.addEventListener(LessonsController.CHANGE_STATE, onChangeState, false, 0, true);
			LessonsController.instance.addEventListener(OpenCategoryEvent.OPEN_CATEGORY, onOpenCategory, false, 0, true);
			LessonsController.instance.addEventListener(LessonsController.CLIP_COMPLETED, onClipCompleted, false, 0, true);
			
			iSlider.getInstance().setup(bar,slider_bar,scroll_thumb);
			iSlider.getInstance().addEventListener(iSlider.DRAGGING, sliderPressed, false, 0, true);
			
			_loading = new Loading();
			
			// LISTENERS FOR THE MENU CONTROLS
			audio_text_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			forward_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			back_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			help_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			pause_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			play_button.addEventListener(MouseEvent.CLICK, onNavigationClicked, false, 0, true);
			//toggle_menu.addEventListener(MouseEvent.CLICK, toggleMenuClicked, false, 0, true);
			main_menu.unloadCurrentLesson = unloadCurrentLesson;
			
			textbox.open = false;
			textbox.y = nav_panel.y + textbox.height;
			
			page_info.autoSize = TextFieldAutoSize.LEFT;
			page_info.text = "";
			
			_syncTimer = new Timer(100);
		}
		
		protected function setSyncTimer():void
		{
            _syncTimer.addEventListener(TimerEvent.TIMER, syncLessonSlider, false, 0, true);
            _syncTimer.start();
		}
		
		protected function unSetSyncTimer():void
		{
            _syncTimer.removeEventListener(TimerEvent.TIMER, syncLessonSlider);
            _syncTimer.stop();
		}
		
		protected function onSetText(event:SetTextEvent):void
		{
			textbox.setAppText(LessonManager.instance.getTextItem(event.code));
		}
		
		protected function onChangeState(event:Event):void
		{
			LessonsController.PLAY_STATUS == "play" ? doPlay() : doStop();
		}
		
		protected function onOpenCategory(event:OpenCategoryEvent):void
		{
			main_menu.openCategory(event.category_id);
		}
		
		final protected function onClipCompleted(event:Event):void
		{
			main_menu.nextLesson();
		}
		
		public function syncLessonSlider(e:TimerEvent):void
		{
			page_status = LessonsController.instance.pageStatus;
			page_info.text = "Page " + page_status.x.toString() + " of " + page_status.y.toString();
			iSlider.getInstance().updatePos(e, LessonsController.instance.percentPlayed);
			e.updateAfterEvent();
		}
	}
}
