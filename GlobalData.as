package
{
	import flash.display.*;

	public class GlobalData extends Object
	{
		public function GlobalData() {
			super();
		}

		public static var VIDEO_LAYER:Sprite;
		public static var CONTROL_BAR_LAYER:Sprite;
		public static var STAGE:Stage;

		public static var root:Player;

		public static const MAX_USE_MEMORY_ARRAY:Array = [
														104857600,//100M
														209715200,//200M, 
														0x19000000, 
														int.MAX_VALUE//4G
													];//最大内存
	}
}