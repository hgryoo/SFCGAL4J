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
@Platform(include = "cpp/SFMultiSolid.cpp", link = {"SFCGAL"})
public class SFMultiSolid extends SFGeometryCollection {
        static {
                Loader.load();
        }

        public SFMultiSolid() {
                allocate();
        }

        public SFMultiSolid(Pointer p) {
                super(p);
        }

        private native void allocate();

        @Name("operator=")
        public native @ByRef SFMultiSolid assign(@ByRef SFMultiSolid other);

        public native SFMultiSolid clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native @ByRef SFSolid solidN(@Cast("size_t") int n);

}
