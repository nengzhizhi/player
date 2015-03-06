package cc.hl.model.video.base {
	
	import flash.events.*;
	import flash.utils.*;
	import util.*;
	import cc.hl.model.video.interfaces.*;
	
	public class VideoInfo extends EventDispatcher implements IVideoInfo{

		protected var _vid:String;
		protected var _type:String; //视频源类型
		protected var _fileType:String; //视频文件类型flv或者mp4
		protected var _useSecond:Boolean;//
		protected var _startParamName:String = "start";
		protected var _urlArray:Array;
		protected var _vtimems:Array;


		public function VideoInfo(videoId:String, videoType:String){
			this._vid = videoId;
			this._type = videoType;
		}


		/**
		 * 载入视频信息。
		 * 需要重载
		**/
		protected function load():void{
			return;
		}

		/**
		 * 载入指定的partNetStream需要的VideoInfo,获得videoInfo后让partNetStream回调
		 * @param f	partNetStream的回调函数，从获取的videoInfo中载入视频
		 * @param index
		 * @param startTime
		 * @return 空
		**/
		public function getPartVideoInfo(f:Function, index:int, startTime:Number=0):void{
			return;
		}

		public function get vid():String{
			return this._vid;
		}

		public function get vtimes():Array{
			return this._vtimems;
		}

		public function get urlArray():Array{
			return this._urlArray;
		}

		public function get useSecond():Boolean{
			return this._useSecond;
		}
	}
}