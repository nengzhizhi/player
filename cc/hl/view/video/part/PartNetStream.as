/**
 * 点播视频源子码流的基类。
 * 主要用于控制子码流的载入，如果载入的同时需要直接播放，则将startPlay设为true，同时打开声音开关。
 * 否则只调用netstream.play(streamUrl)。
**/

package cc.hl.view.video.part {
	

	public class PartNetStream extends NetStream {

		protected var startPlay:Boolean = false; //是否开始播放，主要用于声音的开关
		protected var _meta:Object;
		protected var _buffering:Boolean = false; //是否正在缓存
		protected var _bufferFinish:Boolean = false;
		protected var _partVideoInfo:PartVideoInfo; //子码流信息
		protected var _ready:Boolean = false; // 码流是否全部载入
		protected var _bakSound:SoundTransform; // 用于开关声音时存储上次音量


		public function PartNetStream(arg1:NetConnection){
			this._bakSound = new SoundTransform(1);
			super(arg1);
			this.client = {onMetaData:this.onMetaData}; //子类需要重载this.onMetaData
			this.addEventListener(NetStatusEvent.NET_STATUS, this.onStatus);
		}

		public function get ready():Boolean{
			return (this._ready);
		}


		protected function onStatus(arg1:NetStatusEvent):void{
			switch (arg1.info.code){
				case "NetStream.Play.Start":
					break;
				case "NetStream.Buffer.Full":
					this._buffering = false;
					break;
				case "NetStream.Buffer.Empty":
					break;
			}
		}

		/**
		 * 载入视频流
		 * @param arg1	子码流对应信息
		 * @param arg2	是否开始播放
		 * @param arg3	播放的开始时间
		 * @return void
		**/
		public function load(arg1:PartVideoInfo, arg2:Boolean=false, arg3:Number=0):void{
			this.close();//关闭当前流
			this._partVideoInfo = arg1;
			this.startPlay = arg2;
			this.expectStartTime = arg3;

			$.jscall("console.log", "Part " + arg1.index + "start load");
			play(arg1.url);
		}

		/**
		 * 关闭当前流，并重置某些标记值
		 * @param null
		 * @return void
		**/

		orverride public function close():void{
			super.close();
			this.reset();
		}

		protected function reset():void{
			this._ready = false;
			this._bufferFinish = false;
			this._buffering = true;
		}

		/**
		 * 码流全部载入成功
		**/
		protected function onNsReady():void{
			if(!this._ready){
				this._buffering = false;
				this._ready = true;
				
				if(this.startPlay){
					super.soundTransform = this._bakSound;
				}
				else{
					pause();
				}
				dispatchEvent(new Event("NS_READY"));
			}
		}

		/**
		 * 设置音量
		**/
		orverride public function set soundTransform(arg1:SoundTransform):void{
			this._bakSound = arg1;

			if(this.ready){
				super.soundTransform = arg1;
			}
		}
	}
}