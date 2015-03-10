package cc.hl.view.controlBar {
	import flash.display.*;
	import flash.events.*;
	
	import ui.ControlBar;

	public class ControlBarView extends Sprite {

		private var _controlBar:ControlBar;
		private var _videoSeconds:Number = 0;
		private var _progressBar:VideoProgressBar;

		public function ControlBarView(){
			super();
			this._controlBar = new ControlBar();

			this._controlBar.playBtn.visible = false;
			this._controlBar.pauseBtn.visible = true;
			this._controlBar.timer.visible = true;
			this._controlBar.fullScreenBtn.visible = true;
			this._controlBar.normalScreenBtn.visible = false;
			this._controlBar.danmuShowBtn.visible = true;
			this._controlBar.danmuHideBtn.visible = false;

			this._controlBar.playBtn.addEventListener(MouseEvent.CLICK, this.onPlayBtnClicked);
			this._controlBar.pauseBtn.addEventListener(MouseEvent.CLICK, this.onPauseBtnClicked);
			this._controlBar.fullScreenBtn.addEventListener(MouseEvent.CLICK, this.onFullScreen);
			this._controlBar.normalScreenBtn.addEventListener(MouseEvent.CLICK, this.onNormalScreen);
			this._controlBar.danmuShowBtn.addEventListener(MouseEvent.CLICK, this.onDanmuShow);
			this._controlBar.danmuHideBtn.addEventListener(MouseEvent.CLICK, this.onDanmuHide);
			(this._controlBar.danmuTag as MovieClip).gotoAndStop(1);

			addChild(this._controlBar);

			this._progressBar = new VideoProgressBar();
			this._controlBar.addChildAt(this._progressBar, this._controlBar.getChildIndex(this._controlBar.playBtn));

			addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
		}

		private function onAddToStage(event:Event) : void {
			

		}

		public static const CONTROL_BAR_HEIGHT:int = 40;

		public function resize(w:Number, h:Number) : void{
			this._controlBar.background.width = w;
			this._controlBar.background.height = h;
			this._controlBar.fullScreenBtn.x = this._controlBar.background.width - this._controlBar.fullScreenBtn.width - 20;
			this._controlBar.normalScreenBtn.x = this._controlBar.background.width - this._controlBar.normalScreenBtn.width - 20;
			this._controlBar.danmuTag.x = this._controlBar.fullScreenBtn.x - 70;
			this._controlBar.danmuShowBtn.x = this._controlBar.danmuTag.x - 30;
			this._controlBar.danmuHideBtn.x = this._controlBar.danmuTag.x - 30;
			this._controlBar.y = GlobalData.root.stage.stageHeight - CONTROL_BAR_HEIGHT;



			if(this.progressBar != null){
				this.progressBar.setWidth(w);
			}
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

		protected function onFullScreen(event:MouseEvent):void{
			this._controlBar.fullScreenBtn.visible = false;
			this._controlBar.normalScreenBtn.visible = true;
			dispatchEvent(new Event("CONTROL_BAR_FULLSCREEN"));
		}

		protected function onNormalScreen(event:MouseEvent):void{
			this._controlBar.fullScreenBtn.visible = true;
			this._controlBar.normalScreenBtn.visible = false;
			dispatchEvent(new Event("CONTROL_BAR_NORMALSCREEN"));
		}

		protected function onDanmuShow(event:MouseEvent):void{
			this._controlBar.danmuShowBtn.visible = false;
			this._controlBar.danmuHideBtn.visible = true;
			(this._controlBar.danmuTag as MovieClip).gotoAndStop(2);
			dispatchEvent(new Event("CONTROL_BAR_HIDE_DANMU"));
		}

		protected function onDanmuHide(event:MouseEvent):void{
			this._controlBar.danmuShowBtn.visible = true;
			this._controlBar.danmuHideBtn.visible = false;
			(this._controlBar.danmuTag as MovieClip).gotoAndStop(1);
			dispatchEvent(new Event("CONTROL_BAR_SHOW_DANMU"));
		}

		public function get controlBar():ControlBar{
			return this._controlBar;
		}

		public function set videoSeconds(s:Number):void{
			this._videoSeconds = s;
		}

		public function get videoSeconds():Number{
			return this._videoSeconds;
		}

		public function set progressBar(p:VideoProgressBar):void{
			this._progressBar = p;
		}

		public function get progressBar():VideoProgressBar{
			return this._progressBar;
		}
	}
}