package cc.hl.controller
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;

	import flash.display.Sprite;

	import util.*;

	public class StartCommand extends SimpleCommand implements ICommand
	{
		public function StartCommand() {
			super();
		}

		override public function execute(param1:INotification): void {
			var mainLayer:Player = param1.getBody() as Player;
			this.initLayer(mainLayer);
		}

		private function initLayer(mainLayer:WebRoom) : void {
			var _loc1_:Sprite = new Sprite();

			GlobalData.VIDEOLAYER = _loc1_;

			mainLayer.addChild(_loc1_);
		}
	}
}