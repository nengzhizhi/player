package{
	public class Order extends Object
	{
		public function Order()
		{
			super();
		}

		public static var On_Resize:String = "On_Resize";

		//video中使用request
		public static var Video_Start_Request = "Video_Start_Request";
		public static var Video_Play_Request = "Video_Play_Request";
		public static var Video_Pause_Request = "Video_Pause_Request";

		//controlBar
		public static var ControlBar_Show_Request = "ControlBar_Show_Request";
		public static var ControlBar_Update_Request = "ControlBar_Update_Request";
	}
}