package cc.hl.model.video.base {
	
	public class VideoInfo{

		protected var _vid:String;
		protected var _type:String; //视频源类型
		protected var _fileType:String; //视频文件类型flv或者mp4
		protected var _useSecond:Boolean;//
		protected var _urlArray:Array;
		protected var _vtimems:Array;


		public function VideoInfo(videoId:String, videoType:String){
			this._vid = videoId;
			this._type = videoType;
		}


		/**
		 * 载入视频信息。
		 * 需要重载
		**/
		protected function load():void{
			return;
		}

		/**
		 * 载入指定的partNetStream需要的VideoInfo,获得videoInfo后让partNetStream回调
		 * @param f	partNetStream的回调函数，从获取的videoInfo中载入视频
		 * @param index
		 * @param startTime
		 * @return 空
		**/
		public function getPartVideoInfo(f:Function, index:int, startTime:Number=0):void{
			return;
		}
		/*
		public function getPartVideoInfo(f:Function, index:int, startTime:Number=0):void{
			if(index >= this._urlArray.length){
				$.jscall("console.log", "getPartVideoInfo参数错误");
				index = 0;
			}

			var partVideoUrl:String = this._urlArray[index];
			var partVideoTime:String = this._vtimems[index + 1] / 1000;

			if(this._useSecond && (partVideoTime - startTime) < 10){
				startTime = partVideoTime - 10;
			}

			if(startTime > 0){
				partVideoUrl = Util.addUrlParam(partVideoUrl, "start", int(startTime));
			}

			var partVideoInfo:PartVideoInfo = new PartVideoInfo();
			f(partVideoInfo);
		}
		*/
	}
}