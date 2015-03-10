package cc.hl.view.video {

	import flash.display.*;
	import flash.media.*;
	import flash.utils.*;
	import flash.events.*;
	
	import cc.hl.model.video.base.*;
	import cc.hl.model.video.platform.*;
	

	public class VideoView extends Sprite {

		private var _provider:VideoProvider;
		private var _videoInfo;
		private var sendTimer:Timer;

		public function VideoView(){}


		public function startVideo(vid:String, videoType:String, startTime:Number=0):void{
			switch(videoType){
				case VideoType.YOUKU:
					this._videoInfo = new YoukuVideoInfo(vid);
					this._videoInfo.init();
				break;
			}

			this._videoInfo.addEventListener(Event.COMPLETE, function(e:Event):void{
				var arguments:* = arguments;
				_videoInfo.removeEventListener(Event.COMPLETE, arguments.callee);
				if (_videoInfo.fileType == "live"){
					_provider = null;
				}
				else{
					_provider = new HttpVideoProvider(_videoInfo);
				}
				_provider.start(startTime);
				addChild(_provider);

				sendTimer = new Timer(500);
				sendTimer.addEventListener(TimerEvent.TIMER, sendLoop);
				sendTimer.start();

				dispatchEvent(new Event("VIDEO_INFO_LOADED"));
			});
		}

		private function sendLoop(event:TimerEvent=null):void{
			dispatchEvent(new Event("VIDEO_LOOP"));
		}

		public function get provider():VideoProvider{
			return this._provider;
		}

		public function resize(w:Number, h:Number):void{
			this._provider.resize(w, h);
		}
	}	
}