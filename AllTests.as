package {
    import asunit.framework.TestSuite;
    import cc.hl.model.video.platform.*;
    import cc.hl.view.video.part.*;
    import cc.hl.view.video.*;

    public class AllTests extends TestSuite {

        public function AllTests() {
            //addTest(new YoukuVideoInfoTest("testGetPartVideoInfo"));
        	//addTest(new FLVPartNetStreamTest("testInitStream"));
        	addTest(new HttpVideoProviderTest("testCreateHttpProvider"));
        }
    }
}