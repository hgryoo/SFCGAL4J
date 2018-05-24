
package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.BytePointer;
import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.annotation.ByRef;
import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.StdString;

/**
 * @author Hyung-Gyu Ryoo (hyungyu.ryoo@gmail.com)
 *
 */
@Platform(include = {"cpp/SFOSGSupport.cpp"}, link = {"SFCGAL", "SFCGAL-osg"})
public class SFOSGSupport {
    static {
        Loader.load();
    }

    public static native void writeOSGFile(@ByRef SFGeometry g, @StdString BytePointer filePath);
}