package cc.hl.view.video {

	import flash.events.*;
	import flash.net.*;
	import flash.display.*;
	import flash.media.*;
	import asunit.framework.TestCase;
	import cc.hl.model.video.base.*;
	import cc.hl.model.video.platform.*;

	public class HttpVideoProviderTest extends TestCase{
		public function HttpVideoProviderTest(methodName:String=null) {
			super(methodName);
		}

		override protected function setUp():void{
			super.setUp();
		}
		override protected function tearDown():void{
			super.tearDown();
		}

		public function testCreateHttpProvider():void{
			var youkuVideoInfo:YoukuVideoInfo = new YoukuVideoInfo("XODg1OTc2MzUy");
			youkuVideoInfo.init();
			youkuVideoInfo.addEventListener(Event.COMPLETE,function():void{
				var provider:VideoProvider = new HttpVideoProvider(youkuVideoInfo);
				provider.start(0);
				addChild(provider);
			});
		}
	}
}