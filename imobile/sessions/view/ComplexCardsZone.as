﻿package imobile.sessions.view{	import flash.display.MovieClip;	import flash.events.Event;	import flash.text.TextField;		public class ComplexCardsZone extends MovieClip	{		private var _zone:Object;		private var _currentZone:int;		private var _currentTitle:String;		private var _mustSelect:int;				public function ComplexCardsZone() 		{			addEventListener(Event.ADDED_TO_STAGE, setupInstance, false, 0, true);		}				private function populateComboBox(cb:Object, list:Array):void		{			for(var num = 0; num < list.length; num++)			{				cb.addItem(list[num]);			}		}				private function zoneComboBoxSetup()		{			_zone = cb_zone;			_zone.rowCount = 11;			_zone.addEventListener("change", zoneSelected, false, 0, true);			var zoneList:Array = [								  {label:"--\>Choose a Complex Card\<--",data:0},								  {label:"Master Map Zone " + _currentZone,data:1},								  {label:"Complex Card 1",data:2},								  {label:"Complex Card 2",data:3},								  {label:"Complex Card 3",data:4},								  {label:"Complex Card 3A",data:5},								  {label:"Complex Card 4",data:6},								  {label:"Complex Card 4A",data:7},								  {label:"Complex Card 4B",data:8},								  {label:"Complex Card 4C",data:9},								  {label:"Complex Card 4D",data:10},								  {label:"Complex Card 5",data:11}								 ];			populateComboBox(_zone,zoneList);		}				private function zoneSelected(e:Event):void		{			removeGoListener();			if(_mustSelect)			{				if(_mustSelect == e.target.selectedItem.data)					setGoListener();				else					removeGoListener();			}			else if(e.target.selectedItem.data)				setGoListener();		}				private function setGoListener():void		{			CLICK_GO_ZONE.addEventListener("click", regionSelected, false, 0, true);			dispatchEvent(new Event("ZONE_SELECTED"));		}				private function removeGoListener():void		{			try			{				CLICK_GO_ZONE.removeEventListener("click", regionSelected);			}catch(e:*) { }		}				private function regionSelected(e:Event):void		{			removeGoListener();			dispatchEvent(new Event("selected"));		}				public function set zoneTitle(s:String):void		{			_currentTitle = zoneLabel.text = s.toUpperCase();		}				public function set setZone(n:int):void		{			_currentZone = n;			zoneComboBoxSetup();		}				private function setupInstance(e:Event):void		{			removeEventListener(Event.ADDED_TO_STAGE, setupInstance);			zoneLabel.text = _currentTitle;		}	}}