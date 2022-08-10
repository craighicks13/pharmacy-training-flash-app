﻿package imobile.sessions.explore.controller{	import flash.display.Sprite;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.utils.Timer;	import flash.events.TimerEvent;	import flash.events.MouseEvent;	import fl.transitions.Tween;	import fl.transitions.easing.*; 	import fl.transitions.TweenEvent;	import flash.utils.getDefinitionByName;		public class Messages extends Sprite	{				public static var MESSAGE_READY:String = "message_ready";				static private var _instance:Messages;				private var _inst:String;		private var _err:String;		private var _animateAlpha:Tween;		private var _clip:Sprite;		private var _time:Number = 0.5;		private var _messageDisplayTime:Number = 5;		private var _timer:Timer;						public function Messages(singletonEnforcer:SingletonEnforcer) { }				public static function getInstance():Messages 		{			if(Messages._instance == null) 			{				Messages._instance = new Messages(new SingletonEnforcer());			}			return Messages._instance;		}				public function instructionMessage(linkage:String):void		{			_inst = linkage;		}				public function errorMessage(linkage:String):void		{			_err = linkage;		}				public function showInstructions():void		{			newMessage(_inst);		}				public function showError():void		{			newMessage(_err);		}				public function clearMessages():void		{			_inst = undefined;			_err = undefined;		}				private function newMessage(linkage:String):void		{			clearMessage();			var MessagesClass:Class = getDefinitionByName(linkage) as Class;			_clip = new MessagesClass();			addChild(_clip);			setAnimation();		}				private function removeMessage():void		{			try			{				removeChild(_clip);			}catch(e:*) {}		}				private function setAnimation()		{			_animateAlpha = new Tween(_clip, "alpha", Strong.easeOut, 0, 1, _time, true);			_animateAlpha.addEventListener(TweenEvent.MOTION_FINISH, done, false, 0, true);			_animateAlpha.stop();			dispatchEvent(new Event(Messages.MESSAGE_READY));		}				private function done(e:TweenEvent):void		{			_animateAlpha.removeEventListener(TweenEvent.MOTION_FINISH, done);			setTimer(_messageDisplayTime);			stage.addEventListener(MouseEvent.MOUSE_DOWN, clearMessage, false, 0, true);			dispatchEvent(new Event("done"));		}				private function clearMessage(e:MouseEvent = undefined):void		{			trace("CLEARING MESSAGE BECAUSE OF A CLICK");			stage.removeEventListener(MouseEvent.MOUSE_DOWN, clearMessage);			clearTimer();			removeMessage();		}				public function animate():void		{			_animateAlpha.start();		}				private function timerDone(e:TimerEvent):void		{			clearTimer();			removeMessage();		}				private function clearTimer():void		{			if(_timer && _timer.running)			{				_timer.stop();				_timer.removeEventListener("timer", timerDone);			}		}				private function setTimer(seconds:int):void		{			_timer = new Timer(seconds * 1000, 1);			_timer.addEventListener(TimerEvent.TIMER, timerDone, false, 0, true);			_timer.start();		}	}}class SingletonEnforcer{}