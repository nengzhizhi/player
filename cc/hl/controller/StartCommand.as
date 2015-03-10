package cc.hl.controller
{
	import flash.display.Sprite;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import cc.hl.model.video.*;
	import cc.hl.view.video.*;
	import cc.hl.view.controlBar.*;
	import cc.hl.view.danmu.*;
	import util.*;

	public class StartCommand extends SimpleCommand implements ICommand
	{
		public function StartCommand() {
			super();
		}

		override public function execute(param1:INotification): void {
			facade.registerMediator(new VideoMediator(new VideoView()));
			facade.registerMediator(new ControlBarMediator(new ControlBarView()));
			facade.registerMediator(new DanmuMediator(new DanmuView()));

			var mainLayer:Player = param1.getBody() as Player;
			this.initLayer(mainLayer);

			sendNotification(Order.Video_Start_Request, {"vid":"XODg1OTc2MzUy", "videoType":"youku", "startTime":0});
			sendNotification(Order.ControlBar_Show_Request);
			sendNotification(Order.Danmu_Init_Request);
			//FIXME delte me
			sendNotification(Order.Danmu_Add_Request,{"message":"123"});
		}

		private function initLayer(mainLayer:Player) : void {
			var videoLayer:Sprite = new Sprite();
			var controlBarLayer:Sprite = new Sprite();
			var danmuLayer:Sprite = new Sprite();

			GlobalData.VIDEO_LAYER = videoLayer;
			GlobalData.CONTROL_BAR_LAYER = controlBarLayer;
			GlobalData.DANMU_LAYER = danmuLayer;

			mainLayer.addChild(videoLayer);
			mainLayer.addChild(controlBarLayer);
			mainLayer.addChild(danmuLayer);
		}
	}
}