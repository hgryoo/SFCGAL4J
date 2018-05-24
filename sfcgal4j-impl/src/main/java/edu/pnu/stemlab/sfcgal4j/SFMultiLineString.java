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
@Platform(include = "cpp/SFMultiLineString.cpp", link = {"SFCGAL"})
public class SFMultiLineString extends SFGeometryCollection {
        static {
                Loader.load();
        }

        public SFMultiLineString() {
                allocate();
        }

        public SFMultiLineString(Pointer p) {
                super(p);
        }

        private native void allocate();

        @Name("operator=")
        public native @ByRef SFMultiLineString assign(@ByRef SFMultiLineString other);

        public native SFMultiLineString clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native @ByRef SFLineString lineStringN(@Cast("size_t") int n);

}
