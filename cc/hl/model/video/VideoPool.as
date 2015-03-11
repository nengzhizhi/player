package cc.hl.model.video {
	
	import flash.events.*;
	import flash.utils.*;

	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import cc.hl.model.video.base.*;
	import cc.hl.model.video.platform.*;
	
	public class VideoPool {

		private var _providers:Array;
		private var _videoInfos:Array;
		private var _mainVideoIndex:int = 0;
		private var _cameraVideoIndex:int = 0;
		private var _playedSeconds:Number = 0;
		private var sendTimer:Timer;

		public static var _instance:VideoPool = null;

		public function VideoPool(){
			if(_instance != null){
				throw new Error("该对象只能存在一个,请改用getInstance()获取");
			}
			else{
				return;
			}
		}

		public static function getInstance() : VideoPool{
			if(_instance == null){
				_instance = new VideoPool();
			}
			return _instance;
		}

		public function load(obj:Object):void{
			this._providers = [];
			this._videoInfos = [];

			for(var i:int = 0; i < obj.length; i++) {
				
				switch (obj[i].videoType){
					case VideoType.YOUKU:
						this._videoInfos[i] = new YoukuVideoInfo(obj[i].vid, i);
						this._videoInfos[i].init();
					break;
				}
				this._videoInfos[i].addEventListener(Event.COMPLETE, function(e:Event):void{
					var arguments:* = arguments;
					_videoInfos[e.target.poolIndex].removeEventListener(Event.COMPLETE, arguments.callee);
					
					if (_videoInfos[e.target.poolIndex].fileType == "live"){
						_providers[e.target.poolIndex] = null;
					}
					else{
						_providers[e.target.poolIndex] = new HttpVideoProvider(_videoInfos[e.target.poolIndex]);
					}
					_providers[e.target.poolIndex].start(0);
			
					if(e.target.poolIndex == 0){
						Facade.getInstance().sendNotification(Order.ControlBar_VideoInfo_Request, 
															{"videoSeconds":_providers[e.target.poolIndex].videoLength});
						Facade.getInstance().sendNotification(Order.Video_Start_Request, {"index":0});
						
						sendTimer = new Timer(1000);
						sendTimer.addEventListener(TimerEvent.TIMER, sendLoop);
						sendTimer.start();					
					}
				});			
			}
		}

		private function sendLoop(timeEvent:TimerEvent=null):void{
			var playedSeconds:Number = this._providers[this._mainVideoIndex].time;
			var videoSeconds:Number = this._providers[this._mainVideoIndex].videoLength;

			
			/*
			for(var i:int = 0; i <this._videoInfos.length ; i++){
				var streamTime:Number = this._providers[i].streamTime;
			}
			*/

			Facade.getInstance().sendNotification(
									Order.ControlBar_Update_Request, 
									{ "playedSeconds":playedSeconds, "videoSeconds":videoSeconds }
								);
			this.playedSeconds = playedSeconds;
		}

		public function get providers():Array{
			return this._providers;
		}

		public function get playedSeconds():Number{
			return this._playedSeconds;
		}

		public function set playedSeconds(sec:Number):void{
			this._playedSeconds = sec;
		}

		public function set mainVideoIndex(index:int):void{
			this._mainVideoIndex = index;
		}

		public function get mainVideoIndex():int{
			return this._mainVideoIndex;
		}

		public function get cameraVideoIndex():int{
			return this._cameraVideoIndex;
		}

		public function set cameraVideoIndex(index:int):void{
			this._cameraVideoIndex = index;
		}

		public function get cameraVideo():VideoProvider{
			return this._providers[this._cameraVideoIndex];
		}
	}
}