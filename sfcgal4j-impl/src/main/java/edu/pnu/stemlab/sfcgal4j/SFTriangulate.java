package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.annotation.ByRef;
import org.bytedeco.javacpp.annotation.Platform;

/**
 * @author Donguk Seo
 *
 */
@Platform(include = "cpp/SFTriangulate.cpp", link = {"SFCGAL"})
public class SFTriangulate {
        static {
                Loader.load();
        }

        public static native void triangulatePolygon3D(@ByRef SFGeometry g,
                        @ByRef SFTriangulatedSurface triangulateSurface);

}
