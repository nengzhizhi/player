package cc.hl.model.platform {
	
	public class YoukuVideoInfo extends VideoInfo {

		private const YOUKU_PLAYER:String = "http://vgame.tv/assets/flash/yplugin.swf";

		private const YOUKU_GETPLAYLIST:String = "http://v.youku.com/player/getPlayList/VideoIDS/";
		private const YOUKU_GETFLVPATH:String = "http://k.youku.com/player/getFlvPath";

		private const YOUKU_CLEAR_TYPE:Array = ["hd3","hd2","mp4","flv"];

		private var youkuLoader:Loader;
		private var youkuData:Object;
		private var youkuPlayer:Object;

		private var _bakUrls:Array;
		private var _bakTimes:Array;

		public function YoukuVideoInfo(videoId:String=null){
			this._bakUrls = [];
			this._bakTimes = [];
			super(videoId, VideoType.YOUKU);
			this._useSecond = true;
		}

		override public function getPartVideoInfo(f:Function, index:int, startTime=0):void{
			if(index >= this._urlArray.length){
				$.jscall("console.log", "getPartVideoInfo参数错误!");
				index = 0;
			}
		}
	}
}