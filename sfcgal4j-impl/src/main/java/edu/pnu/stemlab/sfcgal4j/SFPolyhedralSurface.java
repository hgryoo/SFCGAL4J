package edu.pnu.stemlab.sfcgal4j;

import java.util.ArrayList;

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
@Platform(include = "cpp/SFPolyhedralSurface.cpp", link = {"SFCGAL"})
public class SFPolyhedralSurface extends SFSurface {
        static {
                Loader.load();
        }

        public SFPolyhedralSurface() {
                allocate();
        }

        public SFPolyhedralSurface(ArrayList<SFPolygon> polygons) {
                PointerVector vector = new PointerVector(polygons.size());

                for (int i = 0; i < polygons.size(); i++) {
                        vector.get(i).put(polygons.get(i));
                }

                allocate(vector);
        }

        public SFPolyhedralSurface(Pointer p) {
                super(p);
        }

        private native void allocate();

        private native void allocate(@ByRef PointerVector p);

        @Name("operator=")
        public native @ByRef SFPolyhedralSurface assign(@ByRef SFPolyhedralSurface tr);

        public native SFPolyhedralSurface clone();

        public native @StdString String geometryType();

        public native int geometryTypeId();

        public native int dimension();

        public native int coordinateDimension();

        public native @Cast("bool") boolean isEmpty();

        public native @Cast("bool") boolean is3D();

        public native @Cast("bool") boolean isMeasured();

        public native @ByRef SFTriangulatedSurface toTriangulatedSurface();

        public native @Cast("size_t") int numPolygons();

        public native @ByRef SFPolygon polygonN(@Cast("size_t") int n);

        public native void addPolygon(SFPolygon polygon);

        public native void addPolygons(@ByRef SFPolyhedralSurface other);

        public native @Cast("size_t") int numGeometries();

        public native @ByRef SFPolygon geometryN(@Cast("size_t") int n);

}
