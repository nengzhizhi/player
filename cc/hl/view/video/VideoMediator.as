package cc.hl.view.video {
	import flash.events.*;
	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.*;
	import cc.hl.model.video.*;

	public class VideoMediator extends Mediator implements IMediator{
		public function VideoMediator(obj:Object){
			super("VideoMediator", obj);
		}

		override public function listNotificationInterests() : Array {
			return [
					Order.Video_Start_Request,
					Order.Video_Play_Request,
					Order.Video_Pause_Request,
					Order.Video_Seek_Request,
					Order.Video_Switch_Request,
					Order.On_Resize
				];
		}

		override public function handleNotification(notify:INotification) : void{
			switch(notify.getName()){
				case Order.Video_Start_Request:
					this.onStartVideo(notify.getBody());
					break;
				case Order.Video_Play_Request:
					this.videoView.provider.playing = true;
					break;
				case Order.Video_Pause_Request:
					this.videoView.provider.playing = false;
					break;
				case Order.Video_Seek_Request:
					this.onSeekTime(notify.getBody());
					break;
				case Order.Video_Switch_Request:
					this.onSwitchVideo(notify.getBody());
					break;
				case Order.On_Resize:
					this.onResize(notify.getBody());
					break;
			}
		}

		protected function onStartVideo(obj:Object) : void {
			if(this.videoView.parent == null){
				GlobalData.VIDEO_LAYER.addChild(this.videoView);
			}
			this.videoView.setProvider(obj.index);
		}

		protected function onSwitchVideo(obj:Object):void{
			this.videoView.setProvider(obj.index);
			this.videoView.resize(GlobalData.root.stage.stageWidth, GlobalData.root.stage.stageHeight);
		}

		protected function onSeekTime(obj:Object):void{
			this.videoView.provider.time = obj.seekTime;
			VideoPool.getInstance().playedSeconds = obj.seekTime; // VideoPool的时间轴根据VideoInfos中第一个视频源来设置
		}

		protected function onResize(obj:Object):void{
			this.videoView.resize(obj.w, obj.h);
		}

		protected function get videoView() : VideoView {
			return viewComponent as VideoView;
		}			
	}
}