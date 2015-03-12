package cc.hl.view.camera{
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Mouse;
	
	import cc.hl.model.video.*;
	
	import util.*;
	import ui.CameraControl;

	public class CameraView extends Sprite{

		private var _cameraTitles:Array;
		private var _cameraBtns:Array;
		private var _providerIndex:int;
		private var _cameraControl:CameraControl;
		private var _cameraBtnsState:String = "hiding"; //摄像机列表状态

		public static const CAMERA_WIDTH = 192;
		public static const CAMERA_HEIGHT = 108;

		public function CameraView(){
			super();
		}

		public function initCamera(obj:Object) : void{
			this._cameraTitles = [];
			this._cameraBtns = [];

			this._cameraControl = new CameraControl();
			this._cameraControl.videoBg.visible = false;
			addChild(this._cameraControl);

			for (var i:int = 0; i < obj.length; i++) {
				this._cameraTitles[i] = obj[i].title;
				this._cameraBtns[i] = new CameraBtn(i);
				this._cameraControl.addChild(this._cameraBtns[i]);
				
				this._cameraBtns[i].x = this._cameraControl.switchBtn.x;
				this._cameraBtns[i].y = this._cameraControl.switchBtn.y + 57 + i*45;
				this._cameraBtns[i].scaleX = 0;

				this._cameraBtns[i].addEventListener(MouseEvent.CLICK, onCameraClick);
				this._cameraBtns[i].addEventListener(MouseEvent.MOUSE_OVER, onCameraOver);
				this._cameraBtns[i].addEventListener(MouseEvent.MOUSE_OUT, onCameraOut);
			}

			this._cameraControl.switchBtn.addEventListener(MouseEvent.CLICK, onSwitchBtnClicked);
		}

		private function onCameraClick(e:MouseEvent):void{
			dispatchEvent(new SkinEvent("CAMERA_CLICK", e.target.parent.number));
		}

		private function onCameraOver(e:MouseEvent):void {
			var index:int = e.target.parent.number;

			/*
			//当非播放的机位被划过时，显示子机位
			if (index != VideoPool.getInstance().mainVideoIndex){
				Mouse.cursor = "button";
				_cameraControl.videoBg.visible = true;

				//切换正在播放的机位视频
				if(index != VideoPool.getInstance().cameraVideoIndex) {
					if( VideoPool.getInstance().cameraVideo != null 
							&& VideoPool.getInstance().cameraVideo.parent != null){
						VideoPool.getInstance().cameraVideo.parent.removeChild(VideoPool.getInstance().cameraVideo);
					}

					VideoPool.getInstance().cameraVideoIndex = index;
				}

				this._cameraControl.videoBg.addChild(VideoPool.getInstance().cameraVideo);
				VideoPool.getInstance().cameraVideo.resize(CAMERA_WIDTH, CAMERA_HEIGHT);
				VideoPool.getInstance().cameraVideo.x = VideoPool.getInstance().cameraVideo.y = 2;
				VideoPool.getInstance().cameraVideo.time = VideoPool.getInstance().playedSeconds;
				VideoPool.getInstance().cameraVideo.playing = true;		
			}
			*/
		}

		private function onCameraOut(e:MouseEvent):void{
			this._cameraControl.videoBg.visible = false;
		}

		private function onSwitchBtnClicked(mouseEvent:MouseEvent) : void{
			if(this._cameraBtnsState == "hiding"){
				this._cameraBtnsState = "showing";
				for(var i:int = 0; i < this._cameraBtns.length; i++){
					this._cameraBtns[i].animateShow();
				}
			}
			else{
				this._cameraBtnsState = "hiding";
				for(var j:int = 0; j < this._cameraBtns.length; j++){
					this._cameraBtns[j].animateHide();
				}
			}
		}

		public function resize(w:Number, h:Number) : void{
			this.x = w - 100;
			this.y = 100;
		}
	}
}