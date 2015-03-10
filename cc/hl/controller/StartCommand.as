package cc.hl.controller
{
	import flash.display.Sprite;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import cc.hl.model.video.*;
	import cc.hl.view.video.*;
	import cc.hl.view.controlBar.*;
	import util.*;

	public class StartCommand extends SimpleCommand implements ICommand
	{
		public function StartCommand() {
			super();
		}

		override public function execute(param1:INotification): void {
			facade.registerMediator(new VideoMediator(new VideoView()));
			facade.registerMediator(new ControlBarMediator(new ControlBarView()));

			var mainLayer:Player = param1.getBody() as Player;
			this.initLayer(mainLayer);

			sendNotification(Order.Video_Start_Request, {"vid":"XODg1OTc2MzUy", "videoType":"youku", "startTime":0});
			sendNotification(Order.ControlBar_Show_Request);
		}

		private function initLayer(mainLayer:Player) : void {
			var _loc1_:Sprite = new Sprite();
			var _loc2_:Sprite = new Sprite();

			GlobalData.VIDEO_LAYER = _loc1_;
			GlobalData.CONTROL_BAR_LAYER = _loc2_;

			mainLayer.addChild(_loc1_);
			mainLayer.addChild(_loc2_);
		}
	}
}