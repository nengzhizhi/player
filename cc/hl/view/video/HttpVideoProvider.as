package cc.hl.view.video {

	/**
	 * 提供基于Http协议的点播视频源
	 * @author
	 * @Time
	 */

	public class HttpVideoProvider extends VideoProvider {
		
		private var nc:NetConnection;
		private var nss:Vector.<PartNetStream>;

		public function HttpVideoProvider(arg1:VideoInfo){
			super(arg1);
			this.nc = new NetConnection();
			this.nc.connect(null);
			this.nss = new Vector.<PartNetStream>(_videoInfo.count);

			for(var i:int = 0; i < _videoInfo.count; i++){
				if( _videoInfo.fileType == "mp4"){
					this.nss[i] = new MP4PartNetStream(this.nc);
				}
				else{
					this.nss[i] = new FLVPartNetStream(this.nc);
				}
			}

			this.checkTimer = new Timer(5000);
			this.checkTimer.addEventListener(TimerEvent.TIMER, this.checkLoad);
		}

		/**
		 * 开始播放视频源
		 * @param	startTime	点播开始的时间
		 */

		override public function start(startTime:Number=0):void{

		}

		/**
		 *  根据缓存池状态判断是否载入下一段流
		 *
		 */

		private function checkLoad():void{

		}
	}
}