package {
    import asunit.framework.TestSuite;
    import cc.hl.model.video.platform.*;

    public class AllTests extends TestSuite {

        public function AllTests() {
            addTest(new YoukuVideoInfoTest("testGetPartVideoInfo"));
        }
    }
}