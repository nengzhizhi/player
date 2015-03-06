package cc.hl.view.video {

	/**
	 * 提供基于Http协议的点播视频源
	 * @author
	 * @Time
	 */

	public class HttpVideoProvider extends VideoProvider {
		
		private var nc:NetConnection;
		private var nss:Vector.<PartNetStream>;
		private var currentPlay:int = -1; //当前正在播放的partNetStream的索引号
		private var currentLoad:int = -1; //当前载入的partNetStream的索引号

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
		 * 载入指定的partNetStream
		 * @param index		partNetStream对的索引号
		 * @param startTime	载入的起始时间
		 * @param play		是否立即播放
		 * @return 空
		**/
		private function load(index:int, startTime:Number, play:Boolean=false):void{

			if(index >=0 && index < this._videoInfo.count){
				if(this.currentLoad != index){
					if(this.currentLoad != -1){ //当前有正在载入的partNetStream停止载入
						if(!this.nss[this.currentLoad].bufferFinish){
							this.nss[this.currentLoad].close();
						}
					}

					for(var i:int = 1; i <= index; i++){
						this.loadOffset = this.loadOffset + (this._videoInfo.vtimes[i] / 1000);
					}
					this.currentLoad = index;
				}

				ns = this.nss[this.currentLoad];

				if(startTime <= 1){
					this._videoInfo.getPartVideoInfo(function (arg1:PartVideoInfo):void{
						ns.load(arg1, play, startTime);
					}, index, 0);
				}
				else{
					if(this._videoInfo.useSecond){ //根据时间查找
						this._videoInfo.getPartVideoInfo(function (arg1:PartVideoInfo):void{
							ns.load(arg1, play, startTime);
						}, index, startTime);
					}
					else{ // 根据文件位置查找
						if (ns.canSearchByte()) {

						}
						else{

						}
					}
				}
			}
		}


		private function switchNs(index:int, startTime:Number=0):void{
			if(index >= this._videoInfo.count){
				return;
			}

			if(this.currentPlay != index){
				if(this.currentPlay != -1){
				}
			}

			var partNetStream:PartNetStream = this.nss[index];
			startTime = partNetStream.getRealSeekTime(startTime);

			if(this._videoInfo.disableSeekJump){
				if(partNetStream.ready){ //全部载入成功可以自由缓存

				} else { //否则从头开始播放
					this.load(index, 0, _playing);
				}
			} else {
				if(partNetStream.canSeek(startTime)){
					partNetStream.seek(startTime);

					if(this._playing){
						partNetStream.resume();
					}
				} else {
					this.load(index, startTime, this._playing);
				}
			}
		}


		/**
		 *  根据缓存池状态判断是否载入下一段流
		 *
		 */

		private function checkLoad():void{

		}
	}
}