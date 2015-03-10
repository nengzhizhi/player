package cc.hl.view.controlBar {
	import flash.display.*;
	import flash.events.*;
	
	import ui.ControlBar;

	public class ControlBarView extends Sprite {

		private var _controlBar:ControlBar;

		public function ControlBarView(){
			super();
			this._controlBar = new ControlBar();

			this._controlBar.playBtn.visible = false;
			this._controlBar.pauseBtn.visible = true;
			this._controlBar.timer.visible = false;

			this._controlBar.playBtn.addEventListener(MouseEvent.CLICK, this.onPlayBtnClicked);
			this._controlBar.pauseBtn.addEventListener(MouseEvent.CLICK, this.onPauseBtnClicked);

			addChild(this._controlBar);
			addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
		}

		private function onAddToStage(event:Event) : void {
			

		}

		public static const CONTROL_BAR_HEIGHT:int = 40;

		public function resize(w:Number, h:Number) : void{
			this._controlBar.background.width = w;
			this._controlBar.background.height = h;
			this._controlBar.y = GlobalData.root.stage.stageHeight - CONTROL_BAR_HEIGHT;
		}


		protected function onPlayBtnClicked(event:MouseEvent) : void{
			this._controlBar.playBtn.visible = false;
			this._controlBar.pauseBtn.visible = true;
			dispatchEvent(new Event("CONTROL_BAR_PLAY"));
		}

		protected function onPauseBtnClicked(event:MouseEvent):void{
			this._controlBar.playBtn.visible = true;
			this._controlBar.pauseBtn.visible = false;
			dispatchEvent(new Event("CONTROL_BAR_PAUSE"));
		}

		public function get controlBar():ControlBar{
			return this._controlBar;
		}
	}
}