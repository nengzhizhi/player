package {
	public class PlayerConfig{
		private static var _instance:PlayerConfig;

		public max_use_memory_level:int = 0;

		public function PlayerConfig():void{
			if(this._instance != null){
				throw (new Error("请使用getInstance()获取实例")); 
			}
		}

		public function getInstance():PlayerConfig {
			if(this._instance == null){
				this._instance = new PlayerConfig();
				this._instance.init();
			}
			return this._instance;
		}

		private function init():void{
			
		}
	}
}