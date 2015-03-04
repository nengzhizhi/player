package cc.hl.view.video {

	import util.*;

	/**
	 *
	 * 视频提供类，用于从VideoInfo中读取视频流
	 * @author XiongYe
	 * @Time 
	 *
	**/
	public class VideoProvider extends Sprite implements IVideoProvider {
		
		protected var _video;//Video类或者是stage.stageVideos
		protected var _useStageVideo:Boolean;//是否使用stage video做加速
		protected var _videoInfo:VideoInfo;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _ratioType:int = 0;//当前video的长宽比
		protected var _playing:Boolean;


		public function VideoProvider(arg1:VideoInfo){
			this._videoInfo = arg1;

			this._useStageVideo = false;//默认使用normal video
			this._video = new Video();
			this._video.smoothing = true;
			addChild(this._video);

			GlobalData.STAGE.addEventListener("stageVideoAvailability", this.onStageVideoAvailability);
		}



		/**
		 *
		 * 获取当前码流，如果是点播可能存在多个，直播只有一个。子类需要重载
		 * @return	NetStream
		 *
		**/
		protected function get ns():NetStream(){
			return (null);
		}


		/**
		 *
		 * 当stage video 可用时切换video
		 *
		**/
		protected function onStageVideoAvailability(_arg1):void{
			$.jscall("console.log","hardware accelerate availability: "+_arg1.availability);
			this.switchVideo(_arg1.availability == "available");
		}

		/**
		 *
		 * 根据硬件情况切换video类型
		 * @param	tryHardwareAccelerate:是否使用stage.stageVideos开启硬件加速
		 * @return	void
		 *
		**/
		protected function switchVideo(tryHardwareAccelerate:Boolean):void{
			if(tryHardwareAccelerate && (GlobalData.STAGE.stageVideos == null || GlobalData.STAGE.stageVideos.length == 0)){
				return;
			}

			if(this._useStageVideo != tryHardwareAccelerate){
				this._useStageVideo = tryHardwareAccelerate;

				if(tryHardwareAccelerate) {
					$.jscall("console.log","use stage video!");
					if(this._video && contains(this._video)){
						removeChild(this._video);
						this._video.clear();
						this._video = null;
					}
					//FIXME 修改此处 支持多机位
					this._video = GlobalData.STAGE.stageVideos[0];
					this._video.attachNetStream(this.ns);
				}
				else {
					$.jscall("console.log","use normal video!");
					this._video = new Video();
					this._video.smoothing = true;
					this._video.attachNetStream(this.ns);
					addChild(this._video);
				}

				this.resize(this._width, this._height);
			}
		}


		public function resize(_arg1:Number, _arg2:Number):void{
			this._width = _arg1;
			this._height = _arg2;
			this.setVideoRatio(this._ratioType);
		}

		public function setVideoRatio(ratioType:int):void{
			this._ratioType = ratioType;

			if(this._video == null){
				return;
			}

			var _local2:int = ((((this._video.videoWidth) || (((("meta" in this.ns)) && (this.ns["meta"].width))))) || (this._width));
			var _local3:int = ((((this._video.videoHeight) || (((("meta" in this.ns)) && (this.ns["meta"].height))))) || (this._height));

			switch(ratioType){
				case 0:
					break;
				case 1:
					_local3 = ((_local2 * 3) / 4);
					break;
				case 2:
					_local3 = ((_local2 * 9) / 16);
					break;
				case 3:
					_local2 = this._width;
					_local3 = this._height;
					break;
			}

			var _local4:Rectangle = Util.getCenterRectangle(new Rectangle(0, 0, this._width, this._height), new Rectangle(0, 0, _local2, _local3));
				if ((this._video is StageVideo)){
				this._video.viewPort = _local4;
			} else {
				this._video.x = _local4.x;
				this._video.y = _local4.y;
				this._video.width = _local4.width;
				this._video.height = _local4.height;
			}
		}


		/**
		 * 开始载入视频流
		 * @param startTime:开始播放的时间，如果是直播值为0
		 */
		public function start(startTime:Number=0):void{
		}

		public function get playing():Boolean{
			return this._playing;
		}

		public function set playing(arg1:Boolean):void{
			if(arg1 != this._playing){
				this._playing = arg1;
			}

			if(this._playing){
				this.ns.resume();
			}
			else{
				this.ns.pause();
			}
		}
	}
}