package cc.hl.view.video.part {
	
	public class FLVPartNetStream extends PartNetStream{

		protected var _startOffset:Number = 0; // 开始时间，之前码流时间和
		protected var _filesize:Number = 0;

		public function FLVPartNetStream(arg1:NetConnection){
			super(arg1);
		}

		/**
		 * 
		**/
		override public function get time():Number{

		}

		/**
		 * 定位到已缓存的时刻
		 * @param arg1	需要定位的时间点
		 * @return void
		**/
		override public function seek(arg1:Number):void{
			var local2:Number = arg1 + this._startOffset;
			var local3:Number = bufferSeconds + this._startOffset;

			local2 = local2 < local3 ? local2 : local3;

			if (Math.abs(local2 - super.time) > 1){
				super.seek(local2);
			}
		}

		/**
		 * 从meta中读取最接近的关键帧的时间
		 * @param arg1	需要seek的时间
		 * @return 最接近的关键帧的时间，可以从这个时间点开始load stream
		**/
		override public function getRealSeekTime(arg1:Number):Number{
			var local2:int;

			if(this._meta && this._meta.keyframes){
				local2 = Util.bsearch(this._meta.keyframes.times, arg1 + this._startOffset);
				arg1 = this._meta.keyframes.times[local2 - 1] - this._startOffset;
			}

			return arg1;
		}

		override protected function onMetaData(arg1:Object):void{
			var local2:Object;
			var local3:Object;
			this._meta = arg1;

			if(arg1.seekpoints){
				local2 = {
					times:[],
					filepositions:[]
				}

				for each (local3 in arg1.seekpoints) {
					local2.times.push(local3.time);
					local2.filepositions.push(local3.offset);
				}
				arg1.keyframes = local2;
			}

			if(this._meta.keyframes){
				if(this._meta.keyframes.times[1] > 30){
					this._startOffset = this._meta.keyframes.times[1];
				}

				this._filesize = (this._meta.filesize) || (this._meta.keyframes.filepositions.slice(-1)[0]);
			}
		}
	}
}