package imobile.model 
{
	import imobile.interfaces.ILessonMovies;
	
	public class Lesson implements ILessonMovies 
	{
		private var _label:String;
		private var _show:String;
		private var _guide:String;
		private var _explore:String;
		private var _id:int;
		public var subsection:Boolean = false;
		
		public function Lesson() { }
		
		public function getID():int 
		{
			return _id;
		}
		
		public function getLabel():String 
		{
			return _label;
		}
		
		public function getShowFile():String 
		{
			return _show;
		}
		
		public function getGuideFile():String 
		{
			return _guide;
		}
		
		public function getExploreFile():String 
		{
			return _explore;
		}
		
		public function setID(_id:int):void 
		{
			this._id = _id;
		}
		
		public function setLabel(_label:String):void 
		{
			this._label = _label;
		}
		
		public function setShowFile(_show:String):void 
		{
			this._show = _show;
		}
		
		public function setGuideFile(_guide:String):void 
		{
			this._guide = _guide;
		}
		
		public function setExploreFile(_explore:String):void 
		{
			this._explore = _explore;
		}
	}
}
