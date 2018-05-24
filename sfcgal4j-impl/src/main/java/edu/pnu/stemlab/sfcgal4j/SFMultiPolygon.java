package edu.pnu.stemlab.sfcgal4j;

import org.bytedeco.javacpp.Loader;
import org.bytedeco.javacpp.Pointer;
import org.bytedeco.javacpp.annotation.ByRef;
import org.bytedeco.javacpp.annotation.Cast;
import org.bytedeco.javacpp.annotation.Name;
import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.StdString;

/**
 * @author Donguk Seo
 *
 */
@Platform(include = "cpp/SFMultiPolygon.cpp", link = {"SFCGAL"})
public class SFMultiPolygon extends SFGeometryCollection {
        static {
                Loader.load();
        }

        public SFMultiPolygon() {
                allocate();
        }

        public SFMultiPolygon(Pointer p) {
                super(p);
        }

        private native void allocate();

        @Name("operator=")
        public native @ByRef SFMultiPolygon assign(@ByRef SFMultiPolygon other);

        public native SFMultiPolygon clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native @ByRef SFPolygon polygonN(@Cast("size_t") int n);

}
