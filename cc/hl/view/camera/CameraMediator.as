package cc.hl.view.camera {
	import flash.events.*;

	import org.puremvc.as3.interfaces.*;
	import org.puremvc.as3.patterns.mediator.*;
	import util.*;

	public class CameraMediator extends Mediator implements IMediator{
		public function CameraMediator(obj:Object){
			super("CameraMediator", obj);
		}

		override public function listNotificationInterests():Array{
			return [
					Order.Camera_Init_Request,
					Order.On_Resize
				];
		}

		override public function handleNotification(notify:INotification):void{
			switch(notify.getName()){
				case Order.Camera_Init_Request:
					this.onInitCamera(notify.getBody());
					break;
				case Order.On_Resize:
					this.onResize(notify.getBody());
					break;
			}
		}

		protected function addListener():void{
			if(!this.cameraView.hasEventListener("CAMERA_CLICK")){
				this.cameraView.addEventListener("CAMERA_CLICK", function(e:SkinEvent){
					sendNotification(Order.Video_Switch_Request, {"index":e.data});
				});
			}
		}

		protected function onInitCamera(obj:Object) : void{
			if(this.cameraView.parent == null){
				GlobalData.CAMERA_LAYER.addChild(this.cameraView);
			}
			this.addListener();
			this.cameraView.resize(GlobalData.root.stage.stageWidth, GlobalData.root.stage.stageHeight);
			this.cameraView.initCamera(obj);
		}

		public function onResize(obj:Object):void{
			this.cameraView.resize(obj.w, obj.h);
		}

		public function get cameraView() : CameraView {
			return viewComponent as CameraView;
		}		
	}
}