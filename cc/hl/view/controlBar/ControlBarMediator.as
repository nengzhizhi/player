package cc.hl.view.controlBar {
	import flash.events.*;
	
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.*;
	
	import util.*;

	public class ControlBarMediator extends Mediator implements IMediator{
		public function ControlBarMediator(obj:Object){
			super("ControlBarMediator", obj);
		}

		override public function listNotificationInterests(): Array{
			return [
				Order.ControlBar_Show_Request,
				Order.ControlBar_Update_Request,
				Order.On_Resize
			];
		}

		override public function handleNotification(notify:INotification) : void{
			switch(notify.getName()){
				case Order.ControlBar_Show_Request:
					this.onControlBarShow();
					break;
				case Order.ControlBar_Update_Request:
					this.onUpdateTime(notify.getBody());
					break;
				case Order.On_Resize:
					this.onResize(notify.getBody());
					break;
			}
		}

		private function addListener() : void{
			if(!this.controlBarView.hasEventListener("CONTROL_BAR_PLAY")){
				this.controlBarView.addEventListener("CONTROL_BAR_PLAY", this.onPlay);
				this.controlBarView.addEventListener("CONTROL_BAR_PAUSE", this.onPause);
			}
		}

		protected function onControlBarShow() : void{
			if(this.controlBarView.parent == null){
				GlobalData.CONTROL_BAR_LAYER.addChild(this.controlBarView);
				this.addListener();
			}
			this.controlBarView.resize(GlobalData.root.stage.stageWidth, GlobalData.root.stage.stageHeight);
		}

		protected function onResize(obj:Object) : void{
			if(this.controlBarView.parent != null){
				this.controlBarView.resize(obj.w, obj.h);
			}
		}

		private function onPlay(event:Event) : void {
			sendNotification(Order.Video_Play_Request, null);
		}

		private function onPause(event:Event) : void {
			sendNotification(Order.Video_Pause_Request, null);
		}

		private function onUpdateTime(obj:Object) : void {
			var playedSeconds:Number = obj.playedSeconds;
			var videoSeconds:Number = obj.videoSeconds;

			if (videoSeconds > 0) {
				
				this.controlBarView.controlBar.timer.visible = true;
				
				this.controlBarView.controlBar.timer.playedSeconds.text = Util.digits(playedSeconds);
				this.controlBarView.controlBar.timer.videoSeconds.text = "/ " + Util.digits(videoSeconds);
				
			}
		}

		public function get controlBarView() : ControlBarView {
			return viewComponent as ControlBarView;
		}		
	}
}