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
@Platform(include = "cpp/SFPoint.cpp", link = {"SFCGAL"})
public class SFPoint extends SFGeometry {
        static {
                Loader.load();
        }

        public SFPoint() {
                allocate();
        }

        public SFPoint(@ByRef SFCoordinate c) {
                allocate(c);
        }

        public SFPoint(double x, double y) {
                allocate(x, y);
        }

        public SFPoint(double x, double y, double z) {
                allocate(x, y, z);
        }

        public SFPoint(double x, double y, double z, double m) {
                allocate(x, y, z, m);
        }

        public SFPoint(Pointer p) {
                super(p);
        }

        private native void allocate();

        private native void allocate(@ByRef SFCoordinate c);

        private native void allocate(double x, double y, double z);

        private native void allocate(double x, double y);

        private native void allocate(double x, double y, double z, double m);

        @Name("operator=")
        public native @ByRef SFPoint assign(@ByRef SFPoint c);

        public native SFPoint clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native int dimension();

        public native int coordinateDimension();

        public native @Cast("bool") boolean isEmpty();

        public native @Cast("bool") boolean is3D();

        public native @Cast("bool") boolean isMeasured();

        public native double x();

        public native double y();

        public native double z();

        public native double m();

        public native void setM(double m);

        @Name("operator<")
        public native @Cast("bool") boolean isSmallerThan(@ByRef SFPoint p);

        @Name("operator==")
        public native @Cast("bool") boolean equals(@ByRef SFPoint p);

        @Name("operator!=")
        public native @Cast("bool") boolean notEquals(@ByRef SFPoint p);

        public native @ByRef SFCoordinate coordinate();

}
