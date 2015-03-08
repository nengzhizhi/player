package {
    import asunit.framework.TestSuite;
    import cc.hl.model.video.platform.*;
    import cc.hl.view.video.part.*;

    public class AllTests extends TestSuite {

        public function AllTests() {
            //addTest(new YoukuVideoInfoTest("testGetPartVideoInfo"));
        	addTest(new FLVPartNetStreamTest("testInitStream"));
        }
    }
}