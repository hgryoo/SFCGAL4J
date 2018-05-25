package edu.pnu.stemlab.sfcgal4j;

import junit.framework.TestCase;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;

public class OperationTest extends TestCase {

    public void testMain() throws Exception {
        _testWriteOSG();
    }

    public void _testWriteOSG() throws Exception {
        SFPoint p1 = new SFPoint(0.0, 0.0, 0.0);
        SFPoint p2 = new SFPoint(0.0, 5.5, 2.5);
        SFPoint p3 = new SFPoint(5.5, 0.0, 1.1);
        SFLineString ls = new SFLineString(p1, p2);
        ls.addPoint(p3);
        ls.addPoint(p1);

        ArrayList<SFPoint> points = new ArrayList<SFPoint>();
        points.add(p2);
        points.add(p3);
        points.add(p1);
        points.add(p2);
        SFLineString ls1 = new SFLineString(points);

        SFPolygon polygon = new SFPolygon(ls);
        polygon.addInteriorRing(ls1);

        try {
            File file = new File("src/test/resources/osg_write_test.osg");
            if (!file.createNewFile()) {
                file.delete();
                file.createNewFile();
            }
            SFOSGSupport.writeOSGFile(polygon, file.getAbsolutePath());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
