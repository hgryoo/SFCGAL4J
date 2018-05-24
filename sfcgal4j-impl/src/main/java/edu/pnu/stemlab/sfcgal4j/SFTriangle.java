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
@Platform(include = {"cpp/SFTriangle.cpp"}, link = {"SFCGAL"})
public class SFTriangle extends SFSurface {
        static {
                Loader.load();
        }

        public SFTriangle() {
                allocate();
        }

        public SFTriangle(SFPoint p, SFPoint q, SFPoint r) {
                allocate(p, q, r);
        }

        public SFTriangle(Pointer p) {
                super(p);
        }

        private native void allocate();

        private native void allocate(@ByRef SFPoint p, @ByRef SFPoint q, @ByRef SFPoint r);

        @Name("operator=")
        public native @ByRef SFTriangle assign(@ByRef SFTriangle tr);

        public native SFTriangle clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native int dimension();

        public native int coordinateDimension();

        public native @Cast("bool") boolean isEmpty();

        public native @Cast("bool") boolean is3D();

        public native @Cast("bool") boolean isMeasured();

        public native void reverse();

        public native @ByRef SFPolygon toPolygon();

        public native @ByRef SFPoint vertex(int i);

}
