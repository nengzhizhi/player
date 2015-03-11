package cc.hl.view.video {

	import flash.display.*;
	import flash.media.*;
	import flash.utils.*;
	import flash.events.*;
	
	import cc.hl.model.video.base.*;
	import cc.hl.model.video.platform.*;
	import cc.hl.model.video.*;
	
	public class VideoView extends Sprite {
		private var _providerIndex:int;

		public function VideoView(){
			super();
		}

		public function setProvider(index:int):void{

			if(this._providerIndex != index){
				if(this.provider != null) {
					this.provider.playing = false;
					this.provider.parent.removeChild(this.provider);
				}
			}

			this._providerIndex = index;
			this.provider.time = VideoPool.getInstance().playedSeconds;
			this.provider.playing = true;
			addChild(this.provider);

			return;
		}

		public function resize(w:Number, h:Number):void{
			this.provider.resize(w, h);
		}

		public function get provider():VideoProvider{
			return VideoPool.getInstance().providers[this._providerIndex];
		}

		public function set providerIndex(index:int):void{
			this._providerIndex = index;
		}

		public function get providerIndex():int{
			return this._providerIndex;
		}	
	}
}