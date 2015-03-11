package cc.hl.view.camera {

	import flash.display.*;
	import flash.events.*;

	import com.greensock.TweenLite;
	import com.greensock.easing.Cubic;

	import ui.CameraBtn1;
	import ui.CameraBtn2;
	import ui.CameraBtn3;
	import ui.CameraBtn4;

	public class CameraBtn extends Sprite{

		private var _btn;
		private var _number:int;
		private var _animate:TweenLite;

		public function CameraBtn(btnNumber:int){
			if(btnNumber == 0){
				this._btn = new CameraBtn1();
			}
			else if(btnNumber == 1){
				this._btn = new CameraBtn2();
			}
			else if(btnNumber == 2){
				this._btn = new CameraBtn3();
			}
			else if(btnNumber == 3){
				this._btn = new CameraBtn4();
			}

			(this._btn as MovieClip).gotoAndStop(1);
			this._number = btnNumber;
			this.addListener();
			this.onUnSelect();
			addChild(this._btn);
		}

		protected function addListener():void{
			if(!this._btn.hasEventListener(MouseEvent.CLICK)){
				this._btn.addEventListener(MouseEvent.CLICK, this.onBtnClicked);
				this._btn.addEventListener(MouseEvent.MOUSE_OVER, this.onBtnMoved);
				this._btn.addEventListener(MouseEvent.MOUSE_OUT, this.onBtnOutted);
			}
		}

		protected function removeListener():void{
			if(this._btn.hasEventListener(MouseEvent.CLICK)){
				this._btn.removeEventListener(MouseEvent.CLICK, this.onBtnClicked);
				this._btn.removeEventListener(MouseEvent.MOUSE_OVER, this.onBtnMoved);
				this._btn.removeEventListener(MouseEvent.MOUSE_OUT, this.onBtnOutted);	
			}	
		}

		protected function onBtnClicked(e:MouseEvent):void{
			(this._btn as MovieClip).gotoAndStop(3);
		}

		protected function onBtnMoved(e:MouseEvent):void{
			(this._btn as MovieClip).gotoAndStop(2);
		}

		protected function onBtnOutted(e:MouseEvent):void{
			(this._btn as MovieClip).gotoAndStop(1);
		}

		public function onSelect():void{
			this.removeListener();
			(this._btn as MovieClip).gotoAndStop(3);
		}

		public function onUnSelect():void{
			this.addListener();
			(this._btn as MovieClip).gotoAndStop(1);
		}

		public function animateShow(){
			if(this._animate){
				this._animate.kill();
			}

			this._animate = TweenLite.to(this,0.5,{
				"scaleX":1,
				"ease":Cubic.easeOut
			});
		}

		public function animateHide(){
			if(this._animate){
				this._animate.kill();
			}

			this._animate = TweenLite.to(this,0.5,{
				"scaleX":0,
				"ease":Cubic.easeOut
			});			
		}

		public function get number():int{
			return this._number;
		}
	}
}