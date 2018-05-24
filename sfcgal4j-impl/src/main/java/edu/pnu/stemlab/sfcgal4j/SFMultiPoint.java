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
@Platform(include = "cpp/SFMultiPoint.cpp", link = {"SFCGAL"})
public class SFMultiPoint extends SFGeometryCollection {
        static {
                Loader.load();
        }

        public SFMultiPoint() {
                allocate();
        }

        public SFMultiPoint(Pointer p) {
                super(p);
        }

        private native void allocate();

        @Name("operator=")
        public native @ByRef SFMultiPoint assign(@ByRef SFMultiPoint other);

        public native SFMultiPoint clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native @ByRef SFPoint pointN(@Cast("size_t") int n);

}
