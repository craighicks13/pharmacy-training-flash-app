package imobile.interfaces {
	public interface ILessonMovies {
		function getID():int;
		function getLabel():String;
		function getShowFile():String;
		function getGuideFile():String;
		function getExploreFile():String;
		function setID(id:int):void;
		function setLabel(label:String):void;
		function setShowFile(show:String):void;
		function setGuideFile(guide:String):void;
		function setExploreFile(explore:String):void;
	}
}
