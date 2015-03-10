package cc.hl.model.video {
	public class VideoPool {

		private var _providers:Array;
		private var _videoInfos:Array;
		private var _mainVideoProvider:int;
		private var _subVideo

		public static var _instance:VideoPool = null;

		public function VideoPool(){
			if(this._instance != null){
				throw new Error("该对象只能存在一个,请改用getInstance()获取");
			}
			else{
				return;
			}
		}

		public static function get instance() : VideoPool{
			if(this._instance == null){
				this._instance = new VideoPool();
			}
			return this._instance;
		}

		public function load(obj:Object):void{
			this._providers = [];
			this._videoInfos = [];

			for(var i:int = 0; i<obj.length; i++) {
				switch (obj[i].type){
					case VideoType.YOUKU:
						this._videoInfos[i] = new YoukuVideoInfo(obj[i].vid);
						this._videoInfo.init();
					break;
				}

				this._videoInfos[i].addEventListener(Event.COMPLETE, function(e:Event):void{
					var arguments:* = arguments;
					_videoInfos[i].removeEventListener(Event.COMPLETE, arguments.callee);
					if (_videoInfos[i].fileType == "live"){
						_providers[i] = null;
					}
					else{
						_providers[i] = new HttpVideoProvider(_videoInfos[i]);
					}
					_providers[i].start(0);
				});				
			}
		}
	}
}